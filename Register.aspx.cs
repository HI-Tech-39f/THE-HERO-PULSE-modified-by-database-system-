using System;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string role = ddlRole.SelectedValue;

            if (string.IsNullOrEmpty(role))
            {
                ShowMessage("Please select a role.", false);
                return;
            }

            // --- 1. MEDICAL VALIDATION FOR DONORS ---
            if (role == "Donor")
            {
                // Donor ke liye DOB zaroori hai, is liye convert safely
                DateTime dob;
                if (!DateTime.TryParse(txtDOB.Text, out dob))
                {
                    ShowMessage("Please enter a valid Date of Birth.", false);
                    return;
                }

                int age = DateTime.Today.Year - dob.Year;
                if (dob.Date > DateTime.Today.AddYears(-age)) age--;

                if (age < 18)
                {
                    ShowMessage("Registration Failed: You must be at least 18 years old to donate blood.", false);
                    return;
                }

                int weight = 0;
                int.TryParse(txtWeight.Text, out weight);
                if (weight < 50)
                {
                    ShowMessage("Registration Failed: For your safety, your weight must be 50kg or above.", false);
                    return;
                }

                if (chkDisease.Checked)
                {
                    ShowMessage("Registration Failed: Individuals with chronic diseases cannot register as donors.", false);
                    return;
                }
            }

            // --- 2. DATABASE INSERTION ---
            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    conn.Open();

                    // Step 1: Insert into Users Table
                    string userQuery = "INSERT INTO Users (Username, Email, Password, Role, DOB) VALUES (@name, @email, @pass, @role, @dob); SELECT LAST_INSERT_ID();";
                    MySqlCommand cmdUser = new MySqlCommand(userQuery, conn);
                    cmdUser.Parameters.AddWithValue("@name", txtUsername.Text);
                    cmdUser.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmdUser.Parameters.AddWithValue("@pass", txtPassword.Text);
                    cmdUser.Parameters.AddWithValue("@role", role);

                    // Agar DOB empty hai (Yani Hospital ka case hai), toh DBNull.Value bhejo
                    if (string.IsNullOrEmpty(txtDOB.Text))
                    {
                        cmdUser.Parameters.AddWithValue("@dob", DBNull.Value);
                    }
                    else
                    {
                        cmdUser.Parameters.AddWithValue("@dob", txtDOB.Text);
                    }

                    int newUserId = Convert.ToInt32(cmdUser.ExecuteScalar());

                    // Step 2: Insert into Role-Specific Tables
                    if (role == "Donor")
                    {
                        string donorQuery = "INSERT INTO Donors (UserID, GroupID, City, Weight) VALUES (@uid, @gid, @city, @weight)";
                        MySqlCommand cmdDonor = new MySqlCommand(donorQuery, conn);
                        cmdDonor.Parameters.AddWithValue("@uid", newUserId);
                        cmdDonor.Parameters.AddWithValue("@gid", ddlBloodGroup.SelectedValue);
                        cmdDonor.Parameters.AddWithValue("@city", txtCity.Text);
                        cmdDonor.Parameters.AddWithValue("@weight", txtWeight.Text);
                        cmdDonor.ExecuteNonQuery();
                    }
                    else if (role == "Hospital")
                    {
                        string hospQuery = "INSERT INTO Hospitals (UserID, Name, Address, ContactNumber, IsVerified) VALUES (@uid, @hname, @add, @contact, FALSE)";
                        MySqlCommand cmdHosp = new MySqlCommand(hospQuery, conn);
                        cmdHosp.Parameters.AddWithValue("@uid", newUserId);
                        cmdHosp.Parameters.AddWithValue("@hname", txtHospitalName.Text);
                        cmdHosp.Parameters.AddWithValue("@add", txtAddress.Text);
                        cmdHosp.Parameters.AddWithValue("@contact", txtContact.Text);
                        cmdHosp.ExecuteNonQuery();
                    }
                    else if (role == "Recipient")
                    {
                        string recQuery = "INSERT INTO Recipients (UserID, MedicalHistory) VALUES (@uid, @hist)";
                        MySqlCommand cmdRec = new MySqlCommand(recQuery, conn);
                        cmdRec.Parameters.AddWithValue("@uid", newUserId);
                        cmdRec.Parameters.AddWithValue("@hist", txtMedicalHistory.Text);
                        cmdRec.ExecuteNonQuery();
                    }

                    // --- THE REDIRECT LOGIC ---
                    Session["SuccessMsg"] = "Account created successfully! Please login to continue.";
                    Response.Redirect("Login.aspx", false);
                }
                catch (Exception ex)
                {
                    ShowMessage("Error: This Email might already be registered. Or System Error: " + ex.Message, false);
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