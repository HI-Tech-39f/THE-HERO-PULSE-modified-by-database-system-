<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="hero_pulse.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script>
    function toggleSections() {
        var role = document.getElementById('<%= ddlRole.ClientID %>').value;
        var dobInput = document.getElementById('<%= txtDOB.ClientID %>');
        document.getElementById('donorSection').style.display = (role === 'Donor') ? 'block' : 'none';
        document.getElementById('hospitalSection').style.display = (role === 'Hospital') ? 'block' : 'none';
        document.getElementById('receptorSection').style.display = (role === 'Recipient') ? 'block' : 'none';
        document.getElementById('bloodGroupContainer').style.display = (role === 'Donor') ? 'block' : 'none';
        if (role === 'Hospital') {
            document.getElementById('dobContainer').style.display = 'none';
            dobInput.required = false;
        } else {
            document.getElementById('dobContainer').style.display = 'block';
            dobInput.required = true;
        }
        // Update role badge
        var badges = { 'Donor': 'donor', 'Hospital': 'hospital', 'Recipient': 'recipient', '': 'default' };
        var roleColors = { 'donor': '#fde8ea', 'hospital': '#dce3f6', 'recipient': '#d4f4ec', 'default': 'var(--surface-2)' };
        var roleTextColors = { 'donor': 'var(--crimson)', 'hospital': 'var(--navy)', 'recipient': 'var(--emerald)', 'default': 'var(--muted)' };
        var roleType = badges[role] || 'default';
    }
