using System;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class HospitalDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Hospital")
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                LoadDashboardData();
                LoadIncomingDonors();
            }
        }

        private int GetHospitalId(int userId)
        {
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

        private void InitializeInventoryIfEmpty(int hospitalId, MySqlConnection conn)
        {
            MySqlCommand checkCmd = new MySqlCommand("SELECT COUNT(*) FROM Blood_Inventory WHERE HospitalID = @hid", conn);
            checkCmd.Parameters.AddWithValue("@hid", hospitalId);
            if (Convert.ToInt32(checkCmd.ExecuteScalar()) < 8)
            {
                string insertQuery = @"INSERT IGNORE INTO Blood_Inventory (HospitalID, GroupID, Quantity) SELECT @hid, GroupID, 0 FROM Blood_Groups";
                MySqlCommand insertCmd = new MySqlCommand(insertQuery, conn);
                insertCmd.Parameters.AddWithValue("@hid", hospitalId);
                insertCmd.ExecuteNonQuery();
            }
        }

        private void LoadDashboardData()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int hospitalId = GetHospitalId(userId);
            if (hospitalId == 0) return;

            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    conn.Open();
                    InitializeInventoryIfEmpty(hospitalId, conn);
                    string invQuery = @"SELECT bg.GroupName, bi.Quantity FROM Blood_Inventory bi JOIN Blood_Groups bg ON bi.GroupID = bg.GroupID WHERE bi.HospitalID = @hid";
                    MySqlCommand cmdInv = new MySqlCommand(invQuery, conn);
                    cmdInv.Parameters.AddWithValue("@hid", hospitalId);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmdInv);
                    DataTable dtInv = new DataTable();
                    da.Fill(dtInv);
                    rptInventory.DataSource = dtInv;
                    rptInventory.DataBind();
                    DataView dvAlerts = new DataView(dtInv);
                    dvAlerts.RowFilter = "Quantity < 5";
                    if (dvAlerts.Count > 0)
                    {
                        rptAlerts.DataSource = dvAlerts;
                        rptAlerts.DataBind();
                        lblNoAlerts.Visible = false;
                    }
                    else lblNoAlerts.Visible = true;
                }
                catch (Exception) { /* Handle if necessary */ }
            }
        }

        private void LoadIncomingDonors()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int hospitalId = GetHospitalId(userId);
            // This properly fetches Donor Email (Contact) and Username
            string query = @"
                SELECT rm.RequestID, rm.DonorID, bg.GroupID, u.Username, u.Email AS Contact, bg.GroupName
                FROM Request_Matches rm
                JOIN Donors d ON rm.DonorID = d.DonorID
                JOIN Users u ON d.UserID = u.UserID
                JOIN Blood_Groups bg ON d.GroupID = bg.GroupID
                JOIN Donation_Requests dr ON rm.RequestID = dr.RequestID
                WHERE dr.HospitalID = @hid AND rm.Status = 'Accepted'";
            DataTable dt = new DataTable();
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@hid", hospitalId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
            }
            gvIncomingDonors.DataSource = dt;
            gvIncomingDonors.DataBind();
        }

        protected void gvIncomingDonors_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ConfirmDonation")
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                int hospitalId = GetHospitalId(userId);
                string[] args = e.CommandArgument.ToString().Split(',');
                int requestId = Convert.ToInt32(args[0]), donorId = Convert.ToInt32(args[1]), groupId = Convert.ToInt32(args[2]);

                using (MySqlConnection conn = Connection.GetConnection())
                {
                    conn.Open();
                    MySqlTransaction transaction = conn.BeginTransaction();
                    try
                    {
                        string q1 = "INSERT INTO Donations (DonorID, HospitalID, RequestID, DonationDate) VALUES (@did, @hid, @reqid, CURDATE())";
                        MySqlCommand cmd1 = new MySqlCommand(q1, conn, transaction);
                        cmd1.Parameters.AddWithValue("@did", donorId);
                        cmd1.Parameters.AddWithValue("@hid", hospitalId);
                        cmd1.Parameters.AddWithValue("@reqid", requestId);
                        cmd1.ExecuteNonQuery();

                        string q2 = "UPDATE Request_Matches SET Status = 'Completed' WHERE RequestID = @reqid AND DonorID = @did";
                        MySqlCommand cmd2 = new MySqlCommand(q2, conn, transaction);
                        cmd2.Parameters.AddWithValue("@reqid", requestId);
                        cmd2.Parameters.AddWithValue("@did", donorId);
                        cmd2.ExecuteNonQuery();

                        string q3 = "UPDATE Donation_Requests SET Status = 'Fulfilled' WHERE RequestID = @reqid";
                        MySqlCommand cmd3 = new MySqlCommand(q3, conn, transaction);
                        cmd3.Parameters.AddWithValue("@reqid", requestId);
                        cmd3.ExecuteNonQuery();

                        string q4 = "UPDATE Blood_Inventory SET Quantity = Quantity + 1 WHERE HospitalID = @hid AND GroupID = @gid";
                        MySqlCommand cmd4 = new MySqlCommand(q4, conn, transaction);
                        cmd4.Parameters.AddWithValue("@hid", hospitalId);
                        cmd4.Parameters.AddWithValue("@gid", groupId);
                        cmd4.ExecuteNonQuery();

                        string q5 = "UPDATE Donors SET LastDonationDate = CURDATE() WHERE DonorID = @did";
                        MySqlCommand cmd5 = new MySqlCommand(q5, conn, transaction);
                        cmd5.Parameters.AddWithValue("@did", donorId);
                        cmd5.ExecuteNonQuery();

                        transaction.Commit();
                        lblMessage.Text = "Donation Confirmed! Blood bag added to inventory and Donor Profile updated.";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        LoadDashboardData();
                        LoadIncomingDonors();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        lblMessage.Text = "System Error: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }
}