using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class RequestBlood : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Hospital")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadActiveRequests();
            }
        }

        private int GetHospitalId()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int hid = 0;
            string query = "SELECT HospitalID FROM Hospitals WHERE UserID = " + userId;
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null) hid = Convert.ToInt32(result);
            }
            return hid;
        }

        private void LoadActiveRequests()
        {
            int hospitalId = GetHospitalId();
            string query = @"
                SELECT r.RequestDate, bg.GroupName, r.Urgency, r.Status 
                FROM Donation_Requests r
                JOIN Blood_Groups bg ON r.GroupID = bg.GroupID
                WHERE r.HospitalID = @hid AND r.Status != 'Fulfilled'
                ORDER BY r.RequestDate DESC";

            DataTable dt = new DataTable();
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@hid", hospitalId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
            }
            gvRequests.DataSource = dt;
            gvRequests.DataBind();
        }

        protected void btnRequest_Click(object sender, EventArgs e)
        {
            int hospitalId = GetHospitalId();
            int requestedGroupId = Convert.ToInt32(ddlBloodGroup.SelectedValue);
            string urgency = ddlUrgency.SelectedValue;

            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    conn.Open();

                    // Step 1: Request Generate Karein
                    string insertReqQuery = "INSERT INTO Donation_Requests (HospitalID, GroupID, Urgency, Status) VALUES (@hid, @gid, @urgency, 'Pending'); SELECT LAST_INSERT_ID();";
                    MySqlCommand cmdReq = new MySqlCommand(insertReqQuery, conn);
                    cmdReq.Parameters.AddWithValue("@hid", hospitalId);
                    cmdReq.Parameters.AddWithValue("@gid", requestedGroupId);
                    cmdReq.Parameters.AddWithValue("@urgency", urgency);

                    int newRequestId = Convert.ToInt32(cmdReq.ExecuteScalar());

                    // Step 2: AUTO-MATCHING ENGINE (The Magic!)
                    // Aise donors dhoondo jo 1) Compatible hon 2) Active hon 3) 90-Days rule clear kar chuke hon
                    string findDonorsQuery = @"
                        SELECT d.DonorID 
                        FROM Donors d
                        JOIN Blood_Compatibility bc ON d.GroupID = bc.DonorGroupID
                        WHERE bc.RecipientGroupID = @requestedGroupId
                        AND (d.LastDonationDate IS NULL OR DATEDIFF(CURDATE(), d.LastDonationDate) >= 90)";

                    MySqlCommand cmdFind = new MySqlCommand(findDonorsQuery, conn);
                    cmdFind.Parameters.AddWithValue("@requestedGroupId", requestedGroupId);

                    using (MySqlDataReader reader = cmdFind.ExecuteReader())
                    {
                        // Step 3: Match Table mein entries daalo
                        string matchInsertQuery = "INSERT INTO Request_Matches (RequestID, DonorID, Status) VALUES ";
                        bool hasMatches = false;

                        while (reader.Read())
                        {
                            int donorId = Convert.ToInt32(reader["DonorID"]);
                            matchInsertQuery += $"({newRequestId}, {donorId}, 'Pending'),";
                            hasMatches = true;
                        }

                        // Agar koi match mila toh database mein insert karo
                        if (hasMatches)
                        {
                            reader.Close(); // Reader band karna zaroori hai insert se pehle
                            matchInsertQuery = matchInsertQuery.TrimEnd(';'); // Aakhri comma hatao
                            matchInsertQuery = matchInsertQuery.TrimEnd(','); // Aakhri comma hatao

                            MySqlCommand cmdMatch = new MySqlCommand(matchInsertQuery, conn);
                            cmdMatch.ExecuteNonQuery();

                            ShowMessage("Request Broadcasted! Compatible donors have been matched and alerted.", true);
                        }
                        else
                        {
                            ShowMessage("Request Created, but currently no eligible compatible donors found in system.", false);
                        }
                    }

                    // Grid refresh karo
                    LoadActiveRequests();
                }
                catch (Exception ex)
                {
                    ShowMessage("Error: " + ex.Message, false);
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