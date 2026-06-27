<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="hero_pulse.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .dashboard-wrap { padding: 2.5rem 0 4rem; background: var(--ivory); min-height: 80vh; }
    .admin-stat-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.25rem; margin-bottom: 2.5rem; }
    @media (max-width: 768px) { .admin-stat-row { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="hp-page-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                <div>
                    <span class="section-eyebrow" style="color:rgba(192,24,42,0.8);">Control Center</span>
                    <h1>Admin Dashboard</h1>
                    <p>System overview — manage hospitals, monitor requests, track inventory alerts.</p>
                </div>
                <a href="ManageHospitals.aspx" class="btn-hp-primary" style="align-self:flex-end;">
                    <i class="fas fa-hospital"></i> Manage Hospitals
                </a>
            </div>
        </div>
    </div>

    <div class="dashboard-wrap">
        <div class="container">
            <!-- Stats -->
            <div class="admin-stat-row">
                <div class="stat-pill">
                    <div class="stat-icon" style="color:var(--crimson)"><i class="fas fa-users"></i></div>
                    <div class="stat-num" style="color:var(--crimson)"><asp:Label ID="lblTotalDonors" runat="server" Text="0"></asp:Label></div>
                    <div class="stat-label">Registered Donors</div>
                </div>
                <div class="stat-pill">
                    <div class="stat-icon" style="color:var(--navy)"><i class="fas fa-clinic-medical"></i></div>
                    <div class="stat-num" style="color:var(--navy)"><asp:Label ID="lblTotalHospitals" runat="server" Text="0"></asp:Label></div>
                    <div class="stat-label">Verified Hospitals</div>
                </div>
                <div class="stat-pill">
                    <div class="stat-icon" style="color:var(--gold)"><i class="fas fa-clock"></i></div>
                    <div class="stat-num" style="color:var(--gold)"><asp:Label ID="lblPending" runat="server" Text="0"></asp:Label></div>
                    <div class="stat-label">Pending Verifications</div>
                </div>
            </div>

            <!-- Hospital Requests -->
            <div class="hp-card mb-4">
                <div class="hp-card-header">
                    <div class="icon-wrap icon-crimson"><i class="fas fa-clinic-medical"></i></div>
                    <h5>Hospital Blood Requests</h5>
                </div>
                <div class="hp-gridview-wrap">
                    <asp:GridView ID="gvHospitalRequests" runat="server" AutoGenerateColumns="False" GridLines="None"
                        CssClass="w-100">
                        <Columns>
                            <asp:BoundField DataField="RequestDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" />
                            <asp:BoundField DataField="RequesterName" HeaderText="Hospital" />
                            <asp:BoundField DataField="GroupName" HeaderText="Blood Group" />
                            <asp:BoundField DataField="Urgency" HeaderText="Urgency" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="empty-state"><i class="fas fa-check-circle" style="color:var(--emerald)"></i><p>No active hospital requests right now.</p></div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>

            <!-- Patient Requests -->
            <div class="hp-card">
                <div class="hp-card-header">
                    <div class="icon-wrap icon-emerald"><i class="fas fa-procedures"></i></div>
                    <h5>Patient (Receptor) Blood Requests</h5>
                </div>
                <div class="hp-gridview-wrap">
                    <asp:GridView ID="gvReceptorRequests" runat="server" AutoGenerateColumns="False" GridLines="None"
                        CssClass="w-100">
                        <Columns>
                            <asp:BoundField DataField="RequestDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" />
                            <asp:BoundField DataField="RequesterName" HeaderText="Patient" />
                            <asp:BoundField DataField="GroupName" HeaderText="Blood Group" />
                            <asp:BoundField DataField="Urgency" HeaderText="Urgency" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="empty-state"><i class="fas fa-heartbeat" style="color:var(--emerald)"></i><p>No active patient requests right now.</p></div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
