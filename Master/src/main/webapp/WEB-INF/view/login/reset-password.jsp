<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"> <strong>Reset</strong> Password</h2>
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
            <h2 class="big-title">Enter Your New Password</h2>
        </div>
        <div class="contact-form form-wrapper text-center">

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="<c:url value='/reset-password' />" method="post">
                <input type="hidden" name="token" value="${token}" />
                <div class="row justify-content-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <input type="password" name="newPassword" placeholder="Enter new password" required style="width: 100%;">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="custom-btn">Reset Password</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
