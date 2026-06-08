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
        <div class="contact-form form-wrapper text-center">

            <div id="message" style="display: none;"></div>

            <form id="loginForm" action="<c:url value='/login' />" method="post">
                <div class="row justify-content-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">

                        <div class="form-item">
                            <input type="text" name="username" placeholder="Username or Email" required style="width: 100%;">
                        </div>

                        <div class="form-item">
                            <input type="password" name="password" placeholder="Password" required style="width: 100%;">
                        </div>

                        <div class="text-left mb-30">
                            <a href="#!" class="forgot-password" style="color: #ff8a00;">Forgot Password ?</a>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="custom-btn">LOGIN</button>
                        </div>

                        <div class="mt-3 text-center">
                            <p>New user? <a href="<c:url value='/register' />" style="color: #ff8a00;">Register here</a></p>
                        </div>

                        <div class="my-4">
                            <span style="color: #999; font-weight: bold;">OR</span>
                        </div>

                        <!-- Google Sign-In Button (Restyled) -->
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

    </div>
</section>

<!-- Google Platform Library -->
<script src="https://accounts.google.com/gsi/client" async defer></script>

<!-- Your custom auth.js -->
<script src="<c:url value='/assets/custom/login/auth.js' />"></script>

<script>
// This function will be called by the Google library after a successful sign-in
function handleGoogleSignIn(response) {
    const idToken = response.credential;
    const messageDiv = document.getElementById("message");

    messageDiv.innerHTML = '<div class="alert alert-info">Verifying Google Sign-In...</div>';
    messageDiv.style.display = 'block';

    fetch('<c:url value="/login/google" />', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ idToken: idToken })
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            window.location.href = result.redirectUrl;
        } else {
            messageDiv.innerHTML = `<div class="alert alert-danger">${result.message}</div>`;
        }
    })
    .catch(error => {
        console.error('Error:', error);
        messageDiv.innerHTML = '<div class="alert alert-danger">An unexpected error occurred during Google Sign-In.</div>';
    });
}
</script>