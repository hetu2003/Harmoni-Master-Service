<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"><strong>Forgot</strong> Password</h2>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="<c:url value='/login' />" class="breadcrumb-link">Login</a></li>
                                <li class="breadcrumb-item active"><a href="#" aria-current="page">Forgot Password</a></li>
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
            <small class="sub-title">Account Recovery</small>
            <h2 class="big-title">Reset Your Password</h2>
        </div>
        <div class="contact-form form-wrapper text-center">

            <div id="message" style="display:none;"></div>

            <div id="form-section">
                <p style="color:#666;margin-bottom:24px;max-width:460px;margin-left:auto;margin-right:auto;">
                    Enter the email address associated with your account and we'll send you a link to reset your password.
                </p>
                <form id="forgotPasswordForm">
                    <div class="row justify-content-center">
                        <div class="col-lg-8 col-md-10 col-sm-12">
                            <div class="form-item">
                                <input type="email" id="fpEmail" name="email"
                                       placeholder="Enter your email address" required style="width:100%;">
                            </div>
                            <div class="text-center">
                                <button type="submit" id="sendBtn" class="custom-btn">SEND RESET LINK</button>
                            </div>
                            <div class="mt-3 text-center">
                                <p>Remembered your password?
                                    <a href="<c:url value='/login' />" style="color:#ff8a00;">Login here</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Shown after successful send -->
            <div id="success-section" style="display:none;text-align:center;padding:30px 0;">
                <div style="font-size:56px;margin-bottom:16px;">&#128231;</div>
                <h4 style="color:#333;margin-bottom:10px;">Check Your Inbox</h4>
                <p style="color:#666;max-width:420px;margin:0 auto 24px;">
                    If that email is registered with us, a password reset link has been sent.
                    Check your spam folder if you don't see it within a few minutes.
                </p>
                <a href="<c:url value='/login' />" class="custom-btn">BACK TO LOGIN</a>
            </div>

        </div>
    </div>
</section>

<script src="<c:url value='/assets/custom/login/forgot-password.js' />"></script>
