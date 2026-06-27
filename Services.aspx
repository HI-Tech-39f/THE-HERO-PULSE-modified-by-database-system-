<%@ Page Title="Services" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Services.aspx.cs" Inherits="hero_pulse.Services" %>

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
            radial-gradient(circle at 75% 50%, rgba(192,24,42,0.15) 0%, transparent 55%),
            radial-gradient(circle at 10% 70%, rgba(201,149,42,0.06) 0%, transparent 40%);
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
        max-width: 560px;
    }

    /* ── SERVICES OVERVIEW ── */
    .section-services { padding: 6rem 0; background: var(--ivory); }
    .service-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 18px;
        padding: 2.25rem;
        height: 100%;
        transition: all 0.25s;
        position: relative;
        overflow: hidden;
    }
    .service-card::after {
        content: '';
        position: absolute;
        bottom: 0; left: 0; right: 0;
        height: 3px;
        background: var(--crimson);
        transform: scaleX(0);
        transition: transform 0.3s;
        transform-origin: left;
    }
    .service-card:hover { transform: translateY(-6px); box-shadow: 0 20px 50px rgba(0,0,0,0.09); }
    .service-card:hover::after { transform: scaleX(1); }
    .service-icon {
        width: 56px;
        height: 56px;
        background: rgba(192,24,42,0.1);
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--crimson);
        font-size: 1.3rem;
        margin-bottom: 1.5rem;
        transition: all 0.25s;
    }
    .service-card:hover .service-icon {
        background: var(--crimson);
        color: #fff;
    }
    .service-card h4 {
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 1.15rem;
        color: var(--ink);
        margin-bottom: 0.75rem;
    }
    .service-card p { font-size: 0.9rem; color: var(--muted); line-height: 1.75; margin: 0; }
    .service-tag {
        display: inline-block;
        background: rgba(192,24,42,0.07);
        color: var(--crimson);
        border-radius: 20px;
        padding: 0.2rem 0.75rem;
        font-size: 0.7rem;
        font-weight: 600;
        letter-spacing: 0.05em;
        text-transform: uppercase;
        margin-bottom: 1rem;
    }

    /* ── FEATURE DETAIL ── */
    .section-feature { padding: 5.5rem 0; }
    .section-feature.alt { background: var(--ink); }
    .section-feature:not(.alt) { background: var(--ivory); }

    .feature-label {
        font-family: 'Syne', sans-serif;
        font-size: 0.72rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.18em;
        color: var(--crimson);
        margin-bottom: 0.9rem;
    }
    .feature-title {
        font-family: 'Syne', sans-serif;
        font-size: clamp(1.8rem, 3vw, 2.4rem);
        font-weight: 800;
        line-height: 1.15;
        margin-bottom: 1rem;
    }
    .section-feature:not(.alt) .feature-title { color: var(--ink); }
    .section-feature.alt .feature-title { color: #fff; }

    .feature-desc { font-size: 0.97rem; line-height: 1.8; margin-bottom: 2rem; }
    .section-feature:not(.alt) .feature-desc { color: var(--muted); }
    .section-feature.alt .feature-desc { color: rgba(255,255,255,0.5); }

    .feature-list { list-style: none; padding: 0; margin: 0; }
    .feature-list li {
        display: flex;
        gap: 0.75rem;
        align-items: flex-start;
        margin-bottom: 0.85rem;
        font-size: 0.9rem;
        line-height: 1.6;
    }
    .section-feature:not(.alt) .feature-list li { color: var(--ink); }
    .section-feature.alt .feature-list li { color: rgba(255,255,255,0.75); }
    .feature-list li i { color: var(--crimson); margin-top: 3px; flex-shrink: 0; font-size: 0.8rem; }

    .feature-visual {
        background: var(--ink-soft);
        border-radius: 18px;
        overflow: hidden;
        height: 360px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }
    .feature-visual img { width: 100%; height: 100%; object-fit: cover; }

    .feature-visual-dark {
        background: rgba(255,255,255,0.04);
        border: 1px solid rgba(255,255,255,0.1);
    }

    /* ── BLOOD TYPES PANEL ── */
    .section-blood { padding: 5rem 0; background: var(--surface); }
    .blood-compat-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 0.75rem;
        margin-top: 2.5rem;
    }
    .bct-card {
        background: var(--ivory);
        border: 1px solid var(--border);
        border-radius: 14px;
        padding: 1.25rem;
        text-align: center;
        transition: all 0.2s;
    }
    .bct-card:hover { transform: translateY(-4px); box-shadow: 0 10px 25px rgba(0,0,0,0.07); border-color: var(--crimson); }
    .bct-card .bct-group { font-family: 'Syne', sans-serif; font-size: 1.7rem; font-weight: 800; color: var(--crimson); }
    .bct-card .bct-lbl { font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--muted); margin-bottom: 0.4rem; }
    .bct-card .bct-list { font-size: 0.8rem; color: var(--muted); line-height: 1.6; }

    /* ── WHO WE SERVE ── */
    .section-users { padding: 5.5rem 0; background: var(--ink); }
    .user-card {
        background: rgba(255,255,255,0.04);
        border: 1px solid rgba(255,255,255,0.09);
        border-radius: 18px;
        padding: 2.25rem;
        height: 100%;
        transition: all 0.25s;
    }
    .user-card:hover { background: rgba(255,255,255,0.07); border-color: rgba(192,24,42,0.4); transform: translateY(-4px); }
    .user-num {
        font-family: 'Syne', sans-serif;
        font-size: 2.5rem;
        font-weight: 800;
        color: var(--crimson);
        line-height: 1;
        margin-bottom: 0.1rem;
    }
    .user-card h5 { font-family: 'Syne', sans-serif; font-weight: 700; font-size: 1.1rem; color: #fff; margin-bottom: 0.75rem; }
    .user-card p { font-size: 0.875rem; color: rgba(255,255,255,0.45); line-height: 1.75; margin: 0; }
    .user-card .user-tag {
        display: inline-block;
        background: rgba(192,24,42,0.15);
        color: rgba(192,24,42,0.9);
        border-radius: 20px;
        padding: 0.2rem 0.75rem;
        font-size: 0.68rem;
        font-weight: 600;
        letter-spacing: 0.05em;
        text-transform: uppercase;
        margin-bottom: 1.25rem;
    }

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
        top: -50%; right: -5%;
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
        font-weight: 700; font-size: 0.95rem; transition: all 0.25s;
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
        .blood-compat-grid { grid-template-columns: repeat(2,1fr); }
        .feature-visual { height: 240px; margin-bottom: 2rem; }
    }
