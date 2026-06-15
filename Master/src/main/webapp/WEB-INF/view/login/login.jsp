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
            <h2 class="big-title">Login To Our Website,</h2>
        </div>

        <div class="contact-form form-wrapper text-center">

            <div id="message" style="display:none;"></div>

            <c:if test="${sessionExpired}">
                <div class="alert alert-warning" style="border-left:4px solid #ff8a00; margin-bottom:20px;">
                    <i class="fas fa-clock mr-2"></i>Your session has expired. Please log in again.
                </div>
            </c:if>

            <!-- Username / Password Form -->
            <form id="loginForm" action="<c:url value='/login' />" method="post">
                <div class="row justify-content-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">

                        <div class="form-item">
                            <input type="text" name="username" placeholder="Username or Email"
                                   required autocomplete="off"
                                   style="width:100%; background:#fff;">
                        </div>

                        <div class="form-item">
                            <input type="password" name="password" placeholder="Password"
                                   required autocomplete="new-password"
                                   style="width:100%; background:#fff;">
                        </div>

                        <div class="text-left mb-30">
                            <a href="<c:url value='/forgot-password' />" style="color:#ff8a00;">Forgot Password?</a>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="custom-btn">LOGIN</button>
                        </div>
                    </div>
                </div>
            </form>

            <!-- OR divider -->
            <div class="or-divider">
                <span>OR</span>
            </div>

            <!-- Google Sign-In (orange themed) -->
            <div id="g_id_onload"
                 data-client_id="190662284666-8jsc7a0ag2kakd389ni97gahv6lcovmq.apps.googleusercontent.com"
                 data-context="signin"
                 data-ux_mode="popup"
                 data-callback="handleGoogleSignIn"
                 data-auto_prompt="false">
            </div>

            <div class="d-flex justify-content-center">
                <div style="position:relative; display:inline-block; cursor:pointer;">
                    <button type="button"
                            style="background:#ff8a00; color:#fff; border:none; border-radius:25px;
                                   padding:13px 36px; font-size:15px; font-weight:600;
                                   display:inline-flex; align-items:center; gap:10px;
                                   width:280px; justify-content:center; pointer-events:none;">
                        <i class="fab fa-google" style="font-size:17px;"></i> Continue with Google
                    </button>
                    <div class="g_id_signin"
                         data-type="standard"
                         data-shape="pill"
                         data-theme="filled_blue"
                         data-text="continue_with"
                         data-size="large"
                         data-width="280"
                         data-logo_alignment="left"
                         style="position:absolute; top:0; left:0; width:280px; height:100%; opacity:0.001; overflow:hidden;">
                    </div>
                </div>
            </div>

            <!-- OR divider -->
            <div class="or-divider">
                <span>OR</span>
            </div>

            <!-- Email OTP — inline section -->
            <div id="otpSection" style="max-width:400px;margin:0 auto 16px;">

                <!-- Step 1: email input -->
                <div id="otpStep1">
                    <div class="form-item" style="margin-bottom:10px;">
                        <input type="email" id="otpEmail" placeholder="Enter your email for OTP"
                               autocomplete="off" style="width:100%; background:#fff;">
                    </div>
                    <div class="text-center">
                        <button type="button" id="sendOtpBtn"
                                onclick="sendOtp()"
                                style="background:#ff8a00; color:#fff; border:none; border-radius:25px;
                                       padding:13px 36px; font-size:15px; font-weight:600;
                                       display:inline-flex; align-items:center; gap:10px;
                                       width:280px; justify-content:center; cursor:pointer;">
                            <i class="fas fa-envelope" style="font-size:17px;"></i> Login with Email OTP
                        </button>
                    </div>
                </div>

                <!-- Step 2: OTP input (hidden until OTP is sent) -->
                <div id="otpStep2" style="display:none;">
                    <p style="color:#555; font-size:13px; margin-bottom:10px;">
                        OTP sent to <strong id="otpEmailDisplay"></strong>.
                        <a href="#" onclick="resetOtp(); return false;" style="color:#ff8a00;">Change</a>
                    </p>
                    <div class="form-item" style="margin-bottom:10px;">
                        <input type="text" id="otpCode" placeholder="Enter 6-digit OTP"
                               maxlength="6" autocomplete="off"
                               style="width:100%; background:#fff; letter-spacing:4px; text-align:center; font-size:20px;">
                    </div>
                    <div class="text-center">
                        <button type="button" id="verifyOtpBtn"
                                onclick="verifyOtp()"
                                style="background:#ff8a00; color:#fff; border:none; border-radius:25px;
                                       padding:13px 36px; font-size:15px; font-weight:600;
                                       display:inline-flex; align-items:center; gap:10px;
                                       width:280px; justify-content:center; cursor:pointer;">
                            <i class="fas fa-check-circle" style="font-size:17px;"></i> Verify OTP
                        </button>
                    </div>
                    <div class="text-center mt-2">
                        <a href="#" onclick="sendOtp(); return false;" style="color:#888; font-size:13px;">Resend OTP</a>
                    </div>
                </div>

                <div id="otpMessage" style="margin-top:10px;"></div>
            </div>

            <div class="mt-4 text-center">
                <p>New user? <a href="<c:url value='/register' />" style="color:#ff8a00;">Register here</a></p>
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
    var idToken = response.credential;
    var messageDiv = document.getElementById("message");
    messageDiv.innerHTML = '<div class="alert alert-info">Verifying Google Sign-In...</div>';
    messageDiv.style.display = 'block';

    fetch('<c:url value="/login/google" />', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ idToken: idToken })
    })
    .then(function(r) { return r.json(); })
    .then(function(result) {
        if (result.success) {
            window.location.href = result.redirectUrl;
        } else {
            messageDiv.innerHTML = '<div class="alert alert-danger">' + result.message + '</div>';
        }
    })
    .catch(function() {
        messageDiv.innerHTML = '<div class="alert alert-danger">An unexpected error occurred during Google Sign-In.</div>';
    });
}
</script>