</script>
<style>
    .reg-page { background: var(--ivory); padding: 3rem 0 4rem; }
    .reg-header { text-align: center; margin-bottom: 2.5rem; }
    .reg-header h1 { font-family: 'Syne', sans-serif; font-size: 2.5rem; font-weight: 800; color: var(--ink); margin-bottom: 0.5rem; }
    .reg-header p { color: var(--muted); font-size: 1rem; }

    .reg-card { background: var(--surface); border: 1px solid var(--border); border-radius: 20px; padding: 2rem 2.5rem; box-shadow: 0 10px 40px rgba(0,0,0,0.06); }

    .role-selector { display: grid; grid-template-columns: repeat(3, 1fr); gap: 0.75rem; margin-bottom: 0; }
    .role-option { display: none; }
    .role-label {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 0.6rem;
        padding: 1.25rem 1rem;
        background: var(--surface-2);
        border: 2px solid var(--border);
        border-radius: 12px;
        cursor: pointer;
        transition: all 0.2s;
        text-align: center;
    }
    .role-label:hover { border-color: var(--crimson); }
    .role-label .role-icon { font-size: 1.5rem; }
    .role-label .role-name { font-family: 'Syne', sans-serif; font-weight: 700; font-size: 0.85rem; color: var(--ink); }
    .role-label .role-desc { font-size: 0.72rem; color: var(--muted); }
    .role-option:checked + .role-label { border-color: var(--crimson); background: #fff8f9; }
    .role-option:checked + .role-label .role-name { color: var(--crimson); }

    .form-section {
        margin-top: 1.5rem;
        padding: 1.5rem;
        background: var(--surface-2);
        border: 1px solid var(--border);
        border-radius: 14px;
    }
    .form-section h5 {
        font-family: 'Syne', sans-serif;
        font-size: 0.85rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.07em;
        color: var(--muted);
        margin-bottom: 1.25rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    .form-section h5 i { font-size: 0.9rem; }

    .field-group { margin-bottom: 1.25rem; }
    .field-group label {
        font-family: 'Syne', sans-serif;
        font-size: 0.72rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        color: var(--muted);
        display: block;
        margin-bottom: 0.45rem;
    }
    .field-group input, .field-group select, .field-group textarea {
        width: 100%;
        background: var(--surface);
        border: 1.5px solid var(--border);
        border-radius: 10px;
        padding: 0.7rem 1rem;
        font-family: 'DM Sans', sans-serif;
        font-size: 0.9rem;
        color: var(--ink);
        outline: none;
        transition: border-color 0.2s, box-shadow 0.2s;
    }
    .field-group input:focus, .field-group select:focus, .field-group textarea:focus {
        border-color: var(--crimson);
        box-shadow: 0 0 0 3px rgba(192,24,42,0.08);
    }

    .disease-check {
        display: flex;
        align-items: flex-start;
        gap: 0.75rem;
        padding: 1rem;
        background: #fff8f9;
        border: 1px solid #f5c5ca;
        border-radius: 10px;
        cursor: pointer;
    }
    .disease-check input { width: auto; margin-top: 2px; accent-color: var(--crimson); }
    .disease-check label { font-size: 0.875rem; color: var(--ink-soft); cursor: pointer; font-family: 'DM Sans', sans-serif; text-transform: none; letter-spacing: 0; font-weight: 400; }
    .disease-check label strong { color: var(--crimson); }

    .reg-submit {
        width: 100%;
        background: var(--crimson);
        color: #fff;
        border: none;
        border-radius: 12px;
        padding: 1rem;
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.2s;
        letter-spacing: 0.02em;
        margin-top: 1.5rem;
    }
    .reg-submit:hover { background: var(--crimson-light); transform: translateY(-2px); box-shadow: 0 10px 25px rgba(192,24,42,0.3); }

    .reg-login { text-align: center; margin-top: 1.25rem; font-size: 0.875rem; color: var(--muted); }
    .reg-login a { color: var(--crimson); font-weight: 600; text-decoration: none; }
    .msg-box { text-align: center; margin-bottom: 1rem; min-height: 1.5rem; }
    
    .section-divider { height: 1px; background: var(--border); margin: 1.75rem 0; }
    .section-title-sm {
        font-family: 'Syne', sans-serif;
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.1em;
        color: var(--muted);
        margin-bottom: 1.25rem;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="reg-page">
        <div class="container">
            <div class="reg-header">
                <span class="section-eyebrow">Join the Network</span>
                <h1>Create Your Account</h1>
                <p>Be part of Pakistan's most trusted blood donation network.</p>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="reg-card">
                        <div class="msg-box">
                            <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Small"></asp:Label>
                        </div>

                        <!-- Role Selection -->
                        <div class="section-title-sm">Step 1 — Select Your Role</div>
                        <div class="role-selector">
                            <div>
                                <asp:DropDownList ID="ddlRole" runat="server" CssClass="field-group" Style="display:none" onchange="toggleSections()">
                                    <asp:ListItem Value="" Text="-- Choose Role --" />
                                    <asp:ListItem Value="Donor" Text="Blood Donor (Hero)" />
                                    <asp:ListItem Value="Hospital" Text="Hospital / Blood Bank" />
                                    <asp:ListItem Value="Recipient" Text="Patient (Receptor)" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <!-- Visual Role Cards (drive the hidden dropdown) -->
                        <div class="role-selector" style="display:grid;grid-template-columns:repeat(3,1fr);gap:0.75rem;">
                            <label class="role-label" onclick="document.getElementById('<%= ddlRole.ClientID %>').value='Donor'; toggleSections();">
                                <span class="role-icon">🩸</span>
                                <span class="role-name">Blood Donor</span>
                                <span class="role-desc">Donate blood, save lives</span>
                            </label>
                            <label class="role-label" onclick="document.getElementById('<%= ddlRole.ClientID %>').value='Hospital'; toggleSections();">
                                <span class="role-icon">🏥</span>
                                <span class="role-name">Hospital</span>
                                <span class="role-desc">Manage requests & inventory</span>
                            </label>
                            <label class="role-label" onclick="document.getElementById('<%= ddlRole.ClientID %>').value='Recipient'; toggleSections();">
                                <span class="role-icon">🤕</span>
                                <span class="role-name">Patient</span>
                                <span class="role-desc">Request blood urgently</span>
                            </label>
                        </div>

                        <div class="section-divider"></div>
                        <div class="section-title-sm">Step 2 — Account Information</div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="field-group">
                                    <label>Username</label>
                                    <asp:TextBox ID="txtUsername" runat="server" placeholder="e.g. ali_raza"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="field-group">
                                    <label>Email Address</label>
                                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="name@email.com"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="field-group">
                                    <label>Password</label>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Create a secure password"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6" id="dobContainer" style="display:none;">
                                <div class="field-group">
                                    <label>Date of Birth</label>
                                    <asp:TextBox ID="txtDOB" runat="server" TextMode="Date"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Donor Section -->
                        <div id="donorSection" style="display:none;" class="mt-3">
                            <div class="form-section">
                                <h5><i class="fas fa-heartbeat" style="color:var(--crimson)"></i> Medical Screening — Donor</h5>
                                <div class="row g-3">
                                    <div class="col-md-12" id="bloodGroupContainer" style="display:none;">
                                        <div class="field-group">
                                            <label>Blood Group</label>
                                            <asp:DropDownList ID="ddlBloodGroup" runat="server">
                                                <asp:ListItem Value="1" Text="A+" />
                                                <asp:ListItem Value="2" Text="A−" />
                                                <asp:ListItem Value="3" Text="B+" />
                                                <asp:ListItem Value="4" Text="B−" />
                                                <asp:ListItem Value="5" Text="AB+" />
                                                <asp:ListItem Value="6" Text="AB−" />
                                                <asp:ListItem Value="7" Text="O+" />
                                                <asp:ListItem Value="8" Text="O−" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="field-group">
                                            <label>City</label>
                                            <asp:TextBox ID="txtCity" runat="server" placeholder="e.g. Lahore"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="field-group">
                                            <label>Weight (KG)</label>
                                            <asp:TextBox ID="txtWeight" runat="server" TextMode="Number" placeholder="Minimum 50kg"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="disease-check">
                                            <asp:CheckBox ID="chkDisease" runat="server" />
                                            <label for="<%= chkDisease.ClientID %>">I have a <strong>chronic disease</strong> (e.g. Cancer, HIV, Hepatitis). <em style="color:var(--muted)">Checking this will prevent donor registration for medical safety.</em></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Hospital Section -->
                        <div id="hospitalSection" style="display:none;" class="mt-3">
                            <div class="form-section">
                                <h5><i class="fas fa-hospital" style="color:var(--navy)"></i> Hospital Details</h5>
                                <div class="row g-3">
                                    <div class="col-12">
                                        <div class="field-group">
                                            <label>Hospital Name</label>
                                            <asp:TextBox ID="txtHospitalName" runat="server" placeholder="Official hospital name"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="field-group">
                                            <label>Contact Number</label>
                                            <asp:TextBox ID="txtContact" runat="server" placeholder="+92-XXX-XXXXXXX"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="field-group">
                                            <label>Address</label>
                                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" placeholder="Full hospital address"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="alert-strip alert-strip-gold">
                                            <i class="fas fa-info-circle alert-icon"></i>
                                            <p><strong>Verification Required.</strong> Your hospital account will be reviewed by an admin before you can post blood requests. This usually takes 24–48 hours.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Receptor Section -->
                        <div id="receptorSection" style="display:none;" class="mt-3">
                            <div class="form-section">
                                <h5><i class="fas fa-procedures" style="color:var(--emerald)"></i> Patient Profile</h5>
                                <div class="field-group">
                                    <label>Medical History <span style="font-weight:400;text-transform:none;letter-spacing:0;">(Optional)</span></label>
                                    <asp:TextBox ID="txtMedicalHistory" runat="server" TextMode="MultiLine" Rows="3" placeholder="Brief description of condition, medications, or relevant medical history..."></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <asp:Button ID="btnRegister" runat="server" Text="Create My Account →" CssClass="reg-submit" OnClick="btnRegister_Click" />
                        <div class="reg-login">
                            Already registered? <a href="Login.aspx">Sign in here</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
