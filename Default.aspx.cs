using System;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLiveStatistics();
            }
        }

        private void LoadLiveStatistics()
        {
            // Database se total counts nikalna stats cards ke liye
            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    conn.Open();

                    // 1. Total Registered Donors
                    MySqlCommand cmdDonors = new MySqlCommand("SELECT COUNT(*) FROM Donors", conn);
                    object donorCount = cmdDonors.ExecuteScalar();
                    lblTotalDonors.Text = donorCount != null ? donorCount.ToString() : "0";

                    // 2. Total Lives Saved (Completed Donations)
                    MySqlCommand cmdLives = new MySqlCommand("SELECT COUNT(*) FROM Donations", conn);
                    object livesCount = cmdLives.ExecuteScalar();
                    lblLivesSaved.Text = livesCount != null ? livesCount.ToString() : "0";

                    // 3. Total Verified Hospitals
                    MySqlCommand cmdHospitals = new MySqlCommand("SELECT COUNT(*) FROM Hospitals WHERE IsVerified = 1", conn);
                    object hospCount = cmdHospitals.ExecuteScalar();
                    lblHospitals.Text = hospCount != null ? hospCount.ToString() : "0";
                }
                catch (Exception)
                {
                    // Agar koi error aye toh default values 0 hi rahengi. Code crash nahi hoga.
                }
            }
        }
    }
}