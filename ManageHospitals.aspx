<%@ Page Title="Manage Hospitals" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageHospitals.aspx.cs" Inherits="hero_pulse.ManageHospitals" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="hp-page-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                <div>
                    <span class="section-eyebrow" style="color:rgba(192,24,42,0.8);">Admin — Security Checkpoint</span>
                    <h1>Pending Hospital Verifications</h1>
                    <p>Manually review and verify hospital registrations before they can post blood requests.</p>
                </div>
                <a href="AdminDashboard.aspx" class="btn-hp-secondary" style="align-self:flex-end; color:#fff; border-color:rgba(255,255,255,0.25);">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>
    <div style="padding:2.5rem 0 4rem; background:var(--ivory);">
        <div class="container">
            <div class="msg-box text-center mb-3">
                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Small"></asp:Label>
            </div>
            <div class="hp-card">
                <div class="hp-card-header">
                    <div class="icon-wrap icon-gold"><i class="fas fa-clipboard-check"></i></div>
                    <h5>Awaiting Verification</h5>
                </div>
                <div class="hp-gridview-wrap">
                    <asp:GridView ID="gvHospitals" runat="server" CssClass="w-100" AutoGenerateColumns="False"
                        GridLines="None" OnRowCommand="gvHospitals_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="HospitalID" HeaderText="ID" />
                            <asp:BoundField DataField="Name" HeaderText="Hospital Name" />
                            <asp:BoundField DataField="ContactNumber" HeaderText="Contact" />
                            <asp:BoundField DataField="Address" HeaderText="Address" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnVerify" runat="server" CommandName="VerifyHospital"
                                        CommandArgument='<%# Eval("HospitalID") %>'
                                        CssClass="btn-hp-success">
                                        <i class="fas fa-check-circle"></i> Verify
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="empty-state">
                                <i class="fas fa-check-double" style="color:var(--emerald)"></i>
                                <p>All hospitals have been verified. Nothing pending.</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
