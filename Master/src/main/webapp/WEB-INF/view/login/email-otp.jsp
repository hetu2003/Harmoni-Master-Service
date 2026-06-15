<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"><strong>Email OTP</strong> Login</h2>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item">
                                    <a href="<c:url value='/login' />" class="breadcrumb-link">Login</a>
                                </li>
                                <li class="breadcrumb-item active">
                                    <a href="<c:url value='/login/email' />" aria-current="page">Email OTP</a>
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
            <small class="sub-title">Passwordless Login</small>
            <h2 class="big-title">Login via Email OTP,</h2>
        </div>

        <div class="contact-form form-wrapper text-center">

            <div id="message" style="display:none;"></div>

            <!-- Step A: Enter email -->
            <div id="otp-step-email">
                <p style="color:#555; margin-bottom:28px; font-size:15px;">
                    Enter your registered email address and we'll send you a 6-digit one-time password.
                </p>
                <div class="row justify-content-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <input type="email" id="otpEmail" placeholder="Your registered email"
                                   required autocomplete="off" style="width:100%; background:#fff;">
                        </div>
                        <div class="text-center mt-3">
                            <button type="button" id="sendOtpBtn" class="custom-btn" onclick="sendOtp()">
                                SEND OTP
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Step B: Verify OTP (shown after OTP sent) -->
            <div id="otp-step-verify" style="display:none;">
                <p style="color:#555; margin-bottom:28px; font-size:15px;">
                    A 6-digit OTP has been sent to <strong id="otpEmailDisplay"></strong>.
                    It expires in <strong>5 minutes</strong>.
                </p>
                <div class="row justify-content-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <input type="text" id="otpCode" maxlength="6"
                                   placeholder="Enter 6-digit OTP" required autocomplete="off"
                                   style="width:100%; letter-spacing:10px; text-align:center;
                                          font-size:26px; background:#fff;">
                        </div>
                        <div class="text-center mt-3" style="display:flex; justify-content:center; gap:12px; flex-wrap:wrap;">
                            <button type="button" class="custom-btn" onclick="verifyOtp()">VERIFY &amp; LOGIN</button>
                            <button type="button" class="custom-btn" style="background:#888;" onclick="resendOtp()">RESEND OTP</button>
                        </div>
                        <div class="mt-3">
                            <a href="#" onclick="resetOtpFlow(); return false;" style="color:#ff8a00; font-size:13px;">
                                &larr; Use a different email
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-4 text-center">
                <p>
                    <a href="<c:url value='/login' />" style="color:#ff8a00;">
                        &larr; Back to Login
                    </a>
                </p>
            </div>

        </div><!-- /.form-wrapper -->
    </div>
</section>

<script src="<c:url value='/assets/custom/login/auth.js' />"></script>
