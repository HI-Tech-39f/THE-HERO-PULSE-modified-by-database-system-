using System;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class ReceptorDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Recipient")
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadMyRequests();
            }
        }

        private int GetRecipientId()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int recId = 0;
            string query = "SELECT RecipientID FROM Recipients WHERE UserID = @uid";
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", userId);
                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null) recId = Convert.ToInt32(result);
            }
            return recId;
        }

        private void LoadMyRequests()
        {
            int recipientId = GetRecipientId();

            string query = @"
                SELECT r.RequestID, r.RequestDate, bg.GroupName, r.Urgency, r.Status,
                       COALESCE(du.Username, 'Waiting for Hero...') AS DonorName,
                       COALESCE(du.Email, 'N/A') AS DonorContact
                FROM Donation_Requests r
                JOIN Blood_Groups bg ON r.GroupID = bg.GroupID
                LEFT JOIN Request_Matches rm ON r.RequestID = rm.RequestID AND rm.Status = 'Accepted'
                LEFT JOIN Donors d ON rm.DonorID = d.DonorID
                LEFT JOIN Users du ON d.UserID = du.UserID
                WHERE r.RecipientID = @recId
                ORDER BY r.RequestDate DESC";

            DataTable dt = new DataTable();
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@recId", recipientId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
            }
            gvMyRequests.DataSource = dt;
            gvMyRequests.DataBind();
        }

        protected void btnRequest_Click(object sender, EventArgs e)
        {
            int recipientId = GetRecipientId();
            int requestedGroupId = Convert.ToInt32(ddlBloodGroup.SelectedValue);
            string urgency = ddlUrgency.SelectedValue;

            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    conn.Open();
                    string insertReqQuery = "INSERT INTO Donation_Requests (RecipientID, GroupID, Urgency, Status) VALUES (@recId, @gid, @urgency, 'Pending'); SELECT LAST_INSERT_ID();";
                    MySqlCommand cmdReq = new MySqlCommand(insertReqQuery, conn);
                    cmdReq.Parameters.AddWithValue("@recId", recipientId);
                    cmdReq.Parameters.AddWithValue("@gid", requestedGroupId);
                    cmdReq.Parameters.AddWithValue("@urgency", urgency);
                    int newRequestId = Convert.ToInt32(cmdReq.ExecuteScalar());

                    string findDonorsQuery = @"
                        SELECT d.DonorID 
                        FROM Donors d
                        JOIN Blood_Compatibility bc ON d.GroupID = bc.DonorGroupID
                        WHERE bc.RecipientGroupID = @requestedGroupId
                        AND (d.LastDonationDate IS NULL OR DATEDIFF(CURDATE(), d.LastDonationDate) >= 90)";

                    MySqlCommand cmdFind = new MySqlCommand(findDonorsQuery, conn);
                    cmdFind.Parameters.AddWithValue("@requestedGroupId", requestedGroupId);

                    bool hasMatches = false;
                    string matchInsertQuery = "INSERT INTO Request_Matches (RequestID, DonorID, Status) VALUES ";

                    using (MySqlDataReader reader = cmdFind.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int donorId = Convert.ToInt32(reader["DonorID"]);
                            matchInsertQuery += $"({newRequestId}, {donorId}, 'Pending'),";
                            hasMatches = true;
                        }
                    }

                    if (hasMatches)
                    {
                        matchInsertQuery = matchInsertQuery.TrimEnd(',');
                        MySqlCommand cmdMatch = new MySqlCommand(matchInsertQuery, conn);
                        cmdMatch.ExecuteNonQuery();
                        ShowMessage("Request Broadcasted! Compatible donors have been alerted.", true);
                    }
                    else
                    {
                        ShowMessage("Request Created, but currently no eligible compatible donors found.", false);
                    }
                    LoadMyRequests();
                }
                catch (Exception ex)
                {
                    ShowMessage("System Error: " + ex.Message, false);
                }
            }
        }

        // ==========================================
        // 🚨 UPDATED LOGIC: Update Donor Profile when Patient receives blood
        // ==========================================
        protected void gvMyRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MarkCompleted")
            {
                int requestId = Convert.ToInt32(e.CommandArgument);

                using (MySqlConnection conn = Connection.GetConnection())
                {
                    conn.Open();
                    MySqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        // 1. Pehle dhoondo ke kis Donor ne is request ko 'Accept' kiya tha
                        string findDonorQuery = "SELECT DonorID FROM Request_Matches WHERE RequestID = @reqId AND Status = 'Accepted' LIMIT 1";
                        MySqlCommand cmdFind = new MySqlCommand(findDonorQuery, conn, transaction);
                        cmdFind.Parameters.AddWithValue("@reqId", requestId);
                        object donorResult = cmdFind.ExecuteScalar();

                        // Agar koi donor milta hai (yaani kisi ne system se accept ki thi)
                        if (donorResult != null && donorResult != DBNull.Value)
                        {
                            int donorId = Convert.ToInt32(donorResult);

                            // A. Donor ko uski "Donations" history mein add karo (HospitalID NULL jayega)
                            string q1 = "INSERT INTO Donations (DonorID, HospitalID, RequestID, DonationDate) VALUES (@did, NULL, @reqid, CURDATE())";
                            MySqlCommand cmd1 = new MySqlCommand(q1, conn, transaction);
                            cmd1.Parameters.AddWithValue("@did", donorId);
                            cmd1.Parameters.AddWithValue("@reqid", requestId);
                            cmd1.ExecuteNonQuery();

                            // B. Match ko 'Completed' mark karo
                            string q2 = "UPDATE Request_Matches SET Status = 'Completed' WHERE RequestID = @reqid AND DonorID = @did";
                            MySqlCommand cmd2 = new MySqlCommand(q2, conn, transaction);
                            cmd2.Parameters.AddWithValue("@reqid", requestId);
                            cmd2.Parameters.AddWithValue("@did", donorId);
                            cmd2.ExecuteNonQuery();

                            // C. Donor ki LastDonationDate ko aaj ki date set karo (Start 90-days rule)
                            string q3 = "UPDATE Donors SET LastDonationDate = CURDATE() WHERE DonorID = @did";
                            MySqlCommand cmd3 = new MySqlCommand(q3, conn, transaction);
                            cmd3.Parameters.AddWithValue("@did", donorId);
                            cmd3.ExecuteNonQuery();
                        }

                        // 2. Original Request ko 'Fulfilled' mark kar do
                        string q4 = "UPDATE Donation_Requests SET Status = 'Fulfilled' WHERE RequestID = @reqid";
                        MySqlCommand cmd4 = new MySqlCommand(q4, conn, transaction);
                        cmd4.Parameters.AddWithValue("@reqid", requestId);
                        cmd4.ExecuteNonQuery();

                        // Sab kuch successfully ho gaya, Commit kar do
                        transaction.Commit();

                        ShowMessage("Glad you received the blood! The request is fulfilled and the Hero's profile has been updated.", true);
                        LoadMyRequests();
                    }
                    catch (Exception ex)
                    {
                        // Agar koi error aye toh wapas pehle jaisa kar do
                        transaction.Rollback();
                        ShowMessage("Error updating status: " + ex.Message, false);
                    }
                }
            }
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            lblMessage.Text = msg;
            lblMessage.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
        }
    }
}