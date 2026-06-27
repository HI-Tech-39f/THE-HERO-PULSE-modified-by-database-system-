<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="hero_pulse.About" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
<style>
    /* ── PAGE HERO ── */
    .page-hero {
        background: var(--ink);
        padding: 5rem 0 4rem;
        position: relative;
        overflow: hidden;
    }
    .page-hero::before {
        content: '';
        position: absolute;
        inset: 0;
        background-image:
            radial-gradient(circle at 80% 50%, rgba(192,24,42,0.15) 0%, transparent 50%),
            radial-gradient(circle at 10% 80%, rgba(201,149,42,0.06) 0%, transparent 40%);
    }
    .page-hero-content { position: relative; z-index: 2; }
    .page-eyebrow {
        font-family: 'Syne', sans-serif;
        font-size: 0.72rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.2em;
        color: var(--crimson);
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    .page-eyebrow::before {
        content: '';
        display: block;
        width: 28px;
        height: 2px;
        background: var(--crimson);
    }
    .page-hero h1 {
        font-family: 'Syne', sans-serif;
        font-size: clamp(2.5rem, 5vw, 4rem);
        font-weight: 800;
        color: #fff;
        line-height: 1.05;
        margin-bottom: 1.25rem;
        letter-spacing: -0.02em;
    }
    .page-hero h1 em { font-style: normal; color: var(--crimson); }
    .page-hero p {
        color: rgba(255,255,255,0.55);
        font-size: 1.05rem;
        line-height: 1.75;
        max-width: 520px;
    }

    /* ── MISSION STRIP ── */
    .mission-strip {
        background: var(--crimson);
        padding: 2.5rem 0;
    }
    .mission-strip p {
        font-family: 'Syne', sans-serif;
        font-size: 1.35rem;
        font-weight: 700;
        color: #fff;
        text-align: center;
        margin: 0;
        line-height: 1.55;
    }
    .mission-strip span { opacity: 0.65; font-weight: 400; }

    /* ── STORY SECTION ── */
    .section-story { padding: 6rem 0; background: var(--ivory); }
    .story-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        background: rgba(192,24,42,0.08);
        color: var(--crimson);
        border: 1px solid rgba(192,24,42,0.2);
        border-radius: 50px;
        padding: 0.35rem 1rem;
        font-size: 0.78rem;
        font-weight: 600;
        letter-spacing: 0.05em;
        text-transform: uppercase;
        margin-bottom: 1.25rem;
    }
    .section-story h2 {
        font-family: 'Syne', sans-serif;
        font-size: clamp(1.8rem, 3vw, 2.6rem);
        font-weight: 800;
        color: var(--ink);
        line-height: 1.15;
        margin-bottom: 1.25rem;
    }
    .section-story p {
        color: var(--muted);
        font-size: 0.97rem;
        line-height: 1.8;
        margin-bottom: 1.25rem;
    }
    .story-stats-row {
        display: flex;
        gap: 2rem;
        margin-top: 2.5rem;
        padding-top: 2rem;
        border-top: 1px solid var(--border);
        flex-wrap: wrap;
    }
    .story-stat .num {
        font-family: 'Syne', sans-serif;
        font-size: 2.2rem;
        font-weight: 800;
        color: var(--crimson);
        line-height: 1;
    }
    .story-stat .lbl { font-size: 0.78rem; color: var(--muted); margin-top: 0.2rem; letter-spacing: 0.04em; }

    /* ── IMAGE BLOCK ── */
    .story-img-wrap {
        border-radius: 20px;
        overflow: hidden;
        position: relative;
        height: 420px;
    }
    .story-img-wrap img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .img-overlay-badge {
        position: absolute;
        bottom: 1.5rem;
        left: 1.5rem;
        background: var(--ink);
        color: #fff;
        padding: 0.75rem 1.25rem;
        border-radius: 12px;
        border: 1px solid rgba(255,255,255,0.1);
    }
    .img-overlay-badge .ov-num {
        font-family: 'Syne', sans-serif;
        font-size: 1.6rem;
        font-weight: 800;
        color: var(--crimson);
        line-height: 1;
    }
    .img-overlay-badge .ov-lbl { font-size: 0.75rem; color: rgba(255,255,255,0.55); margin-top: 0.1rem; }

    /* ── VALUES ── */
    .section-values { padding: 5.5rem 0; background: var(--ink); }
    .values-title {
        font-family: 'Syne', sans-serif;
        font-size: clamp(1.8rem, 3vw, 2.5rem);
        font-weight: 800;
        color: #fff;
        margin-bottom: 0.5rem;
    }
    .values-sub { color: rgba(255,255,255,0.45); font-size: 0.95rem; margin-bottom: 3rem; line-height: 1.7; }
    .value-card {
        background: rgba(255,255,255,0.04);
        border: 1px solid rgba(255,255,255,0.09);
        border-radius: 16px;
        padding: 2rem;
        height: 100%;
        transition: all 0.25s;
    }
    .value-card:hover {
        background: rgba(255,255,255,0.07);
        border-color: rgba(192,24,42,0.4);
        transform: translateY(-4px);
    }
    .value-icon {
        width: 48px;
        height: 48px;
        background: var(--crimson);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: 1.1rem;
        margin-bottom: 1.25rem;
    }
    .value-card h5 {
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 1.05rem;
        color: #fff;
        margin-bottom: 0.6rem;
    }
    .value-card p { font-size: 0.875rem; color: rgba(255,255,255,0.45); line-height: 1.7; margin: 0; }

    /* ── TEAM ── */
    .section-team { padding: 5.5rem 0; background: var(--ivory); }
    .team-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 16px;
        overflow: hidden;
        transition: all 0.25s;
        text-align: center;
    }
    .team-card:hover { transform: translateY(-5px); box-shadow: 0 16px 40px rgba(0,0,0,0.1); }
    .team-card-img {
        width: 100%;
        height: 220px;
        background: linear-gradient(135deg, var(--ink) 0%, var(--ink-soft) 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 3.5rem;
        color: rgba(255,255,255,0.15);
    }
    .team-card-body { padding: 1.5rem; }
    .team-card h5 {
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 1rem;
        color: var(--ink);
        margin-bottom: 0.25rem;
    }
    .team-card .role { font-size: 0.8rem; color: var(--crimson); font-weight: 600; letter-spacing: 0.04em; }
    .team-card .bio { font-size: 0.82rem; color: var(--muted); margin-top: 0.75rem; line-height: 1.6; }

    /* ── CTA ── */
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
        background: #fff; color: var(--crimson);
        text-decoration: none; padding: 0.9rem 2.5rem;
        border-radius: 10px; font-family: 'Syne', sans-serif;
        font-weight: 700; font-size: 0.95rem;
        transition: all 0.25s;
        display: inline-flex; align-items: center; gap: 0.6rem;
    }
    .btn-cta-white:hover { background: var(--ivory); color: var(--crimson); transform: translateY(-2px); box-shadow: 0 10px 25px rgba(0,0,0,0.15); }
    .btn-cta-outline-white {
        background: transparent; color: rgba(255,255,255,0.85);
        text-decoration: none; padding: 0.85rem 2.5rem;
        border-radius: 10px; border: 2px solid rgba(255,255,255,0.4);
        font-family: 'Syne', sans-serif; font-weight: 600; font-size: 0.95rem;
        transition: all 0.25s;
        display: inline-flex; align-items: center; gap: 0.6rem;
    }
    .btn-cta-outline-white:hover { border-color: #fff; color: #fff; background: rgba(255,255,255,0.07); }

    @media (max-width: 768px) {
        .story-img-wrap { height: 280px; margin-bottom: 2rem; }
        .story-stats-row { gap: 1.25rem; }
    }
</style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- PAGE HERO --%>
    <section class="page-hero">
        <div class="container page-hero-content">
            <div class="page-eyebrow">Our Story</div>
            <h1>Saving Lives Through<br><em>Smarter</em> Connections</h1>
            <p>Hero Pulse was born from a simple truth — thousands of Pakistanis die every year due to blood shortages that shouldn't exist. We built the platform to fix that.</p>
        </div>
    </section>

    <%-- MISSION STRIP --%>
    <div class="mission-strip">
        <div class="container">
            <p>"Our mission is to ensure <span>no patient in Pakistan ever loses their life</span> because the right blood wasn't available in time."</p>
        </div>
    </div>

    <%-- STORY SECTION --%>
    <section class="section-story">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <div class="story-img-wrap">
                        <img src="images/img_1.jpeg" alt="Blood Donation" />
                        <div class="img-overlay-badge">
                            <div class="ov-num">
                                <asp:Label ID="lblDonors" runat="server" Text="500"></asp:Label>+
                            </div>
                            <div class="ov-lbl">Active Donors Nationwide</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="story-badge"><i class="fas fa-heart"></i> Who We Are</div>
                    <h2>Built by Pakistanis,<br>for Pakistan's People</h2>
                    <p>Hero Pulse is a digital blood bank management platform connecting donors, patients, and hospitals across Pakistan in real time. We started as a student project born out of frustration with the broken, manual blood donation system — and grew into a full platform trusted by hospitals and donors alike.</p>
                    <p>Our platform automates the entire chain: donors register once, hospitals post urgent needs, and our auto-matching engine instantly connects the right donor based on blood type compatibility and location — no phone calls, no delays.</p>
                    <div class="story-stats-row">
                        <div class="story-stat">
                            <div class="num"><asp:Label ID="lblStatDonors" runat="server" Text="500"></asp:Label>+</div>
                            <div class="lbl">Registered Donors</div>
                        </div>
                        <div class="story-stat">
                            <div class="num"><asp:Label ID="lblStatLives" runat="server" Text="200"></asp:Label>+</div>
                            <div class="lbl">Lives Saved</div>
                        </div>
                        <div class="story-stat">
                            <div class="num"><asp:Label ID="lblStatHospitals" runat="server" Text="20"></asp:Label>+</div>
                            <div class="lbl">Partner Hospitals</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%-- VALUES --%>
    <section class="section-values">
        <div class="container">
            <div class="row mb-5">
                <div class="col-lg-6">
                    <h2 class="values-title">What We Stand For</h2>
                    <p class="values-sub">Every decision we make is guided by these core values — from how we build our platform to how we treat donors and patients.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-3">
                    <div class="value-card">
                        <div class="value-icon"><i class="fas fa-bolt"></i></div>
                        <h5>Speed</h5>
                        <p>When blood is needed, every second counts. Our matching engine works instantly — no delays, no manual steps.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="value-card">
                        <div class="value-icon"><i class="fas fa-shield-alt"></i></div>
                        <h5>Safety</h5>
                        <p>All donors are medically screened at registration. We enforce eligibility rules strictly to protect both donors and recipients.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="value-card">
                        <div class="value-icon"><i class="fas fa-eye"></i></div>
                        <h5>Transparency</h5>
                        <p>Every donation is logged with a full audit trail. Hospitals and admins can see live inventory and request history at all times.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="value-card">
                        <div class="value-icon"><i class="fas fa-hands-helping"></i></div>
                        <h5>Community</h5>
                        <p>We believe every Pakistani can be a hero. We celebrate donors and make the act of giving blood as easy and rewarding as possible.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%-- TEAM --%>
    <section class="section-team">
        <div class="container">
            <div class="text-center mb-5">
                <span class="story-badge" style="margin-bottom:1rem;display:inline-flex;"><i class="fas fa-users"></i> The Team</span>
                <h2 class="font-display fw-800" style="font-size:2.2rem;color:var(--ink);">The People Behind Hero Pulse</h2>
                <p style="color:var(--muted);max-width:480px;margin:0.75rem auto 0;font-size:0.95rem;line-height:1.7;">A passionate team of developers and health advocates who believe technology can save lives.</p>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-sm-6 col-lg-3">
                    <div class="team-card">
                        <div class="team-card-img"><i class="fas fa-user-tie"></i></div>
                        <div class="team-card-body">
                            <h5>Project Lead</h5>
                            <div class="role">Founder & Developer</div>
                            <div class="bio">Architected the full-stack platform on ASP.NET and SQL Server. Focused on auto-matching logic and system reliability.</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="team-card">
                        <div class="team-card-img"><i class="fas fa-laptop-code"></i></div>
                        <div class="team-card-body">
                            <h5>UI/UX Developer</h5>
                            <div class="role">Frontend & Design</div>
                            <div class="bio">Designed the responsive interface and user experience across all dashboards — donor, hospital, admin, and receptor.</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="team-card">
                        <div class="team-card-img"><i class="fas fa-database"></i></div>
                        <div class="team-card-body">
                            <h5>Database Engineer</h5>
                            <div class="role">Backend & SQL</div>
                            <div class="bio">Designed the SQL Server schema, stored procedures, and inventory management logic that powers the platform.</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="team-card">
                        <div class="team-card-img"><i class="fas fa-stethoscope"></i></div>
                        <div class="team-card-body">
                            <h5>Medical Advisor</h5>
                            <div class="role">Healthcare Consultant</div>
                            <div class="bio">Validated all blood compatibility logic, donor eligibility rules, and healthcare compliance standards used in the system.</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%-- CTA --%>
    <section class="cta-banner">
        <div class="container position-relative">
            <div class="row">
                <div class="col-lg-7">
                    <h2>Become Part of the Mission</h2>
                    <p>Join our growing network of donors and hospitals. Together we can make sure no life is lost due to a blood shortage.</p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="Register.aspx" class="btn-cta-white"><i class="fas fa-user-plus"></i> Register Now</a>
                        <a href="Contact.aspx" class="btn-cta-outline-white"><i class="fas fa-envelope"></i> Contact Us</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
