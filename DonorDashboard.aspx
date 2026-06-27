<%@ Page Title="Donor Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DonorDashboard.aspx.cs" Inherits="hero_pulse.DonorDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .donor-stats { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1.25rem; margin-bottom: 2.5rem; }
    @media (max-width: 576px) { .donor-stats { grid-template-columns: 1fr; } }
    .eligibility-bar {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 14px;
        padding: 1.25rem 1.5rem;
        margin-bottom: 2rem;
        display: flex;
        align-items: center;
        gap: 1.25rem;
    }
    .eligibility-bar .elig-icon {
        width: 48px; height: 48px;
        border-radius: 12px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.3rem;
        flex-shrink: 0;
    }
    .elig-ok { background: #d4f4ec; color: var(--emerald); }
    .elig-wait { background: #fde8ea; color: var(--crimson); }
    .elig-text h6 { font-family: 'Syne', sans-serif; font-weight: 700; font-size: 0.95rem; margin-bottom: 0.15rem; }
    .elig-text p { font-size: 0.85rem; color: var(--muted); margin: 0; }
    .blood-group-badge {
        background: var(--crimson);
        color: #fff;
        font-family: 'Syne', sans-serif;
        font-weight: 800;
        font-size: 1rem;
        padding: 0.4rem 1rem;
        border-radius: 8px;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="hp-page-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                <div>
                    <span class="section-eyebrow" style="color:rgba(192,24,42,0.8);">Donor Portal</span>
                    <h1>Donor Dashboard</h1>
                    <p>Your eligibility status, active commitments, and full donation history.</p>
                </div>
                <div class="blood-group-badge" style="align-self:flex-end;">
                    <i class="fas fa-tint"></i> <asp:Label ID="lblBloodGroup" runat="server" Text="N/A"></asp:Label>
                </div>
            </div>
        </div>
    </div>

    <div style="padding:2.5rem 0 4rem; background:var(--ivory);">
        <div class="container">
            <div class="msg-box text-center mb-3">
                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Small"></asp:Label>
            </div>

            <!-- Stats -->
            <div class="donor-stats">
                <div class="stat-pill">
                    <div class="stat-icon" style="color:var(--emerald)"><i class="fas fa-child"></i></div>
                    <div class="stat-num" style="color:var(--emerald)"><asp:Label ID="lblLivesSaved" runat="server" Text="0"></asp:Label></div>
                    <div class="stat-label">Lives You've Saved</div>
                </div>
                <div class="stat-pill">
                    <div class="stat-icon" style="color:var(--crimson)"><i class="fas fa-hand-holding-medical"></i></div>
                    <div class="stat-num" style="color:var(--crimson)"><asp:Label ID="lblTotalDonations" runat="server" Text="0"></asp:Label></div>
                    <div class="stat-label">Total Donations</div>
                </div>
            </div>

            <!-- Active Commitment -->
            <div class="hp-card mb-4">
                <div class="hp-card-header">
                    <div class="icon-wrap icon-gold"><i class="fas fa-star"></i></div>
                    <h5>My Active Commitment</h5>
                </div>
                <div class="hp-gridview-wrap">
                    <asp:GridView ID="gvMyCommitment" runat="server" CssClass="w-100" AutoGenerateColumns="False"
                        GridLines="None" OnRowCommand="gvMyCommitment_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="RequestDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                            <asp:BoundField DataField="RequesterName" HeaderText="Requester" />
                            <asp:BoundField DataField="ContactInfo" HeaderText="Contact (Email)" />
                            <asp:BoundField DataField="GroupName" HeaderText="Blood" />
                            <asp:BoundField DataField="Urgency" HeaderText="Urgency" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelDonation"
                                        CommandArgument='<%# Eval("RequestID") %>'
                                        CssClass="btn-hp-ghost">
                                        <i class="fas fa-times"></i> Cancel
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="empty-state"><i class="fas fa-info-circle"></i><p>No active commitments. You can accept a request below.</p></div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>

            <!-- Available Requests -->
            <div class="hp-card mb-4">
                <div class="hp-card-header">
                    <div class="icon-wrap icon-crimson"><i class="fas fa-exclamation-circle"></i></div>
                    <h5>Available Emergency Requests</h5>
                </div>
                <div class="hp-gridview-wrap">
                    <asp:GridView ID="gvAvailableRequests" runat="server" CssClass="w-100" AutoGenerateColumns="False"
                        GridLines="None" OnRowCommand="gvAvailableRequests_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="RequestDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                            <asp:BoundField DataField="RequesterName" HeaderText="Needed By" />
                            <asp:BoundField DataField="GroupName" HeaderText="Blood" />
                            <asp:BoundField DataField="Urgency" HeaderText="Urgency" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDonate" runat="server" CommandName="AcceptDonation"
                                        CommandArgument='<%# Eval("RequestID") %>'
                                        CssClass="btn-hp-primary" Style="font-size:0.8rem;padding:0.4rem 1rem;">
                                        <i class="fas fa-tint"></i> Accept
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="empty-state"><i class="fas fa-smile-beam" style="color:var(--emerald)"></i><p>No emergency requests for your blood group right now. You're all clear!</p></div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>

            <!-- History -->
            <div class="hp-card">
                <div class="hp-card-header">
                    <div class="icon-wrap icon-dark"><i class="fas fa-history"></i></div>
                    <h5>My Donation History</h5>
                </div>
                <div class="hp-gridview-wrap">
                    <asp:GridView ID="gvHistory" runat="server" CssClass="w-100" AutoGenerateColumns="False" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="DonationDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                            <asp:BoundField DataField="HospitalName" HeaderText="Donated At" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="empty-state"><i class="fas fa-file-medical-alt"></i><p>No donations yet. Start saving lives today!</p></div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
