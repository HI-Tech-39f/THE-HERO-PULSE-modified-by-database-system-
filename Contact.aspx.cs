using System;
using System.Web.UI;
using MySql.Data.MySqlClient; // Yahan MySQL ki library add ki hai

namespace hero_pulse
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Nothing needed on load
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Ensure validators passed
            if (!Page.IsValid) return;

            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string role = ddlRole.SelectedValue;
            string subject = txtSubject.Text.Trim();
            string message = txtMessage.Text.Trim();

            try
            {
                // Yahan Connection.GetConnection() use kiya hai
                using (MySqlConnection con = Connection.GetConnection())
                {
                    con.Open();

                    // MySQL syntax ke mutabiq GETDATE() ki jagah NOW() use kiya hai
                    string sql = @"INSERT INTO ContactMessages 
                                   (FullName, Email, Phone, Role, Subject, Message, SubmittedAt)
                                   VALUES (@Name, @Email, @Phone, @Role, @Subject, @Message, NOW())";

                    // SqlCommand ki jagah MySqlCommand
                    using (MySqlCommand cmd = new MySqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(phone) ? (object)DBNull.Value : phone);
                        cmd.Parameters.AddWithValue("@Role", string.IsNullOrEmpty(role) ? (object)DBNull.Value : role);
                        cmd.Parameters.AddWithValue("@Subject", subject);
                        cmd.Parameters.AddWithValue("@Message", message);
                        cmd.ExecuteNonQuery();
                    }
                }

                // Clear form
                txtName.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtPhone.Text = string.Empty;
                txtSubject.Text = string.Empty;
                txtMessage.Text = string.Empty;
                ddlRole.SelectedIndex = 0;

                pnlSuccess.Visible = true;
                pnlError.Visible = false;
                lblSuccess.Text = "Your message has been sent successfully. We'll respond within 24 hours.";
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                pnlSuccess.Visible = false;
                lblError.Text = "Something went wrong. Please try again later.";

                // Log ex.Message to your error log if needed
                System.Diagnostics.Debug.WriteLine("Contact form error: " + ex.Message);
            }
        }
    }
}