<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="hero_pulse.Contact" %>

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
            radial-gradient(circle at 80% 40%, rgba(192,24,42,0.15) 0%, transparent 50%),
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

    /* ── MAIN CONTACT SECTION ── */
    .section-contact { padding: 6rem 0; background: var(--ivory); }

    /* ── CONTACT FORM ── */
    .contact-form-wrap {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 20px;
        padding: 2.5rem;
    }
    .contact-form-wrap h3 {
        font-family: 'Syne', sans-serif;
        font-weight: 800;
        font-size: 1.4rem;
        color: var(--ink);
        margin-bottom: 0.5rem;
    }
    .contact-form-wrap .form-sub {
        font-size: 0.875rem;
        color: var(--muted);
        margin-bottom: 2rem;
    }
    .hp-form-group { margin-bottom: 1.25rem; }
    .hp-form-group label {
        display: block;
        font-size: 0.82rem;
        font-weight: 600;
        color: var(--ink);
        margin-bottom: 0.4rem;
        letter-spacing: 0.02em;
    }
    .hp-form-group label span { color: var(--crimson); }
    .hp-input,
    .hp-textarea,
    .hp-select {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 1.5px solid var(--border);
        border-radius: 10px;
        font-size: 0.9rem;
        color: var(--ink);
        background: var(--ivory);
        font-family: 'DM Sans', sans-serif;
        transition: border-color 0.2s, box-shadow 0.2s;
        outline: none;
    }
    .hp-input:focus, .hp-textarea:focus, .hp-select:focus {
        border-color: var(--crimson);
        box-shadow: 0 0 0 3px rgba(192,24,42,0.08);
        background: #fff;
    }
    .hp-textarea { min-height: 130px; resize: vertical; }
    .hp-select { appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%236E6C79' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 1rem center; padding-right: 2.5rem; }
    .btn-hp-submit {
        width: 100%;
        background: var(--crimson);
        color: #fff;
        border: none;
        padding: 0.9rem 2rem;
        border-radius: 10px;
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 0.95rem;
        cursor: pointer;
        transition: all 0.25s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.6rem;
        margin-top: 0.5rem;
        letter-spacing: 0.01em;
    }
    .btn-hp-submit:hover { background: var(--crimson-light); transform: translateY(-2px); box-shadow: 0 10px 25px rgba(192,24,42,0.35); }

    /* ── ALERT MESSAGES ── */
    .msg-success, .msg-error {
        border-radius: 10px;
        padding: 1rem 1.25rem;
        font-size: 0.875rem;
        margin-bottom: 1.25rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    .msg-success { background: rgba(13,123,95,0.1); color: var(--emerald); border: 1px solid rgba(13,123,95,0.2); }
    .msg-error { background: rgba(192,24,42,0.08); color: var(--crimson); border: 1px solid rgba(192,24,42,0.2); }

    /* ── CONTACT INFO CARDS ── */
    .info-card {
        background: var(--ink);
        border-radius: 16px;
        padding: 1.75rem;
        margin-bottom: 1rem;
        display: flex;
        gap: 1.25rem;
        align-items: flex-start;
        transition: transform 0.2s;
    }
    .info-card:hover { transform: translateX(5px); }
    .info-icon {
        width: 44px;
        height: 44px;
        background: var(--crimson);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: 1rem;
        flex-shrink: 0;
    }
    .info-card h6 {
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 0.85rem;
        color: rgba(255,255,255,0.45);
        margin-bottom: 0.25rem;
        text-transform: uppercase;
        letter-spacing: 0.06em;
    }
    .info-card p { font-size: 0.92rem; color: #fff; margin: 0; line-height: 1.5; }
    .info-card a { color: rgba(255,255,255,0.8); text-decoration: none; }
    .info-card a:hover { color: var(--crimson); }

    /* ── HOURS ── */
    .hours-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 16px;
        padding: 1.75rem;
    }
    .hours-card h5 {
        font-family: 'Syne', sans-serif;
        font-weight: 700;
        font-size: 1rem;
        color: var(--ink);
        margin-bottom: 1.25rem;
        display: flex;
        align-items: center;
        gap: 0.6rem;
    }
    .hours-card h5 i { color: var(--crimson); }
    .hours-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.6rem 0;
        border-bottom: 1px solid var(--border);
        font-size: 0.875rem;
    }
    .hours-row:last-child { border-bottom: none; }
    .hours-row .day { color: var(--muted); }
    .hours-row .time { font-weight: 600; color: var(--ink); }
    .hours-row .badge-open {
        background: rgba(13,123,95,0.1);
        color: var(--emerald);
        border-radius: 20px;
        padding: 0.15rem 0.6rem;
        font-size: 0.68rem;
        font-weight: 700;
        letter-spacing: 0.04em;
    }

    /* ── FAQ ── */
    .section-faq { padding: 5rem 0; background: var(--surface); }
    .faq-item {
        border: 1px solid var(--border);
        border-radius: 12px;
        margin-bottom: 0.75rem;
        overflow: hidden;
        transition: box-shadow 0.2s;
    }
    .faq-item:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.06); }
    .faq-question {
        padding: 1.25rem 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        cursor: pointer;
        background: none;
        border: none;
        width: 100%;
        text-align: left;
        font-family: 'Syne', sans-serif;
        font-size: 0.95rem;
        font-weight: 700;
        color: var(--ink);
        gap: 1rem;
    }
    .faq-question i { color: var(--crimson); flex-shrink: 0; transition: transform 0.3s; }
    .faq-question[aria-expanded="true"] i { transform: rotate(45deg); }
    .faq-answer {
        padding: 0 1.5rem 1.25rem;
        font-size: 0.875rem;
        color: var(--muted);
        line-height: 1.75;
    }

    /* ── CTA ── */
    .cta-banner {
        background: var(--crimson);
        padding: 4.5rem 0;
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
    .cta-banner h2 { font-family: 'Syne', sans-serif; font-size: 2.2rem; font-weight: 800; color: #fff; margin-bottom: 1rem; }
    .cta-banner p { color: rgba(255,255,255,0.7); font-size: 1rem; margin-bottom: 2rem; }
    .btn-cta-white {
        background: #fff; color: var(--crimson); text-decoration: none;
        padding: 0.9rem 2.5rem; border-radius: 10px;
        font-family: 'Syne', sans-serif; font-weight: 700; font-size: 0.95rem;
        transition: all 0.25s; display: inline-flex; align-items: center; gap: 0.6rem;
    }
    .btn-cta-white:hover { background: var(--ivory); color: var(--crimson); transform: translateY(-2px); }
</style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- PAGE HERO --%>
    <section class="page-hero">
        <div class="container page-hero-content">
            <div class="page-eyebrow">Get in Touch</div>
            <h1>We're Here to <em>Help</em></h1>
            <p>Have a question, issue, or want to partner with Hero Pulse? Reach out — our team responds promptly to every message.</p>
        </div>
    </section>

    <%-- MAIN CONTACT SECTION --%>
    <section class="section-contact">
        <div class="container">
            <div class="row g-5">

                <%-- CONTACT FORM --%>
                <div class="col-lg-7">
                    <div class="contact-form-wrap">
                        <h3>Send Us a Message</h3>
                        <p class="form-sub">Fill in the form below and we'll get back to you within 24 hours.</p>

                        <%-- Success/Error Messages --%>
                        <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                            <div class="msg-success">
                                <i class="fas fa-check-circle"></i>
                                <asp:Label ID="lblSuccess" runat="server" Text="Your message has been sent successfully. We'll be in touch soon!"></asp:Label>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="pnlError" runat="server" Visible="false">
                            <div class="msg-error">
                                <i class="fas fa-exclamation-circle"></i>
                                <asp:Label ID="lblError" runat="server" Text="Something went wrong. Please try again."></asp:Label>
                            </div>
                        </asp:Panel>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="hp-form-group">
                                    <label>Full Name <span>*</span></label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="hp-input" placeholder="e.g. Ali Hassan" MaxLength="100" />
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server"
                                        ControlToValidate="txtName"
                                        ErrorMessage="Name is required."
                                        CssClass="text-danger"
                                        Display="Dynamic"
                                        style="font-size:0.78rem;margin-top:0.25rem;display:block;" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="hp-form-group">
                                    <label>Email Address <span>*</span></label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="hp-input" placeholder="you@example.com" TextMode="Email" MaxLength="150" />
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                        ControlToValidate="txtEmail"
                                        ErrorMessage="Email is required."
                                        CssClass="text-danger"
                                        Display="Dynamic"
                                        style="font-size:0.78rem;margin-top:0.25rem;display:block;" />
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                        ControlToValidate="txtEmail"
                                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                        ErrorMessage="Enter a valid email."
                                        CssClass="text-danger"
                                        Display="Dynamic"
                                        style="font-size:0.78rem;margin-top:0.25rem;display:block;" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="hp-form-group">
                                    <label>Phone (Optional)</label>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="hp-input" placeholder="+92 300 0000000" MaxLength="20" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="hp-form-group">
                                    <label>I am a <span>*</span></label>
                                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="hp-select">
                                        <asp:ListItem Value="" Text="— Select —" />
                                        <asp:ListItem Value="Donor" Text="Blood Donor" />
                                        <asp:ListItem Value="Hospital" Text="Hospital / Clinic" />
                                        <asp:ListItem Value="Patient" Text="Patient / Receptor" />
                                        <asp:ListItem Value="Other" Text="Other" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="hp-form-group">
                            <label>Subject <span>*</span></label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="hp-input" placeholder="e.g. Question about blood request" MaxLength="200" />
                            <asp:RequiredFieldValidator ID="rfvSubject" runat="server"
                                ControlToValidate="txtSubject"
                                ErrorMessage="Subject is required."
                                CssClass="text-danger"
                                Display="Dynamic"
                                style="font-size:0.78rem;margin-top:0.25rem;display:block;" />
                        </div>

                        <div class="hp-form-group">
                            <label>Message <span>*</span></label>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="hp-textarea" TextMode="MultiLine" placeholder="Tell us how we can help..." MaxLength="2000" />
                            <asp:RequiredFieldValidator ID="rfvMessage" runat="server"
                                ControlToValidate="txtMessage"
                                ErrorMessage="Message is required."
                                CssClass="text-danger"
                                Display="Dynamic"
                                style="font-size:0.78rem;margin-top:0.25rem;display:block;" />
                        </div>

                        <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn-hp-submit" OnClick="btnSubmit_Click" />
                    </div>
                </div>

                <%-- CONTACT INFO --%>
                <div class="col-lg-5">
                    <div class="info-card">
                        <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
                        <div>
                            <h6>Our Location</h6>
                            <p>Lahore, Punjab, Pakistan<br>Available Nationwide</p>
                        </div>
                    </div>
                    <div class="info-card">
                        <div class="info-icon"><i class="fas fa-envelope"></i></div>
                        <div>
                            <h6>Email Us</h6>
                            <p><a href="mailto:support@heropulse.pk">support@heropulse.pk</a><br><a href="mailto:hospitals@heropulse.pk">hospitals@heropulse.pk</a></p>
                        </div>
                    </div>
                    <div class="info-card">
                        <div class="info-icon"><i class="fas fa-phone"></i></div>
                        <div>
                            <h6>Call / WhatsApp</h6>
                            <p><a href="tel:+923001234567">+92 300 123 4567</a><br><span style="font-size:0.8rem;color:rgba(255,255,255,0.4);">Emergency line — 24/7</span></p>
                        </div>
                    </div>

                    <div class="hours-card mt-4">
                        <h5><i class="fas fa-clock"></i> Response Hours</h5>
                        <div class="hours-row">
                            <span class="day">Monday – Friday</span>
                            <span class="time">9 AM – 6 PM <span class="badge-open">Open</span></span>
                        </div>
                        <div class="hours-row">
                            <span class="day">Saturday</span>
                            <span class="time">10 AM – 3 PM <span class="badge-open">Open</span></span>
                        </div>
                        <div class="hours-row">
                            <span class="day">Sunday</span>
                            <span class="time" style="color:var(--muted);">Closed</span>
                        </div>
                        <div class="hours-row">
                            <span class="day">Emergency Requests</span>
                            <span class="time">24 / 7 <span class="badge-open">Always</span></span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <%-- FAQ --%>
    <section class="section-faq">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="font-display fw-800" style="font-size:2rem;color:var(--ink);">Frequently Asked Questions</h2>
                <p style="color:var(--muted);max-width:480px;margin:0.75rem auto 0;font-size:0.9rem;line-height:1.7;">Quick answers to the questions we receive most often.</p>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="faq-item">
                        <button class="faq-question" type="button" data-bs-toggle="collapse" data-bs-target="#faq1" aria-expanded="false">
                            How do I register as a blood donor?
                            <i class="fas fa-plus"></i>
                        </button>
                        <div id="faq1" class="collapse">
                            <div class="faq-answer">Click "Register" on the homepage and select "Donor" as your role. Fill in your personal and medical information including blood type, age, and weight. Once registered, you'll be eligible to receive blood requests that match your blood type.</div>
                        </div>
                    </div>
                    <div class="faq-item">
                        <button class="faq-question" type="button" data-bs-toggle="collapse" data-bs-target="#faq2" aria-expanded="false">
                            How often can I donate blood?
                            <i class="fas fa-plus"></i>
                        </button>
                        <div id="faq2" class="collapse">
                            <div class="faq-answer">Hero Pulse enforces a mandatory 90-day cooldown period between donations. This is a medically-recommended minimum interval to protect donor health. Your dashboard will display your next eligible donation date after each donation.</div>
                        </div>
                    </div>
                    <div class="faq-item">
                        <button class="faq-question" type="button" data-bs-toggle="collapse" data-bs-target="#faq3" aria-expanded="false">
                            How does a hospital post a blood request?
                            <i class="fas fa-plus"></i>
                        </button>
                        <div id="faq3" class="collapse">
                            <div class="faq-answer">Hospitals register with a verified hospital account. Once approved by the admin, hospital staff can log in to their dashboard and submit urgent blood requests specifying the required blood group and number of units. The system then auto-matches and notifies compatible donors instantly.</div>
                        </div>
                    </div>
                    <div class="faq-item">
                        <button class="faq-question" type="button" data-bs-toggle="collapse" data-bs-target="#faq4" aria-expanded="false">
                            Is Hero Pulse free to use?
                            <i class="fas fa-plus"></i>
                        </button>
                        <div id="faq4" class="collapse">
                            <div class="faq-answer">Yes, Hero Pulse is completely free for individual donors and patients. We believe the financial barrier should never stand between a donor and a patient in need. Hospital partnerships may involve a registration process — contact us for details.</div>
                        </div>
                    </div>
                    <div class="faq-item">
                        <button class="faq-question" type="button" data-bs-toggle="collapse" data-bs-target="#faq5" aria-expanded="false">
                            Who is eligible to donate blood on Hero Pulse?
                            <i class="fas fa-plus"></i>
                        </button>
                        <div id="faq5" class="collapse">
                            <div class="faq-answer">To donate through Hero Pulse you must be between 18–65 years old, weigh at least 50kg, and have no major chronic illnesses such as HIV, active cancer, or other disqualifying conditions. Our registration form screens for eligibility before activating your donor account.</div>
                        </div>
                    </div>
                    <div class="faq-item">
                        <button class="faq-question" type="button" data-bs-toggle="collapse" data-bs-target="#faq6" aria-expanded="false">
                            How is my data kept private?
                            <i class="fas fa-plus"></i>
                        </button>
                        <div id="faq6" class="collapse">
                            <div class="faq-answer">Your personal and medical information is stored securely. Donor contact information is only shared with a hospital after a donor explicitly accepts a blood request. We do not sell or share your data with third parties.</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%-- CTA --%>
    <section class="cta-banner">
        <div class="container position-relative">
            <div class="row align-items-center">
                <div class="col-lg-7">
                    <h2>Still Have Questions?</h2>
                    <p>Our team is happy to walk you through anything — from registration to emergency requests. Just send us a message above or call our helpline.</p>
                    <a href="Register.aspx" class="btn-cta-white"><i class="fas fa-tint"></i> Become a Donor</a>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