</style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- PAGE HERO --%>
    <section class="page-hero">
        <div class="container page-hero-content">
            <div class="page-eyebrow">What We Offer</div>
            <h1>Services That Power<br>Pakistan's <em>Blood Network</em></h1>
            <p>From real-time donor matching to live inventory management — Hero Pulse gives every stakeholder the tools they need to save lives faster.</p>
        </div>
    </section>

    <%-- SERVICES OVERVIEW GRID --%>
    <section class="section-services">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="font-display fw-800" style="font-size:2rem;color:var(--ink);">Everything in One Platform</h2>
                <p style="color:var(--muted);max-width:500px;margin:0.75rem auto 0;font-size:0.95rem;line-height:1.7;">Hero Pulse consolidates the entire blood donation chain into a single, seamless digital experience.</p>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="service-card">
                        <div class="service-tag">Core</div>
                        <div class="service-icon"><i class="fas fa-bolt"></i></div>
                        <h4>Auto-Matching Engine</h4>
                        <p>When a blood request is submitted, our engine instantly identifies compatible donors using medical-grade ABO &amp; Rh compatibility rules and alerts them in real time.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="service-card">
                        <div class="service-tag">Donors</div>
                        <div class="service-icon"><i class="fas fa-tint"></i></div>
                        <h4>Donor Registration &amp; Dashboard</h4>
                        <p>Donors register once with blood type and medical info. Their dashboard shows active requests, donation history, eligibility status, and a 90-day cooldown tracker.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="service-card">
                        <div class="service-tag">Hospitals</div>
                        <div class="service-icon"><i class="fas fa-hospital"></i></div>
                        <h4>Hospital Blood Requests</h4>
                        <p>Registered hospitals can post urgent blood requests specifying type and units needed. The system broadcasts to matched donors and tracks fulfilment in real time.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="service-card">
                        <div class="service-tag">Inventory</div>
                        <div class="service-icon"><i class="fas fa-boxes"></i></div>
                        <h4>Live Blood Inventory</h4>
                        <p>Hospital staff manage blood stock in real time. Each confirmed donation automatically updates inventory levels, providing an always-accurate blood bank view.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="service-card">
                        <div class="service-tag">Receptors</div>
                        <div class="service-icon"><i class="fas fa-user-injured"></i></div>
                        <h4>Patient Blood Requests</h4>
                        <p>Patients (receptors) can submit emergency blood requests directly. Our receptor dashboard shows request status, matched donors, and fulfilment updates.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="service-card">
                        <div class="service-tag">Admin</div>
                        <div class="service-icon"><i class="fas fa-chart-bar"></i></div>
                        <h4>Admin Control Panel</h4>
                        <p>Administrators oversee the full network — managing users, verifying hospitals, monitoring system-wide donations, and generating performance reports.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%-- FEATURE: MATCHING --%>
    <section class="section-feature">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <div class="feature-visual">
                        <img src="images/monitoring.png" alt="Blood Matching" />
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="feature-label">Auto-Match Technology</div>
                    <h2 class="feature-title">The Right Donor, Found in Seconds</h2>
                    <p class="feature-desc">Our matching engine doesn't guess — it follows the same ABO &amp; Rh compatibility matrix used by medical professionals worldwide. The moment a request is submitted, it scans all registered donors, filters by blood type compatibility, and sends instant alerts.</p>
                    <ul class="feature-list">
                        <li><i class="fas fa-check-circle"></i> ABO &amp; Rh factor compatibility matrix built-in</li>
                        <li><i class="fas fa-check-circle"></i> Donor 90-day cooldown enforcement (no double-matching)</li>
                        <li><i class="fas fa-check-circle"></i> Medical screening filters (age, weight, chronic illness)</li>
                        <li><i class="fas fa-check-circle"></i> Real-time request broadcast to compatible donors</li>
                        <li><i class="fas fa-check-circle"></i> Full audit log of every match and response</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <%-- FEATURE: INVENTORY (dark) --%>
    <section class="section-feature alt">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6 order-lg-2">
                    <div class="feature-visual feature-visual-dark">
                        <img src="images/blood-bank.png" alt="Blood Bank Inventory" />
                    </div>
                </div>
                <div class="col-lg-6 order-lg-1">
                    <div class="feature-label">Inventory Management</div>
                    <h2 class="feature-title">Live Blood Bank, Always Accurate</h2>
                    <p class="feature-desc">Hospital staff never have to manually count blood units again. Every confirmed donation automatically increments inventory. Every fulfilled request decrements it. The result is a real-time blood bank that hospitals can trust.</p>
                    <ul class="feature-list">
                        <li><i class="fas fa-check-circle"></i> Auto-update on every confirmed donation</li>
                        <li><i class="fas fa-check-circle"></i> Separate unit tracking per blood group (all 8 types)</li>
                        <li><i class="fas fa-check-circle"></i> Hospital staff can manually add or adjust stock</li>
                        <li><i class="fas fa-check-circle"></i> Admin view of system-wide inventory across hospitals</li>
                        <li><i class="fas fa-check-circle"></i> Historical log for accountability and auditing</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <%-- BLOOD COMPATIBILITY TABLE --%>
    <section class="section-blood">
        <div class="container">
            <div class="text-center">
                <h2 class="font-display fw-800" style="font-size:2rem;color:var(--ink);">Blood Type Compatibility</h2>
                <p style="color:var(--muted);font-size:0.9rem;margin-top:0.5rem;">The matching rules our engine uses — the same standard used globally in blood banking.</p>
            </div>
            <div class="blood-compat-grid">
                <div class="bct-card">
                    <div class="bct-lbl">Blood Group</div>
                    <div class="bct-group">O−</div>
                    <div class="bct-lbl mt-2">Donates To</div>
                    <div class="bct-list">All Groups<br><strong style="color:var(--crimson);font-size:0.75rem;">Universal Donor</strong></div>
                </div>
                <div class="bct-card">
                    <div class="bct-lbl">Blood Group</div>
                    <div class="bct-group">O+</div>
                    <div class="bct-lbl mt-2">Donates To</div>
                    <div class="bct-list">O+, A+, B+, AB+</div>
                </div>
                <div class="bct-card">
                    <div class="bct-lbl">Blood Group</div>
                    <div class="bct-group">A+</div>
                    <div class="bct-lbl mt-2">Donates To</div>
                    <div class="bct-list">A+, AB+</div>
                </div>
                <div class="bct-card">
                    <div class="bct-lbl">Blood Group</div>
                    <div class="bct-group">A−</div>
                    <div class="bct-lbl mt-2">Donates To</div>
                    <div class="bct-list">A−, A+, AB−, AB+</div>
                </div>
                <div class="bct-card">
                    <div class="bct-lbl">Blood Group</div>
                    <div class="bct-group">B+</div>
                    <div class="bct-lbl mt-2">Donates To</div>
                    <div class="bct-list">B+, AB+</div>
                </div>
                <div class="bct-card">
                    <div class="bct-lbl">Blood Group</div>
                    <div class="bct-group">B−</div>
                    <div class="bct-lbl mt-2">Donates To</div>
                    <div class="bct-list">B−, B+, AB−, AB+</div>
                </div>
                <div class="bct-card">
                    <div class="bct-lbl">Blood Group</div>
                    <div class="bct-group">AB+</div>
                    <div class="bct-lbl mt-2">Receives From</div>
                    <div class="bct-list">All Groups<br><strong style="color:var(--crimson);font-size:0.75rem;">Universal Recipient</strong></div>
                </div>
                <div class="bct-card">
                    <div class="bct-lbl">Blood Group</div>
                    <div class="bct-group">AB−</div>
                    <div class="bct-lbl mt-2">Donates To</div>
                    <div class="bct-list">AB−, AB+</div>
                </div>
            </div>
        </div>
    </section>

    <%-- WHO WE SERVE --%>
    <section class="section-users">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="font-display fw-800" style="font-size:2rem;color:#fff;">Who Hero Pulse Serves</h2>
                <p style="color:rgba(255,255,255,0.45);max-width:480px;margin:0.75rem auto 0;font-size:0.95rem;line-height:1.7;">Four distinct user roles, each with their own dedicated dashboard and tools.</p>
            </div>
            <div class="row g-4">
                <div class="col-sm-6 col-lg-3">
                    <div class="user-card">
                        <div class="user-tag">Role 1</div>
                        <div class="user-num"><i class="fas fa-tint" style="font-size:1.8rem;"></i></div>
                        <h5>Donors</h5>
                        <p>Register, track eligibility, receive matching alerts, and log donations — all from a personal donor dashboard.</p>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="user-card">
                        <div class="user-tag">Role 2</div>
                        <div class="user-num"><i class="fas fa-hospital" style="font-size:1.8rem;"></i></div>
                        <h5>Hospitals</h5>
                        <p>Post blood requests, manage inventory, confirm donations, and view system-wide blood stock in real time.</p>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="user-card">
                        <div class="user-tag">Role 3</div>
                        <div class="user-num"><i class="fas fa-user-injured" style="font-size:1.8rem;"></i></div>
                        <h5>Receptors (Patients)</h5>
                        <p>Submit emergency blood requests, track fulfilment status, and receive updates as compatible donors respond.</p>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="user-card">
                        <div class="user-tag">Role 4</div>
                        <div class="user-num"><i class="fas fa-user-shield" style="font-size:1.8rem;"></i></div>
                        <h5>Administrators</h5>
                        <p>Oversee the full platform — managing all users, hospitals, requests, and generating reports from one admin panel.</p>
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
                    <h2>Ready to Use Hero Pulse?</h2>
                    <p>Join Pakistan's most trusted blood donation network. Register as a donor or hospital today and start saving lives.</p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="Register.aspx" class="btn-cta-white"><i class="fas fa-user-plus"></i> Register Now</a>
                        <a href="Contact.aspx" class="btn-cta-outline-white"><i class="fas fa-envelope"></i> Get in Touch</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
