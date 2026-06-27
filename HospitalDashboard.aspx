<%@ Page Title="Hospital Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HospitalDashboard.aspx.cs" Inherits="hero_pulse.HospitalDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .inventory-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; }
    @media (max-width: 768px) { .inventory-grid { grid-template-columns: repeat(2, 1fr); } }
    .alert-siren {
        background: #fff0f2;
        border: 1.5px solid #f5c5ca;
        border-radius: 14px;
        padding: 1rem 1.25rem;
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-bottom: 0.75rem;
        animation: siren-pulse 2s ease-in-out infinite;
    }
    @keyframes siren-pulse {
        0%, 100% { border-color: #f5c5ca; }
        50% { border-color: var(--crimson); box-shadow: 0 0 12px rgba(192,24,42,0.15); }
    }
    .siren-icon { color: var(--crimson); font-size: 1.4rem; flex-shrink: 0; }
    .siren-text h6 { font-family: 'Syne', sans-serif; font-weight: 700; font-size: 0.85rem; color: var(--crimson); margin-bottom: 0.1rem; }
    .siren-text p { font-size: 0.78rem; color: var(--ink-soft); margin: 0; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="hp-page-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                <div>
                    <span class="section-eyebrow" style="color:rgba(192,24,42,0.8);">Hospital Portal</span>
                    <h1>Hospital Dashboard</h1>
                    <p>Monitor blood inventory, manage emergency requests, and confirm incoming donors.</p>
                </div>
                <div class="d-flex gap-2 flex-wrap" style="align-self:flex-end;">
                    <a href="RequestBlood.aspx" class="btn-hp-primary"><i class="fas fa-exclamation-circle"></i> Request Blood</a>
                    <a href="ManageInventory.aspx" class="btn-hp-secondary" style="color:#fff;border-color:rgba(255,255,255,0.25)"><i class="fas fa-boxes"></i> Update Stock</a>
                </div>
            </div>
        </div>
    </div>

    <div style="padding:2.5rem 0 4rem; background:var(--ivory);">
        <div class="container">
            <div class="msg-box text-center mb-3">
                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Small"></asp:Label>
            </div>

            <div class="row g-4 mb-4">
                <!-- Alerts -->
                <div class="col-md-4">
                    <div class="hp-card h-100">
                        <div class="hp-card-header">
                            <div class="icon-wrap icon-crimson"><i class="fas fa-bell"></i></div>
                            <h5>Low Stock Alerts</h5>
                        </div>
                        <div style="padding:1rem 1.25rem;">
                            <asp:Repeater ID="rptAlerts" runat="server">
                                <ItemTemplate>
                                    <div class="alert-siren">
                                        <span class="siren-icon"><i class="fas fa-exclamation-triangle"></i></span>
                                        <div class="siren-text">
                                            <h6>Critical: <%# Eval("GroupName") %></h6>
                                            <p>Only <%# Eval("Quantity") %> bag(s) remaining. Request immediately!</p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Label ID="lblNoAlerts" runat="server" Visible="false">
                                <div class="alert-strip alert-strip-emerald">
                                    <i class="fas fa-check-circle alert-icon"></i>
                                    <p><strong>All Clear.</strong> Blood stock levels are healthy.</p>
                                </div>
                            </asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Live Inventory -->
                <div class="col-md-8">
                    <div class="hp-card h-100">
                        <div class="hp-card-header">
                            <div class="icon-wrap icon-crimson"><i class="fas fa-tint"></i></div>
                            <h5>Live Blood Inventory</h5>
                        </div>
                        <div style="padding:1.25rem;">
                            <div class="inventory-grid">
                                <asp:Repeater ID="rptInventory" runat="server">
                                    <ItemTemplate>
                                        <div class="blood-tile <%# Convert.ToInt32(Eval("Quantity")) < 5 ? "low" : "" %>">
                                            <div class="blood-group"><%# Eval("GroupName") %></div>
                                            <div class="blood-qty"><%# Eval("Quantity") %></div>
                                            <div class="blood-label">bags</div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Incoming Donors -->
            <div class="hp-card">
                <div class="hp-card-header">
                    <div class="icon-wrap icon-emerald"><i class="fas fa-walking"></i></div>
                    <h5>Incoming Donors (Accepted Requests)</h5>
                </div>
                <div class="hp-gridview-wrap">
                    <asp:GridView ID="gvIncomingDonors" runat="server" CssClass="w-100" AutoGenerateColumns="False"
                        GridLines="None" OnRowCommand="gvIncomingDonors_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Username" HeaderText="Donor Name" />
                            <asp:BoundField DataField="Contact" HeaderText="Contact (Email)" />
                            <asp:BoundField DataField="GroupName" HeaderText="Blood Group" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnConfirm" runat="server" CommandName="ConfirmDonation"
                                        CommandArgument='<%# Eval("RequestID") + "," + Eval("DonorID") + "," + Eval("GroupID") %>'
                                        CssClass="btn-hp-success">
                                        <i class="fas fa-check-circle"></i> Confirm Arrival
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="empty-state"><i class="fas fa-hourglass-half"></i><p>Waiting for donors to accept your emergency requests.</p></div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
