using System;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class DonorDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Donor")
                Response.Redirect("Login.aspx");

            if (!IsPostBack) RefreshDashboard();
        }

        private void RefreshDashboard()
        {
            LoadDonorStats();
            LoadMyCommitment();
            LoadAvailableRequests();
            LoadDonationHistory();
        }

        private (int DonorId, int GroupId, string GroupName, DateTime? LastDonation) GetDonorInfo()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int donorId = 0, groupId = 0;
            string groupName = "N/A";
            DateTime? lastDonation = null;
            string query = @"SELECT d.DonorID, d.GroupID, bg.GroupName, d.LastDonationDate FROM Donors d JOIN Blood_Groups bg ON d.GroupID = bg.GroupID WHERE d.UserID = @uid";
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", userId);
                conn.Open();
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        donorId = Convert.ToInt32(reader["DonorID"]);
                        groupId = Convert.ToInt32(reader["GroupID"]);
                        groupName = reader["GroupName"].ToString();
                        if (reader["LastDonationDate"] != DBNull.Value) lastDonation = Convert.ToDateTime(reader["LastDonationDate"]);
                    }
                }
            }
            return (donorId, groupId, groupName, lastDonation);
        }

        private void LoadDonorStats()
        {
            var info = GetDonorInfo();
            lblBloodGroup.Text = info.GroupName;
            string query = "SELECT COUNT(*) FROM Donations WHERE DonorID = @did";
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@did", info.DonorId);
                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                lblTotalDonations.Text = count.ToString();
                lblLivesSaved.Text = count.ToString();
            }
        }

        private void LoadMyCommitment()
        {
            var info = GetDonorInfo();
            // UPDATED QUERY: Fetching Email from either Hospital's User account or Patient's User account
            string query = @"
                SELECT dr.RequestID, dr.RequestDate, COALESCE(h.Name, u.Username) AS RequesterName, 
                       COALESCE(uh.Email, u.Email) AS ContactInfo,
                       bg.GroupName, dr.Urgency
                FROM Donation_Requests dr
                JOIN Request_Matches rm ON dr.RequestID = rm.RequestID
                LEFT JOIN Hospitals h ON dr.HospitalID = h.HospitalID
                LEFT JOIN Users uh ON h.UserID = uh.UserID
                LEFT JOIN Recipients rec ON dr.RecipientID = rec.RecipientID
                LEFT JOIN Users u ON rec.UserID = u.UserID
                JOIN Blood_Groups bg ON dr.GroupID = bg.GroupID
                WHERE rm.DonorID = @did AND rm.Status = 'Accepted'";

            DataTable dt = new DataTable();
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@did", info.DonorId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
            }
            gvMyCommitment.DataSource = dt;
            gvMyCommitment.DataBind();
        }

        private void LoadAvailableRequests()
        {
            var info = GetDonorInfo();
            string query = @"
                SELECT dr.RequestID, dr.RequestDate, COALESCE(h.Name, u.Username) AS RequesterName, bg.GroupName, dr.Urgency
                FROM Donation_Requests dr
                LEFT JOIN Hospitals h ON dr.HospitalID = h.HospitalID
                LEFT JOIN Recipients rec ON dr.RecipientID = rec.RecipientID
                LEFT JOIN Users u ON rec.UserID = u.UserID
                JOIN Blood_Groups bg ON dr.GroupID = bg.GroupID
                WHERE dr.Status = 'Pending' 
                AND dr.GroupID IN (SELECT RecipientGroupID FROM Blood_Compatibility WHERE DonorGroupID = @donorGroupId)
                AND dr.RequestID NOT IN (SELECT RequestID FROM Request_Matches WHERE DonorID = @did AND Status = 'Accepted')
                ORDER BY dr.RequestDate DESC";
            DataTable dt = new DataTable();
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@donorGroupId", info.GroupId);
                cmd.Parameters.AddWithValue("@did", info.DonorId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
            }
            gvAvailableRequests.DataSource = dt;
            gvAvailableRequests.DataBind();
        }

        private void LoadDonationHistory()
        {
            var info = GetDonorInfo();
            string query = @"SELECT dn.DonationDate, COALESCE(h.Name, 'General Donation') AS HospitalName, 'Completed' AS Status
                             FROM Donations dn LEFT JOIN Hospitals h ON dn.HospitalID = h.HospitalID
                             WHERE dn.DonorID = @did ORDER BY dn.DonationDate DESC";
            DataTable dt = new DataTable();
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@did", info.DonorId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
            }
            gvHistory.DataSource = dt;
            gvHistory.DataBind();
        }

        protected void gvMyCommitment_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CancelDonation")
            {
                var info = GetDonorInfo();
                int requestId = Convert.ToInt32(e.CommandArgument);
                using (MySqlConnection conn = Connection.GetConnection())
                {
                    try
                    {
                        conn.Open();
                        string query = "DELETE FROM Request_Matches WHERE RequestID = @reqId AND DonorID = @donId";
                        MySqlCommand cmd = new MySqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@reqId", requestId);
                        cmd.Parameters.AddWithValue("@donId", info.DonorId);
                        cmd.ExecuteNonQuery();
                        ShowMessage("Commitment Cancelled. You are now free to accept a different request.", true);
                        RefreshDashboard();
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("Error cancelling commitment: " + ex.Message, false);
                    }
                }
            }
        }

        protected void gvAvailableRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AcceptDonation")
            {
                var info = GetDonorInfo();
                int requestId = Convert.ToInt32(e.CommandArgument);

                if (info.LastDonation.HasValue)
                {
                    TimeSpan daysSinceLast = DateTime.Today - info.LastDonation.Value.Date;
                    if (daysSinceLast.TotalDays < 90)
                    {
                        int daysLeft = 90 - (int)daysSinceLast.TotalDays;
                        ShowMessage($"Thank you for your spirit, Hero! But for your safety, you can donate again in {daysLeft} days.", false);
                        return;
                    }
                }

                using (MySqlConnection conn = Connection.GetConnection())
                {
                    try
                    {
                        conn.Open();
                        string checkCommitmentQuery = "SELECT COUNT(*) FROM Request_Matches WHERE DonorID = @donId AND Status = 'Accepted'";
                        MySqlCommand checkCmd = new MySqlCommand(checkCommitmentQuery, conn);
                        checkCmd.Parameters.AddWithValue("@donId", info.DonorId);
                        if (Convert.ToInt32(checkCmd.ExecuteScalar()) > 0)
                        {
                            ShowMessage("Action Denied! You already have an active commitment.", false);
                            return;
                        }

                        string query = "INSERT INTO Request_Matches (RequestID, DonorID, Status) VALUES (@reqId, @donId, 'Accepted') ON DUPLICATE KEY UPDATE Status = 'Accepted'";
                        MySqlCommand cmd = new MySqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@reqId", requestId);
                        cmd.Parameters.AddWithValue("@donId", info.DonorId);
                        cmd.ExecuteNonQuery();
                        ShowMessage("Request Accepted Successfully! The hospital has been notified.", true);
                        RefreshDashboard();
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("Error processing your acceptance: " + ex.Message, false);
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