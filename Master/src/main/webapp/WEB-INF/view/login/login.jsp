<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"> <strong>Login</strong> Page</h2>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item">
                                    <a href="<c:url value='/login' />" aria-current="page">Login</a>
                                </li>
                                <li class="breadcrumb-item active">
                                    <a href="<c:url value='/register' />" class="breadcrumb-link">Register</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="contact-section" class="contact-section sec-ptb-100 clearfix">
    <div class="container">

        <div class="section-title mb-50">
            <small class="sub-title">Account Login</small>
            <h2 class="big-title">Login To Our Website, </h2>
        </div>

        <!-- Login Method Tabs -->
        <div class="contact-form form-wrapper text-center">

            <div id="message" style="display:none;"></div>

            <!-- Tab Buttons -->
            <div class="d-flex justify-content-center mb-4" style="gap:8px;">
                <button type="button" id="tab-password" class="custom-btn login-tab-btn active-tab"
                        onclick="switchLoginTab('password')">
                    Username / Password
                </button>
                <button type="button" id="tab-otp" class="custom-btn login-tab-btn"
                        onclick="switchLoginTab('otp')" style="background:#555;">
                    Email OTP
                </button>
            </div>

            <!-- ── TAB 1: Username / Password ── -->
            <div id="panel-password">
                <form id="loginForm" action="<c:url value='/login' />" method="post">
                    <div class="row justify-content-center">
                        <div class="col-lg-12 col-md-12 col-sm-12">

                            <div class="form-item">
                                <input type="text" name="username" placeholder="Username or Email" required style="width:100%;">
                            </div>

                            <div class="form-item">
                                <input type="password" name="password" placeholder="Password" required style="width:100%;">
                            </div>

                            <div class="text-left mb-30">
                                <a href="<c:url value='/forgot-password' />" style="color:#ff8a00;">Forgot Password?</a>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="custom-btn">LOGIN</button>
                            </div>

                            <div class="mt-3 text-center">
                                <p>New user? <a href="<c:url value='/register' />" style="color:#ff8a00;">Register here</a></p>
                            </div>

                            <div class="my-4"><span style="color:#999;font-weight:bold;">OR</span></div>

                            <!-- Google Sign-In -->
                            <div id="g_id_onload"
                                 data-client_id="190662284666-8jsc7a0ag2kakd389ni97gahv6lcovmq.apps.googleusercontent.com"
                                 data-context="signin"
                                 data-ux_mode="popup"
                                 data-callback="handleGoogleSignIn"
                                 data-auto_prompt="false">
                            </div>
                            <div class="d-flex justify-content-center">
                                <div class="g_id_signin"
                                     data-type="standard"
                                     data-shape="pill"
                                     data-theme="filled_blue"
                                     data-text="continue_with"
                                     data-size="large"
                                     data-width="280"
                                     data-logo_alignment="left">
                                </div>
                            </div>

                        </div>
                    </div>
                </form>
            </div>

            <!-- ── TAB 2: Email OTP ── -->
            <div id="panel-otp" style="display:none;">
                <div class="row justify-content-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">

                        <!-- Step A: Enter email -->
                        <div id="otp-step-email">
                            <p style="color:#555;margin-bottom:20px;">
                                Enter your registered email address and we'll send a 6-digit one-time password.
                            </p>
                            <div class="form-item">
                                <input type="email" id="otpEmail" placeholder="Your registered email" required style="width:100%;">
                            </div>
                            <div class="text-center mt-3">
                                <button type="button" id="sendOtpBtn" class="custom-btn" onclick="sendOtp()">
                                    SEND OTP
                                </button>
                            </div>
                        </div>

                        <!-- Step B: Enter OTP (hidden until OTP sent) -->
                        <div id="otp-step-verify" style="display:none;">
                            <p style="color:#555;margin-bottom:20px;">
                                A 6-digit OTP has been sent to <strong id="otpEmailDisplay"></strong>.
                                It expires in <strong>5 minutes</strong>.
                            </p>
                            <div class="form-item">
                                <input type="text" id="otpCode" maxlength="6"
                                       placeholder="Enter 6-digit OTP" required
                                       style="width:100%;letter-spacing:8px;text-align:center;font-size:22px;">
                            </div>
                            <div class="text-center mt-3" style="display:flex;justify-content:center;gap:12px;">
                                <button type="button" class="custom-btn" onclick="verifyOtp()">VERIFY &amp; LOGIN</button>
                                <button type="button" class="custom-btn" style="background:#555;" onclick="resendOtp()">RESEND OTP</button>
                            </div>
                            <div class="mt-3">
                                <a href="#" onclick="resetOtpFlow(); return false;" style="color:#ff8a00;font-size:13px;">
                                    &larr; Use a different email
                                </a>
                            </div>
                        </div>

                        <div class="mt-3 text-center">
                            <p>New user? <a href="<c:url value='/register' />" style="color:#ff8a00;">Register here</a></p>
                        </div>

                    </div>
                </div>
            </div>

        </div><!-- /.form-wrapper -->
    </div>
</section>

<!-- Google Platform Library -->
<script src="https://accounts.google.com/gsi/client" async defer></script>

<!-- Custom auth.js -->
<script src="<c:url value='/assets/custom/login/auth.js' />"></script>

<script>
function handleGoogleSignIn(response) {
    const idToken = response.credential;
    const messageDiv = document.getElementById("message");
    messageDiv.innerHTML = '<div class="alert alert-info">Verifying Google Sign-In...</div>';
    messageDiv.style.display = 'block';

    fetch('<c:url value="/login/google" />', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ idToken: idToken })
    })
    .then(r => r.json())
    .then(result => {
        if (result.success) {
            window.location.href = result.redirectUrl;
        } else {
            messageDiv.innerHTML = '<div class="alert alert-danger">' + result.message + '</div>';
        }
    })
    .catch(() => {
        messageDiv.innerHTML = '<div class="alert alert-danger">An unexpected error occurred during Google Sign-In.</div>';
    });
}
</script>
