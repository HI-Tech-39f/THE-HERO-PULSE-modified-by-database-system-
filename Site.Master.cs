using System;
using System.Web.UI;
using System.IO;

namespace hero_pulse
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // ==========================================
            // 🚨 THE SMART LOGOUT LOGIC 🚨
            // ==========================================
            if (Request.QueryString["logout"] == "true")
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
            {
                GenerateSmartNavbar();
            }
        }

        private void GenerateSmartNavbar()
        {
            // Current Page ka naam nikalna (taake use highlight kiya ja sake)
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath).ToLower();
            if (string.IsNullOrEmpty(currentPage))
            {
                currentPage = "default.aspx";
            }

            string menuHtml = "";

            // Helper Method: Jis page par honge, uska color Yellow/Gold ho jayega aur border aa jayega
            string GetActiveStyle(string pageName)
            {
                return currentPage == pageName.ToLower() ? "color: #ffc107 !important; border-bottom: 2px solid #ffc107; font-weight: bold;" : "";
            }

            // ==========================================
            // 1. THE 4 MAIN LINKS (Always Visible)
            // ==========================================
            menuHtml += $"<li class='nav-item me-3'><a class='nav-link' style='{GetActiveStyle("Default.aspx")}' href='Default.aspx'>Home</a></li>";
            menuHtml += $"<li class='nav-item me-3'><a class='nav-link' style='{GetActiveStyle("About.aspx")}' href='About.aspx'>About</a></li>";
            menuHtml += $"<li class='nav-item me-3'><a class='nav-link' style='{GetActiveStyle("Services.aspx")}' href='Services.aspx'>Services</a></li>";
            menuHtml += $"<li class='nav-item me-4'><a class='nav-link' style='{GetActiveStyle("Contact.aspx")}' href='Contact.aspx'>Contact Us</a></li>";

            // ==========================================
            // 2. AUTHENTICATION & DASHBOARDS
            // ==========================================
            if (Session["UserID"] != null && Session["Role"] != null)
            {
                // USER LOGGED IN HAI
                string role = Session["Role"].ToString();

                // Role-based Dashboard Links
                if (role == "Donor")
                {
                    menuHtml += $"<li class='nav-item me-2'><a class='nav-link' style='{GetActiveStyle("DonorDashboard.aspx")}' href='DonorDashboard.aspx'>Dashboard</a></li>";
                }
                else if (role == "Hospital")
                {
                    menuHtml += $"<li class='nav-item me-2'><a class='nav-link' style='{GetActiveStyle("HospitalDashboard.aspx")}' href='HospitalDashboard.aspx'>Dashboard</a></li>";
                    menuHtml += $"<li class='nav-item me-3'><a class='nav-link' style='{GetActiveStyle("ManageInventory.aspx")}' href='ManageInventory.aspx'>Inventory</a></li>";
                }
                else if (role == "Recipient")
                {
                    menuHtml += $"<li class='nav-item me-2'><a class='nav-link' style='{GetActiveStyle("ReceptorDashboard.aspx")}' href='ReceptorDashboard.aspx'>Dashboard</a></li>";
                }
                else if (role == "Admin")
                {
                    menuHtml += $"<li class='nav-item me-2'><a class='nav-link' style='{GetActiveStyle("AdminDashboard.aspx")}' href='AdminDashboard.aspx'>Dashboard</a></li>";
                }

                // Styled Logout Button 
                menuHtml += "<li class='nav-item ms-lg-3'><a class='btn btn-login rounded-pill px-4 fw-semibold' href='Default.aspx?logout=true'>Logout (" + Session["Username"] + ")</a></li>";
            }
            else
            {
                // USER LOGGED IN NAHI HAI
                // System check karega: Kya user About, Services, ya Contact Us page par hai?
                if (currentPage == "about.aspx" || currentPage == "services.aspx" || currentPage == "contact.aspx")
                {
                    // Tumhari shart ke mutabiq in 3 pages par Login/Signup buttons hide ho jayenge
                    // So we add nothing here.
                }
                else
                {
                    // Baki pages (Default.aspx, Login.aspx waghera) par Login/Signup show honge
                    menuHtml += "<li class='nav-item ms-lg-4 me-2 mt-2 mt-lg-0'><a class='btn btn-login rounded-pill px-4 fw-semibold' href='Login.aspx'>Login</a></li>";
                    menuHtml += "<li class='nav-item mt-2 mt-lg-0'><a class='btn btn-register rounded-pill px-4 fw-bold' href='Register.aspx'>Sign Up</a></li>";
                }
            }

            litNavItems.Text = menuHtml;
        }
    }
}