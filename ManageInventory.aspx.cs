using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace hero_pulse
{
    public partial class ManageInventory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Hospital")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadCurrentStock();
            }
        }

        // --- Helper: Get HospitalID ---
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

        // --- Load Current Stock in Right Side Grid ---
        private void LoadCurrentStock()
        {
            int hospitalId = GetHospitalId();
            if (hospitalId == 0) return;

            string query = @"
                SELECT bg.GroupName, bi.Quantity 
                FROM Blood_Inventory bi 
                JOIN Blood_Groups bg ON bi.GroupID = bg.GroupID 
                WHERE bi.HospitalID = @hid";

            DataTable dt = new DataTable();
            using (MySqlConnection conn = Connection.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@hid", hospitalId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
            }

            rptCurrentStock.DataSource = dt;
            rptCurrentStock.DataBind();
        }

        // --- Update Button Click Logic ---
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int hospitalId = GetHospitalId();
            int groupId = Convert.ToInt32(ddlBloodGroup.SelectedValue);
            string action = ddlAction.SelectedValue;
            int inputQuantity = Convert.ToInt32(txtQuantity.Text);

            using (MySqlConnection conn = Connection.GetConnection())
            {
                try
                {
                    conn.Open();

                    // Pehle mojooda quantity check karein
                    string checkQuery = "SELECT Quantity FROM Blood_Inventory WHERE HospitalID = @hid AND GroupID = @gid";
                    MySqlCommand checkCmd = new MySqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@hid", hospitalId);
                    checkCmd.Parameters.AddWithValue("@gid", groupId);

                    object result = checkCmd.ExecuteScalar();
                    int currentQty = result != null ? Convert.ToInt32(result) : 0;

                    int newQty = 0;

                    if (action == "Add")
                    {
                        newQty = currentQty + inputQuantity;
                    }
                    else if (action == "Remove")
                    {
                        if (inputQuantity > currentQty)
                        {
                            ShowMessage("Error: You only have " + currentQty + " bags of this blood group. Cannot remove " + inputQuantity + ".", false);
                            return;
                        }
                        newQty = currentQty - inputQuantity;
                    }

                    // Ab database mein naya stock update karein
                    string updateQuery = "UPDATE Blood_Inventory SET Quantity = @newQty WHERE HospitalID = @hid AND GroupID = @gid";
                    MySqlCommand updateCmd = new MySqlCommand(updateQuery, conn);
                    updateCmd.Parameters.AddWithValue("@newQty", newQty);
                    updateCmd.Parameters.AddWithValue("@hid", hospitalId);
                    updateCmd.Parameters.AddWithValue("@gid", groupId);
                    updateCmd.ExecuteNonQuery();

                    ShowMessage("Inventory successfully updated!", true);

                    // Naya stock grid mein dikhane ke liye page refresh karein
                    txtQuantity.Text = "";
                    LoadCurrentStock();
                }
                catch (Exception ex)
                {
                    ShowMessage("System Error: " + ex.Message, false);
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