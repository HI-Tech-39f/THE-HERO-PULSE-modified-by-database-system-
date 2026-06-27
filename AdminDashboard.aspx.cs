using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadDashboardStats();
                LoadHospitalRequests();
                LoadReceptorRequests();
            }
        }

        private void LoadDashboardStats()
        {
            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    conn.Open();

                    MySqlCommand cmdDonors = new MySqlCommand("SELECT COUNT(*) FROM Donors", conn);
                    lblTotalDonors.Text = cmdDonors.ExecuteScalar().ToString();

                    MySqlCommand cmdHosp = new MySqlCommand("SELECT COUNT(*) FROM Hospitals WHERE IsVerified = 1", conn);
                    lblTotalHospitals.Text = cmdHosp.ExecuteScalar().ToString();

                    MySqlCommand cmdPending = new MySqlCommand("SELECT COUNT(*) FROM Hospitals WHERE IsVerified = 0", conn);
                    lblPending.Text = cmdPending.ExecuteScalar().ToString();
                }
                catch (Exception ex)
                {
                    // Error handle if needed
                }
            }
        }

        // Table 1: Hospital Requests Load Karne Ke Liye
        private void LoadHospitalRequests()
        {
            string query = @"
                SELECT r.RequestDate, h.Name AS RequesterName, bg.GroupName, r.Urgency, r.Status 
                FROM Donation_Requests r
                JOIN Hospitals h ON r.HospitalID = h.HospitalID
                JOIN Blood_Groups bg ON r.GroupID = bg.GroupID
                WHERE r.Status != 'Fulfilled' AND r.HospitalID IS NOT NULL
                ORDER BY r.RequestDate DESC";

            DataTable dt = new DataTable();
            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    da.Fill(dt);
                }
                catch (Exception ex)
                {
                    // Error Handle
                }
            }

            gvHospitalRequests.DataSource = dt;
            gvHospitalRequests.DataBind();
        }

        // Table 2: Patient (Receptor) Requests Load Karne Ke Liye
        private void LoadReceptorRequests()
        {
            string query = @"
                SELECT r.RequestDate, u.Username AS RequesterName, bg.GroupName, r.Urgency, r.Status 
                FROM Donation_Requests r
                JOIN Recipients rec ON r.RecipientID = rec.RecipientID
                JOIN Users u ON rec.UserID = u.UserID
                JOIN Blood_Groups bg ON r.GroupID = bg.GroupID
                WHERE r.Status != 'Fulfilled' AND r.RecipientID IS NOT NULL
                ORDER BY r.RequestDate DESC";

            DataTable dt = new DataTable();
            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    da.Fill(dt);
                }
                catch (Exception ex)
                {
                    // Error Handle
                }
            }

            gvReceptorRequests.DataSource = dt;
            gvReceptorRequests.DataBind();
        }
    }
}