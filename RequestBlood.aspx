<%@ Page Title="Request Blood" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RequestBlood.aspx.cs" Inherits="hero_pulse.RequestBlood" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="hp-page-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                <div>
                    <span class="section-eyebrow" style="color:rgba(192,24,42,0.8);">Hospital Portal</span>
                    <h1>Emergency Blood Request</h1>
                    <p>Broadcast a blood request and our auto-matching engine will alert compatible donors instantly.</p>
                </div>
                <a href="HospitalDashboard.aspx" class="btn-hp-secondary" style="align-self:flex-end;color:#fff;border-color:rgba(255,255,255,0.25);">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
            </div>
        </div>
    </div>

    <div style="padding:2.5rem 0 4rem; background:var(--ivory);">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-5">
                    <div class="hp-card">
                        <div class="hp-card-header">
                            <div class="icon-wrap icon-crimson"><i class="fas fa-broadcast-tower"></i></div>
                            <h5>Generate New Demand</h5>
                        </div>
                        <div style="padding:1.5rem;">
                            <div class="msg-box text-center mb-3">
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Small"></asp:Label>
                            </div>
                            <div class="field-group" style="margin-bottom:1.25rem;">
                                <label class="hp-label">Needed Blood Group</label>
                                <asp:DropDownList ID="ddlBloodGroup" runat="server" CssClass="hp-select">
                                    <asp:ListItem Value="1" Text="A+" /><asp:ListItem Value="2" Text="A−" />
                                    <asp:ListItem Value="3" Text="B+" /><asp:ListItem Value="4" Text="B−" />
                                    <asp:ListItem Value="5" Text="AB+" /><asp:ListItem Value="6" Text="AB−" />
                                    <asp:ListItem Value="7" Text="O+" /><asp:ListItem Value="8" Text="O−" />
                                </asp:DropDownList>
                            </div>
                            <div class="field-group" style="margin-bottom:1.5rem;">
                                <label class="hp-label">Urgency Level</label>
                                <asp:DropDownList ID="ddlUrgency" runat="server" CssClass="hp-select">
                                    <asp:ListItem Value="Normal" Text="Normal (Within 24 Hours)" />
                                    <asp:ListItem Value="Urgent" Text="Urgent (Within 6 Hours)" />
                                    <asp:ListItem Value="Critical" Text="Critical — Immediate!" />
                                </asp:DropDownList>
                            </div>
                            <asp:Button ID="btnRequest" runat="server" Text="Broadcast Request" CssClass="btn-hp-primary" Style="width:100%;justify-content:center;" OnClick="btnRequest_Click" />
                            <div class="alert-strip alert-strip-gold mt-3">
                                <i class="fas fa-bolt alert-icon"></i>
                                <p><strong>Auto-matching active.</strong> Compatible donors will be notified immediately after you broadcast.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-7">
                    <div class="hp-card h-100">
                        <div class="hp-card-header">
                            <div class="icon-wrap icon-dark"><i class="fas fa-list-ul"></i></div>
                            <h5>Your Active Requests</h5>
                        </div>
                        <div class="hp-gridview-wrap">
                            <asp:GridView ID="gvRequests" runat="server" CssClass="w-100" AutoGenerateColumns="False" GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="RequestDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                                    <asp:BoundField DataField="GroupName" HeaderText="Blood Group" />
                                    <asp:BoundField DataField="Urgency" HeaderText="Urgency" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="empty-state"><i class="fas fa-inbox"></i><p>No active blood requests.</p></div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
