<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="hero_pulse.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    /* ── HERO ── */
    .hero {
        background: var(--ink);
        min-height: 92vh;
        display: flex;
        align-items: center;
        position: relative;
        overflow: hidden;
        padding: 0;
        margin-bottom: 0;
    }
    .hero-bg-pattern {
        position: absolute; inset: 0;
        background-image:
            radial-gradient(circle at 70% 50%, rgba(192,24,42,0.18) 0%, transparent 55%),
            radial-gradient(circle at 15% 80%, rgba(201,149,42,0.07) 0%, transparent 40%);
    }
    .hero-grid-lines {
        position: absolute; inset: 0;
        background-image: linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
                          linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
        background-size: 60px 60px;
    }
    .hero-content {
        position: relative;
        z-index: 2;
        padding: 6rem 0 4rem;
        width: 100%;
    }
    .hero-eyebrow {
        font-family: 'Syne', sans-serif;
        font-size: 0.72rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.2em;
        color: var(--crimson);
        margin-bottom: 1.25rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    .hero-eyebrow::before {
        content: '';
        display: block;
        width: 30px;
        height: 2px;
        background: var(--crimson);
    }
    .hero-h1 {
        font-family: 'Syne', sans-serif;
        font-size: clamp(3rem, 7vw, 5.5rem);
        font-weight: 800;
        color: #fff;
        line-height: 1.0;
        margin-bottom: 1.5rem;
        letter-spacing: -0.02em;
    }
    .hero-h1 em {
        font-style: normal;
        color: var(--crimson);
        position: relative;
    }
    .hero-sub {
        color: rgba(255,255,255,0.55);
        font-size: 1.1rem;
        line-height: 1.7;
        max-width: 480px;
        margin-bottom: 2.5rem;
    }
    .hero-actions { display: flex; gap: 1rem; flex-wrap: wrap; }
    .btn-hero-main {
        background: var(--crimson);
        color: #fff;
        text-decoration: none;
        padding: 0.9rem 2rem;
        border-radius: 10px;
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 0.95rem;
        transition: all 0.25s;
        display: inline-flex; align-items: center; gap: 0.6rem;
        letter-spacing: 0.01em;
    }
    .btn-hero-main:hover { background: var(--crimson-light); color: #fff; transform: translateY(-2px); box-shadow: 0 10px 30px rgba(192,24,42,0.4); }
    .btn-hero-outline {
        background: transparent;
        color: rgba(255,255,255,0.8);
        text-decoration: none;
        padding: 0.85rem 2rem;
        border-radius: 10px;
        border: 1.5px solid rgba(255,255,255,0.2);
        font-family: 'Syne', sans-serif;
        font-weight: 600;
        font-size: 0.95rem;
        transition: all 0.25s;
        display: inline-flex; align-items: center; gap: 0.6rem;
    }
    .btn-hero-outline:hover { border-color: rgba(255,255,255,0.6); color: #fff; background: rgba(255,255,255,0.05); }

    /* ── HERO STATS STRIP ── */
    .hero-stats {
        display: flex;
        gap: 2.5rem;
        margin-top: 3rem;
        padding-top: 2.5rem;
        border-top: 1px solid rgba(255,255,255,0.1);
    }
    .hero-stat .num {
        font-family: 'Syne', sans-serif;
        font-size: 2rem;
        font-weight: 800;
        color: #fff;
        line-height: 1;
    }
    .hero-stat .lbl { font-size: 0.78rem; color: rgba(255,255,255,0.45); margin-top: 0.2rem; letter-spacing: 0.05em; }

    /* ── BLOOD TYPE VISUAL ── */
    .hero-visual {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100%;
        padding: 4rem 0;
    }
    .blood-ring {
        width: 360px;
        height: 360px;
        border-radius: 50%;
        border: 1.5px solid rgba(192,24,42,0.25);
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        animation: spin-slow 20s linear infinite;
    }
    @keyframes spin-slow { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
    .blood-ring-inner {
        width: 280px;
        height: 280px;
        border-radius: 50%;
        border: 1px solid rgba(192,24,42,0.15);
        display: flex;
        align-items: center;
        justify-content: center;
        animation: spin-slow 20s linear infinite reverse;
    }
    .blood-center-box {
        width: 180px;
        height: 180px;
        background: var(--crimson);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        animation: none;
        animation: pulse-glow 2.5s ease-in-out infinite;
    }
    @keyframes pulse-glow {
        0%, 100% { box-shadow: 0 0 40px rgba(192,24,42,0.5); }
        50% { box-shadow: 0 0 80px rgba(192,24,42,0.7); }
    }
    .blood-center-box .big-type {
        font-family: 'Syne', sans-serif;
        font-size: 3rem;
        font-weight: 800;
        color: #fff;
        line-height: 1;
    }
    .blood-center-box .sub-type { color: rgba(255,255,255,0.7); font-size: 0.7rem; letter-spacing: 0.1em; text-transform: uppercase; margin-top: 0.25rem; }
    .blood-orbit-dot {
        position: absolute;
        width: 38px;
        height: 38px;
        background: var(--ink-soft);
        border: 2px solid rgba(192,24,42,0.4);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Syne', sans-serif;
        font-size: 0.65rem;
        font-weight: 800;
        color: rgba(255,255,255,0.7);
    }

    /* ── HOW IT WORKS ── */
    .section-works { padding: 6rem 0; background: var(--ivory); }
    .works-step {
        display: flex;
        gap: 1.5rem;
        margin-bottom: 2.5rem;
        padding: 1.75rem;
        background: var(--surface);
        border-radius: 14px;
        border: 1px solid var(--border);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .works-step:hover { transform: translateX(6px); box-shadow: 0 8px 25px rgba(0,0,0,0.06); }
    .step-num {
        width: 44px;
        height: 44px;
        background: var(--crimson);
        color: #fff;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Syne', sans-serif;
        font-weight: 800;
        font-size: 1rem;
        flex-shrink: 0;
    }
    .step-content h5 { font-family: 'Syne', sans-serif; font-weight: 700; font-size: 1rem; margin-bottom: 0.35rem; }
    .step-content p { font-size: 0.875rem; color: var(--muted); margin: 0; line-height: 1.6; }

    /* ── WHO CAN DONATE ── */
    .section-eligibility { padding: 5rem 0; background: var(--ink); }
    .eligibility-title {
        font-family: 'Syne', sans-serif;
        font-size: 2.5rem;
        font-weight: 800;
        color: #fff;
        margin-bottom: 0.75rem;
    }
    .eligibility-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-top: 2.5rem; }
    .eligibility-item {
        background: rgba(255,255,255,0.05);
        border: 1px solid rgba(255,255,255,0.1);
        border-radius: 12px;
        padding: 1.25rem;
        display: flex;
        gap: 0.9rem;
        align-items: flex-start;
    }
    .eligibility-item .ei-icon { color: var(--crimson); font-size: 1.1rem; margin-top: 2px; flex-shrink: 0; }
    .eligibility-item h6 { font-family: 'Syne', sans-serif; font-size: 0.9rem; font-weight: 700; color: #fff; margin-bottom: 0.2rem; }
    .eligibility-item p { font-size: 0.8rem; color: rgba(255,255,255,0.5); margin: 0; line-height: 1.5; }

    /* ── CTA BANNER ── */
    .cta-banner {
        background: var(--crimson);
        padding: 5rem 0;
        position: relative;
        overflow: hidden;
    }
    .cta-banner::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -5%;
        width: 500px; height: 500px;
        border-radius: 50%;
        background: rgba(255,255,255,0.06);
    }
    .cta-banner h2 { font-family: 'Syne', sans-serif; font-size: 2.5rem; font-weight: 800; color: #fff; margin-bottom: 1rem; }
    .cta-banner p { color: rgba(255,255,255,0.7); font-size: 1.05rem; margin-bottom: 2rem; }
    .btn-cta-white {
        background: #fff;
        color: var(--crimson);
        text-decoration: none;
        padding: 0.9rem 2.5rem;
        border-radius: 10px;
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 0.95rem;
        transition: all 0.25s;
        display: inline-flex; align-items: center; gap: 0.6rem;
    }
    .btn-cta-white:hover { background: var(--ivory); color: var(--crimson); transform: translateY(-2px); box-shadow: 0 10px 25px rgba(0,0,0,0.15); }
    .btn-cta-outline-white {
        background: transparent;
        color: rgba(255,255,255,0.85);
        text-decoration: none;
        padding: 0.85rem 2.5rem;
        border-radius: 10px;
        border: 2px solid rgba(255,255,255,0.4);
        font-family: 'Syne', sans-serif;
        font-weight: 600;
        font-size: 0.95rem;
        transition: all 0.25s;
        display: inline-flex; align-items: center; gap: 0.6rem;
    }
    .btn-cta-outline-white:hover { border-color: #fff; color: #fff; background: rgba(255,255,255,0.07); }

    /* ── BLOOD COMPAT SECTION ── */
    .compat-section { padding: 5rem 0; background: var(--ivory); }
    .compat-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 0.75rem;
        margin-top: 2rem;
    }
    .compat-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.25rem;
        text-align: center;
        transition: all 0.2s;
    }
    .compat-card:hover { transform: translateY(-4px); box-shadow: 0 10px 25px rgba(0,0,0,0.08); }
    .compat-card .group-name { font-family: 'Syne', sans-serif; font-size: 1.6rem; font-weight: 800; color: var(--crimson); }
    .compat-card .compat-label { font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--muted); margin-bottom: 0.5rem; }
    .compat-card .compat-list { font-size: 0.8rem; color: var(--muted); line-height: 1.6; }

    @media (max-width: 768px) {
        .hero-visual { display: none; }
        .compat-grid { grid-template-columns: repeat(2, 1fr); }
        .eligibility-grid { grid-template-columns: 1fr; }
        .hero-stats { gap: 1.5rem; flex-wrap: wrap; }
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="hero">
        <div class="hero-bg-pattern"></div>
        <div class="hero-grid-lines"></div>
        <div class="hero-content">
            <div class="container">
                <div class="row align-items-center" style="min-height:80vh;">
                    <div class="col-lg-6">
                        <div class="hero-eyebrow">Pakistan's Blood Network</div>
                        <h1 class="hero-h1">
                            Every Drop<br>
                            <em>Saves</em> a Life
                        </h1>
                        <p class="hero-sub">
                            Hero Pulse connects blood donors, patients, and hospitals in real time. Register today and become part of Pakistan's most trusted blood donation network.
                        </p>
                        <div class="hero-actions">
                            <a href="Register.aspx" class="btn-hero-main">
                                <i class="fas fa-tint"></i> Become a Donor
                            </a>
                            <a href="Login.aspx" class="btn-hero-outline">
                                <i class="fas fa-arrow-right"></i> Sign In
                            </a>
                        </div>
                        <div class="hero-stats">
                            <div class="hero-stat">
                                <div class="num"><asp:Label ID="lblTotalDonors" runat="server" Text="0"></asp:Label>+</div>
                                <div class="lbl">Donors</div>
                            </div>
                            <div class="hero-stat">
                                <div class="num"><asp:Label ID="lblLivesSaved" runat="server" Text="0"></asp:Label>+</div>
                                <div class="lbl">Lives Saved</div>
                            </div>
                            <div class="hero-stat">
                                <div class="num"><asp:Label ID="lblHospitals" runat="server" Text="0"></asp:Label>+</div>
                                <div class="lbl">Hospitals</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 d-none d-lg-flex justify-content-center">
                        <div class="hero-visual">
                            <div class="blood-ring">
                                <div class="blood-ring-inner">
                                    <div class="blood-center-box">
                                        <div class="big-type">O−</div>
                                        <div class="sub-type">Universal</div>
                                    </div>
                                </div>
                                <div class="blood-orbit-dot" style="top:5%;left:50%;transform:translate(-50%);">A+</div>
                                <div class="blood-orbit-dot" style="top:50%;right:-2%;transform:translateY(-50%);">B+</div>
                                <div class="blood-orbit-dot" style="bottom:5%;left:50%;transform:translate(-50%);">AB+</div>
                                <div class="blood-orbit-dot" style="top:50%;left:-2%;transform:translateY(-50%);">O+</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section-works">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-5 mb-lg-0">
                    <span class="section-eyebrow">Simple Process</span>
                    <h2 class="font-display fw-800" style="font-size:2.2rem;line-height:1.15;margin-bottom:1rem;">How Hero Pulse Works</h2>
                    <p style="color:var(--muted);font-size:0.95rem;line-height:1.7;margin-bottom:2rem;">Our platform makes blood donation effortless — from matching donors to confirming life-saving transactions.</p>
                    <a href="Register.aspx" class="btn-hp-primary">Get Started <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="col-lg-7 offset-lg-1">
                    <div class="works-step fade-up">
                        <div class="step-num">1</div>
                        <div class="step-content">
                            <h5>Create Your Profile</h5>
                            <p>Register as a Donor, Hospital, or Patient. Donors complete a quick medical screening to confirm eligibility (age 18+, weight 50kg+, no chronic illness).</p>
                        </div>
                    </div>
                    <div class="works-step fade-up delay-1">
                        <div class="step-num">2</div>
                        <div class="step-content">
                            <h5>Emergency Request is Broadcast</h5>
                            <p>Hospitals and patients in need submit requests. Our auto-matching engine instantly alerts compatible donors using blood compatibility rules.</p>
                        </div>
                    </div>
                    <div class="works-step fade-up delay-2">
                        <div class="step-num">3</div>
                        <div class="step-content">
                            <h5>Donor Accepts & Donates</h5>
                            <p>Matched donors accept the request directly from their dashboard, show up, and donate. The hospital confirms the arrival to update live inventory.</p>
                        </div>
                    </div>
                    <div class="works-step fade-up delay-3">
                        <div class="step-num">4</div>
                        <div class="step-content">
                            <h5>Loop Closes, Life Saved</h5>
                            <p>The donation is logged, inventory is updated, and the donor's 90-day cooldown starts. Every step is recorded for a full audit trail.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section-eligibility">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-5 mb-4 mb-lg-0">
                    <span class="section-eyebrow" style="color:rgba(192,24,42,0.9);">Who Can Donate</span>
                    <h2 class="eligibility-title">Donor Eligibility Requirements</h2>
                    <p style="color:rgba(255,255,255,0.5);font-size:0.95rem;line-height:1.7;">Hero Pulse performs medical screening at registration to keep both donors and recipients safe.</p>
                </div>
                <div class="col-lg-6 offset-lg-1">
                    <div class="eligibility-grid">
                        <div class="eligibility-item">
                            <i class="fas fa-birthday-cake ei-icon"></i>
                            <div>
                                <h6>Age 18–65</h6>
                                <p>Must be between 18 and 65 years old at time of donation.</p>
                            </div>
                        </div>
                        <div class="eligibility-item">
                            <i class="fas fa-weight ei-icon"></i>
                            <div>
                                <h6>Weight ≥ 50kg</h6>
                                <p>Minimum body weight of 50 kilograms required for safe donation.</p>
                            </div>
                        </div>
                        <div class="eligibility-item">
                            <i class="fas fa-heartbeat ei-icon"></i>
                            <div>
                                <h6>No Chronic Illness</h6>
                                <p>Donors with HIV, Cancer, or major chronic diseases cannot donate.</p>
                            </div>
                        </div>
                        <div class="eligibility-item">
                            <i class="fas fa-calendar-check ei-icon"></i>
                            <div>
                                <h6>90-Day Cooldown</h6>
                                <p>At least 90 days must pass between each blood donation session.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="compat-section">
        <div class="container">
            <div class="text-center mb-4">
                <span class="section-eyebrow">Medical Reference</span>
                <h2 class="font-display fw-800" style="font-size:2rem;">Blood Type Compatibility</h2>
                <p style="color:var(--muted);font-size:0.9rem;margin-top:0.5rem;">Our auto-matching engine uses these medical rules to find the right donor instantly.</p>
            </div>
            <div class="compat-grid">
                <div class="compat-card">
                    <div class="compat-label">Blood Group</div>
                    <div class="group-name">O−</div>
                    <div class="compat-label mt-2">Donates To</div>
                    <div class="compat-list">All Groups (Universal Donor)</div>
                </div>
                <div class="compat-card">
                    <div class="compat-label">Blood Group</div>
                    <div class="group-name">O+</div>
                    <div class="compat-label mt-2">Donates To</div>
                    <div class="compat-list">O+, A+, B+, AB+</div>
                </div>
                <div class="compat-card">
                    <div class="compat-label">Blood Group</div>
                    <div class="group-name">A+</div>
                    <div class="compat-label mt-2">Donates To</div>
                    <div class="compat-list">A+, AB+</div>
                </div>
                <div class="compat-card">
                    <div class="compat-label">Blood Group</div>
                    <div class="group-name">A−</div>
                    <div class="compat-label mt-2">Donates To</div>
                    <div class="compat-list">A−, A+, AB−, AB+</div>
                </div>
                <div class="compat-card">
                    <div class="compat-label">Blood Group</div>
                    <div class="group-name">B+</div>
                    <div class="compat-label mt-2">Donates To</div>
                    <div class="compat-list">B+, AB+</div>
                </div>
                <div class="compat-card">
                    <div class="compat-label">Blood Group</div>
                    <div class="group-name">B−</div>
                    <div class="compat-label mt-2">Donates To</div>
                    <div class="compat-list">B−, B+, AB−, AB+</div>
                </div>
                <div class="compat-card">
                    <div class="compat-label">Blood Group</div>
                    <div class="group-name">AB+</div>
                    <div class="compat-label mt-2">Receives From</div>
                    <div class="compat-list">All Groups (Universal Recipient)</div>
                </div>
                <div class="compat-card">
                    <div class="compat-label">Blood Group</div>
                    <div class="group-name">AB−</div>
                    <div class="compat-label mt-2">Donates To</div>
                    <div class="compat-list">AB−, AB+</div>
                </div>
            </div>
        </div>
    </section>

    <section class="cta-banner">
        <div class="container position-relative">
            <div class="row">
                <div class="col-lg-7">
                    <h2>Ready to Be a Hero?</h2>
                    <p>Join thousands of registered donors across Pakistan. Your blood group could be exactly what a patient needs right now.</p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="Register.aspx" class="btn-cta-white"><i class="fas fa-user-plus"></i> Register Now</a>
                        <a href="Login.aspx" class="btn-cta-outline-white"><i class="fas fa-sign-in-alt"></i> Sign In</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