<style>
.or-divider {
    display: flex;
    align-items: center;
    text-align: center;
    margin: 24px 0;
    color: #bbb;
}
.or-divider::before,
.or-divider::after {
    content: '';
    flex: 1;
    border-bottom: 1px solid #e0e0e0;
}
.or-divider span {
    padding: 0 16px;
    font-weight: 700;
    font-size: 13px;
    color: #999;
    letter-spacing: 1px;
}

/* Prevent browser autofill yellow background */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0px 1000px #fff inset !important;
    -webkit-text-fill-color: #333 !important;
    transition: background-color 5000s ease-in-out 0s;
}
</style>

<script>
var _otpCtx = '${pageContext.request.contextPath}';

function sendOtp() {
    var email = document.getElementById('otpEmail').value.trim();
    var msgDiv = document.getElementById('otpMessage');
    if (!email) { showOtpMsg('danger', 'Please enter your email address.'); return; }

    var btn = document.getElementById('sendOtpBtn');
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending…';

    fetch(_otpCtx + '/login/email/send-otp', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email: email })
    })
    .then(function(r) { return r.json(); })
    .then(function(data) {
        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-envelope" style="font-size:17px;"></i> Login with Email OTP';
        if (data.success !== false) {
            document.getElementById('otpEmailDisplay').textContent = email;
            document.getElementById('otpStep1').style.display = 'none';
            document.getElementById('otpStep2').style.display = 'block';
            showOtpMsg('success', 'OTP sent! Check your inbox.');
        } else {
            showOtpMsg('danger', data.message || 'Failed to send OTP. Please try again.');
        }
    })
    .catch(function() {
        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-envelope" style="font-size:17px;"></i> Login with Email OTP';
        showOtpMsg('danger', 'Network error. Please try again.');
    });
}

function verifyOtp() {
    var email = document.getElementById('otpEmail').value.trim();
    var otp   = document.getElementById('otpCode').value.trim();
    if (!otp || otp.length < 4) { showOtpMsg('danger', 'Please enter the OTP.'); return; }

    var btn = document.getElementById('verifyOtpBtn');
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Verifying…';

    fetch(_otpCtx + '/login/email/verify-otp', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email: email, otp: otp })
    })
    .then(function(r) { return r.json(); })
    .then(function(data) {
        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-check-circle" style="font-size:17px;"></i> Verify OTP';
        if (data.success) {
            showOtpMsg('success', 'Login successful! Redirecting…');
            setTimeout(function() {
                window.location.href = data.redirectUrl || (_otpCtx + '/home');
            }, 1000);
        } else {
            showOtpMsg('danger', data.message || 'Invalid or expired OTP. Please try again.');
        }
    })
    .catch(function() {
        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-check-circle" style="font-size:17px;"></i> Verify OTP';
        showOtpMsg('danger', 'Network error. Please try again.');
    });
}

function resetOtp() {
    document.getElementById('otpStep1').style.display = 'block';
    document.getElementById('otpStep2').style.display = 'none';
    document.getElementById('otpCode').value = '';
    document.getElementById('otpMessage').innerHTML = '';
}

function showOtpMsg(type, text) {
    document.getElementById('otpMessage').innerHTML =
        '<div class="alert alert-' + type + '" style="font-size:13px;padding:8px 14px;">' + text + '</div>';
}
</script>
