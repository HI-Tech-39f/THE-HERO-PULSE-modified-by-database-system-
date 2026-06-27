<%@ Page Title="Patient Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReceptorDashboard.aspx.cs" Inherits="hero_pulse.ReceptorDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="hp-page-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                <div>
                    <span class="section-eyebrow" style="color:rgba(192,24,42,0.8);">Patient Portal</span>
                    <h1>Patient Dashboard</h1>
                    <p>Request blood urgently and track the status of your active requests in real time.</p>
                </div>
                <span class="badge-emerald" style="align-self:flex-end;font-size:0.85rem;padding:0.5rem 1rem;">
                    <i class="fas fa-user-injured me-1"></i> Receptor Profile
                </span>
            </div>
        </div>
    </div>

    <div style="padding:2.5rem 0 4rem; background:var(--ivory);">
        <div class="container">
            <div class="row g-4">
                <!-- Request Form -->
                <div class="col-md-4">
                    <div class="hp-card">
                        <div class="hp-card-header">
                            <div class="icon-wrap icon-crimson"><i class="fas fa-heartbeat"></i></div>
                            <h5>Need Blood?</h5>
                        </div>
                        <div style="padding:1.5rem;">
                            <p style="font-size:0.875rem;color:var(--muted);margin-bottom:1.25rem;">Broadcast your request to our network of verified donors.</p>
                            <div class="msg-box text-center mb-2">
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>
                            </div>
                            <div class="field-group" style="margin-bottom:1.25rem;">
                                <label class="hp-label">Required Blood Group</label>
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
                                    <asp:ListItem Value="Normal" Text="Normal (24–48 Hours)" />
                                    <asp:ListItem Value="Urgent" Text="Urgent (6–12 Hours)" />
                                    <asp:ListItem Value="Critical" Text="Critical — Immediate Life Threat!" />
                                </asp:DropDownList>
                            </div>
                            <asp:Button ID="btnRequest" runat="server" Text="Broadcast Request" CssClass="btn-hp-primary" Style="width:100%;justify-content:center;" OnClick="btnRequest_Click" />
                        </div>
                    </div>
                </div>

                <!-- Requests Tracker -->
                <div class="col-md-8">
                    <div class="hp-card h-100">
                        <div class="hp-card-header">
                            <div class="icon-wrap icon-dark"><i class="fas fa-broadcast-tower"></i></div>
                            <h5>My Active Requests Tracker</h5>
                        </div>
                        <div class="hp-gridview-wrap">
                            <asp:GridView ID="gvMyRequests" runat="server" CssClass="w-100" AutoGenerateColumns="False"
                                GridLines="None" OnRowCommand="gvMyRequests_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="RequestDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                                    <asp:BoundField DataField="GroupName" HeaderText="Blood" />
                                    <asp:BoundField DataField="Urgency" HeaderText="Urgency" />
                                    <asp:BoundField DataField="DonorName" HeaderText="Accepted By" />
                                    <asp:BoundField DataField="DonorContact" HeaderText="Contact" />
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnComplete" runat="server" CommandName="MarkCompleted"
                                                CommandArgument='<%# Eval("RequestID") %>'
                                                CssClass="btn-hp-success"
                                                Visible='<%# Eval("Status").ToString() != "Fulfilled" %>'>
                                                <i class="fas fa-check-circle"></i> Received
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="empty-state"><i class="fas fa-bed"></i><p>No active requests. Use the form to broadcast a request.</p></div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
