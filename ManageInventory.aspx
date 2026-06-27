<%@ Page Title="Manage Inventory" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageInventory.aspx.cs" Inherits="hero_pulse.ManageInventory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .inventory-stock-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 0.75rem; }
    @media (max-width: 768px) { .inventory-stock-grid { grid-template-columns: repeat(2, 1fr); } }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="hp-page-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                <div>
                    <span class="section-eyebrow" style="color:rgba(192,24,42,0.8);">Hospital Portal</span>
                    <h1>Manage Blood Inventory</h1>
                    <p>Add received bags or subtract used bags to keep your stock count accurate.</p>
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
                <!-- Update Form -->
                <div class="col-md-5">
                    <div class="hp-card">
                        <div class="hp-card-header">
                            <div class="icon-wrap icon-crimson"><i class="fas fa-edit"></i></div>
                            <h5>Update Stock</h5>
                        </div>
                        <div style="padding:1.5rem;">
                            <div class="msg-box text-center mb-3">
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Small"></asp:Label>
                            </div>
                            <div class="field-group" style="margin-bottom:1.25rem;">
                                <label class="hp-label">Select Blood Group</label>
                                <asp:DropDownList ID="ddlBloodGroup" runat="server" CssClass="hp-select">
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
                            <div class="field-group" style="margin-bottom:1.25rem;">
                                <label class="hp-label">Action</label>
                                <asp:DropDownList ID="ddlAction" runat="server" CssClass="hp-select">
                                    <asp:ListItem Value="Add" Text="+ Add Bags (Received)" />
                                    <asp:ListItem Value="Remove" Text="− Remove Bags (Used)" />
                                </asp:DropDownList>
                            </div>
                            <div class="field-group" style="margin-bottom:1.5rem;">
                                <label class="hp-label">Number of Bags</label>
                                <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" CssClass="hp-input" placeholder="e.g. 5" min="1"></asp:TextBox>
                            </div>
                            <asp:Button ID="btnUpdate" runat="server" Text="Update Inventory" CssClass="btn-hp-primary" Style="width:100%;justify-content:center;" OnClick="btnUpdate_Click" />
                        </div>
                    </div>
                </div>

                <!-- Current Stock -->
                <div class="col-md-7">
                    <div class="hp-card h-100">
                        <div class="hp-card-header">
                            <div class="icon-wrap icon-dark"><i class="fas fa-chart-bar"></i></div>
                            <h5>Current Stock Levels</h5>
                        </div>
                        <div style="padding:1.5rem;">
                            <div class="inventory-stock-grid">
                                <asp:Repeater ID="rptCurrentStock" runat="server">
                                    <ItemTemplate>
                                        <div class="blood-tile <%# Convert.ToInt32(Eval("Quantity")) < 5 ? "low" : "" %>">
                                            <div class="blood-group"><%# Eval("GroupName") %></div>
                                            <div class="blood-qty"><%# Eval("Quantity") %></div>
                                            <div class="blood-label">bags <%# Convert.ToInt32(Eval("Quantity")) < 5 ? "⚠" : "" %></div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <div style="margin-top:1.5rem; padding-top:1.25rem; border-top:1px solid var(--border);">
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <div style="width:12px;height:12px;border-radius:3px;background:var(--crimson);flex-shrink:0;"></div>
                                    <span style="font-size:0.8rem;color:var(--muted);">Red border = below 5 bags (critical threshold)</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
