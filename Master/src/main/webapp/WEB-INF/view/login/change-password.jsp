<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"><strong>Change</strong> Password</h2>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="<c:url value='/dashboard' />" class="breadcrumb-link">Dashboard</a></li>
                                <li class="breadcrumb-item active"><a href="#" aria-current="page">Change Password</a></li>
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
            <small class="sub-title">Account Security</small>
            <h2 class="big-title">Update Your Password</h2>
        </div>
        <div class="contact-form form-wrapper text-center">

            <div id="message" style="display:none;"></div>

            <form id="changePasswordForm">
                <div class="row justify-content-center">
                    <div class="col-lg-8 col-md-10 col-sm-12">

                        <div class="form-item">
                            <label for="username" style="text-align:left;display:block;margin-bottom:6px;font-weight:600;">Username</label>
                            <input type="text" id="username" name="username" placeholder="Your username" required style="width:100%;">
                        </div>

                        <div class="form-item" style="position:relative;">
                            <label for="oldPassword" style="text-align:left;display:block;margin-bottom:6px;font-weight:600;">Current Password</label>
                            <input type="password" id="oldPassword" name="oldPassword" placeholder="Current password" required style="width:100%;">
                            <span class="toggle-pw" onclick="togglePw('oldPassword')" style="position:absolute;right:14px;top:38px;cursor:pointer;color:#888;">&#128065;</span>
                        </div>

                        <div class="form-item" style="position:relative;">
                            <label for="newPassword" style="text-align:left;display:block;margin-bottom:6px;font-weight:600;">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" placeholder="New password (min 8 chars)" minlength="8" required style="width:100%;">
                            <span class="toggle-pw" onclick="togglePw('newPassword')" style="position:absolute;right:14px;top:38px;cursor:pointer;color:#888;">&#128065;</span>
                        </div>

                        <div class="form-item" style="position:relative;">
                            <label for="confirmPassword" style="text-align:left;display:block;margin-bottom:6px;font-weight:600;">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required style="width:100%;">
                            <span class="toggle-pw" onclick="togglePw('confirmPassword')" style="position:absolute;right:14px;top:38px;cursor:pointer;color:#888;">&#128065;</span>
                        </div>

                        <!-- Password strength indicator -->
                        <div id="strengthBar" style="height:6px;border-radius:3px;background:#eee;margin:-10px 0 18px;transition:all .3s;">
                            <div id="strengthFill" style="height:100%;border-radius:3px;width:0%;transition:all .3s;"></div>
                        </div>
                        <div id="strengthLabel" style="text-align:left;font-size:12px;color:#888;margin-bottom:14px;"></div>

                        <div class="text-center">
                            <button type="submit" id="submitBtn" class="custom-btn">CHANGE PASSWORD</button>
                        </div>

                        <div class="mt-3 text-center">
                            <a href="<c:url value='/profile' />" style="color:#ff8a00;">&larr; Back to Profile</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>

<script src="<c:url value='/assets/custom/login/change-password.js' />"></script>
