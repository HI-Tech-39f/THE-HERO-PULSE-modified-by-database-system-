using System;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class ManageHospitals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadPendingHospitals();
            }
        }

        // Database se Un-verified hospitals la kar grid mein daalna
        private void LoadPendingHospitals()
        {
            string query = "SELECT HospitalID, Name, ContactNumber, Address FROM Hospitals WHERE IsVerified = 0";
            DataTable dt = Connection.GetData(query);

            gvHospitals.DataSource = dt;
            gvHospitals.DataBind();
        }

        // Jab GridView ke andar koi button click hota hai
        protected void gvHospitals_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerifyHospital")
            {
                int hospitalId = Convert.ToInt32(e.CommandArgument);

                // Verification Query
                string updateQuery = "UPDATE Hospitals SET IsVerified = 1 WHERE HospitalID = " + hospitalId;
                int result = Connection.ExecuteQuery(updateQuery);

                if (result > 0)
                {
                    lblMessage.Text = "Hospital successfully verified! They can now access the system.";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    // Grid ko refresh karein
                    LoadPendingHospitals();
                }
                else
                {
                    lblMessage.Text = "Error verifying hospital.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}