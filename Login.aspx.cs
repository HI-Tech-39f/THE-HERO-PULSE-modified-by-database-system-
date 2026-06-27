using System;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["SuccessMsg"] != null)
                {
                    lblMessage.Text = Session["SuccessMsg"].ToString();
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    Session.Remove("SuccessMsg");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    conn.Open();

                    // UPDATED QUERY: Ab hum Users table ke sath Hospitals table ko link (JOIN) kar rahe hain 
                    // taake humein login ke waqt hi 'IsVerified' ka status mil jaye.
                    string loginQuery = @"
                        SELECT u.UserID, u.Username, u.Role, h.IsVerified 
                        FROM Users u 
                        LEFT JOIN Hospitals h ON u.UserID = h.UserID 
                        WHERE u.Username = @user AND u.Password = @pass";

                    MySqlCommand cmd = new MySqlCommand(loginQuery, conn);
                    cmd.Parameters.AddWithValue("@user", txtUsername.Text);
                    cmd.Parameters.AddWithValue("@pass", txtPassword.Text);

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read()) // Agar password theek hai
                        {
                            string userRole = reader["Role"].ToString();

                            // ==========================================
                            // 🚨 THE NEW SECURITY CHECK FOR HOSPITALS 🚨
                            // ==========================================
                            if (userRole == "Hospital")
                            {
                                bool isVerified = false;
                                if (reader["IsVerified"] != DBNull.Value)
                                {
                                    isVerified = Convert.ToBoolean(reader["IsVerified"]);
                                }

                                // Agar Verify nahi hua toh Login yahin rok do!
                                if (isVerified == false)
                                {
                                    lblMessage.ForeColor = System.Drawing.Color.Red;
                                    lblMessage.Text = "Access Denied: Your hospital account is pending verification by the Admin. Please wait for approval.";
                                    return; // Yahan se code wapas mur jayega, session set nahi hoga!
                                }
                            }
                            // ==========================================

                            // Agar yahan tak code pohnch gaya iska matlab sab theek hai
                            Session["UserID"] = reader["UserID"].ToString();
                            Session["Username"] = reader["Username"].ToString();
                            Session["Role"] = userRole;

                            // Smart Routing
                            if (userRole == "Admin")
                            {
                                Response.Redirect("AdminDashboard.aspx", false);
                            }
                            else if (userRole == "Donor")
                            {
                                Response.Redirect("DonorDashboard.aspx", false);
                            }
                            else if (userRole == "Hospital")
                            {
                                Response.Redirect("HospitalDashboard.aspx", false);
                            }
                            else if (userRole == "Recipient")
                            {
                                Response.Redirect("ReceptorDashboard.aspx", false);
                            }
                        }
                        else
                        {
                            // Password galat hai
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            lblMessage.Text = "Invalid Username or Password. Please try again.";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Database Error: " + ex.Message;
                }
            }
        }
    }
}