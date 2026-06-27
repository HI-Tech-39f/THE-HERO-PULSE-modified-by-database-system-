using System;
using System.Web.UI;
using MySql.Data.MySqlClient; // MySQL ki library add kar di

namespace hero_pulse
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
            }
        }

        private void LoadStats()
        {
            try
            {
                // SQL Server connection ki jagah hamara standard MySQL Connection
                using (MySqlConnection con = Connection.GetConnection())
                {
                    con.Open();

                    // 1. Total Registered Donors (Homepage wali query)
                    using (MySqlCommand cmd = new MySqlCommand("SELECT COUNT(*) FROM Donors", con))
                    {
                        object result = cmd.ExecuteScalar();
                        string donors = result != null ? result.ToString() : "0";

                        lblDonors.Text = donors;
                        lblStatDonors.Text = donors;
                    }

                    // 2. Lives Saved (Completed Donations) (Homepage wali query)
                    using (MySqlCommand cmd = new MySqlCommand("SELECT COUNT(*) FROM Donations", con))
                    {
                        object result = cmd.ExecuteScalar();
                        string lives = result != null ? result.ToString() : "0";

                        lblStatLives.Text = lives;
                    }

                    // 3. Partner / Verified Hospitals (Homepage wali query)
                    using (MySqlCommand cmd = new MySqlCommand("SELECT COUNT(*) FROM Hospitals WHERE IsVerified = 1", con))
                    {
                        object result = cmd.ExecuteScalar();
                        string hospitals = result != null ? result.ToString() : "0";

                        lblStatHospitals.Text = hospitals;
                    }
                }
            }
            catch (Exception ex)
            {
                // Agar database mein koi masla aye toh crash nahi hoga, defaults hi show honge
                System.Diagnostics.Debug.WriteLine("About Page Stats Error: " + ex.Message);
            }
        }
    }
}