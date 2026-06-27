<%@ Page Title="Sign In" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="hero_pulse.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .auth-wrap {
        min-height: calc(100vh - 200px);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 4rem 1rem;
        background: linear-gradient(135deg, var(--ivory) 60%, #f9e8ea 100%);
    }
    .auth-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 20px;
        width: 100%;
        max-width: 440px;
        overflow: hidden;
        box-shadow: 0 25px 60px rgba(0,0,0,0.1);
    }
    .auth-card-top {
        background: var(--ink);
        padding: 2.5rem 2.5rem 2rem;
        position: relative;
        overflow: hidden;
    }
    .auth-card-top::before {
        content: '';
        position: absolute;
        top: -40%;
        right: -20%;
        width: 200px; height: 200px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(192,24,42,0.3) 0%, transparent 70%);
    }
    .auth-card-top .brand-dot {
        width: 48px; height: 48px;
        background: var(--crimson);
        border-radius: 12px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.3rem;
        color: #fff;
        margin-bottom: 1.25rem;
        position: relative;
    }
    .auth-card-top h2 {
        font-family: 'Syne', sans-serif;
        font-size: 1.6rem;
        font-weight: 800;
        color: #fff;
        margin-bottom: 0.3rem;
    }
    .auth-card-top p { color: rgba(255,255,255,0.5); font-size: 0.875rem; margin: 0; }
    .auth-card-body { padding: 2rem 2.5rem 2.5rem; }
    .auth-field { margin-bottom: 1.25rem; }
    .auth-field label {
        font-family: 'Syne', sans-serif;
        font-size: 0.72rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        color: var(--muted);
        display: block;
        margin-bottom: 0.5rem;
    }
    .auth-input-wrap { position: relative; }
    .auth-input-wrap i {
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: var(--muted);
        font-size: 0.9rem;
    }
    .auth-input-wrap input {
        width: 100%;
        background: var(--surface-2);
        border: 1.5px solid var(--border);
        border-radius: 10px;
        padding: 0.75rem 1rem 0.75rem 2.75rem;
        font-family: 'DM Sans', sans-serif;
        font-size: 0.95rem;
        color: var(--ink);
        outline: none;
        transition: border-color 0.2s, box-shadow 0.2s;
    }
    .auth-input-wrap input:focus { border-color: var(--crimson); box-shadow: 0 0 0 3px rgba(192,24,42,0.08); background: #fff; }
    .auth-submit {
        width: 100%;
        background: var(--crimson);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 0.85rem;
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 0.95rem;
        cursor: pointer;
        transition: all 0.2s;
        letter-spacing: 0.02em;
        margin-top: 0.5rem;
    }
    .auth-submit:hover { background: var(--crimson-light); transform: translateY(-1px); box-shadow: 0 8px 20px rgba(192,24,42,0.3); }
    .auth-footer { text-align: center; margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid var(--border); font-size: 0.875rem; color: var(--muted); }
    .auth-footer a { color: var(--crimson); font-weight: 600; text-decoration: none; }
    .auth-footer a:hover { text-decoration: underline; }
    .msg-box { text-align: center; margin-bottom: 1rem; min-height: 1.5rem; }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-wrap">
        <div class="auth-card">
            <div class="auth-card-top">
                <div class="brand-dot"><i class="fas fa-tint"></i></div>
                <h2>Welcome Back</h2>
                <p>Sign in to access your Hero Pulse dashboard</p>
            </div>
            <div class="auth-card-body">
                <div class="msg-box">
                    <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="Small"></asp:Label>
                </div>
                <div class="auth-field">
                    <label>Username</label>
                    <div class="auth-input-wrap">
                        <i class="fas fa-user"></i>
                        <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter your username"></asp:TextBox>
                    </div>
                </div>
                <div class="auth-field">
                    <label>Password</label>
                    <div class="auth-input-wrap">
                        <i class="fas fa-lock"></i>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnLogin" runat="server" Text="Sign In to Dashboard" CssClass="auth-submit" OnClick="btnLogin_Click" />
                <div class="auth-footer">
                    Don't have an account? <a href="Register.aspx">Create one here</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
