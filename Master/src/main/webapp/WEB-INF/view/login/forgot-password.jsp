<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"> <strong>Forgot</strong> Password</h2>
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
            <h2 class="big-title">Reset Your Password</h2>
        </div>
        <div class="contact-form form-wrapper text-center">

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form action="<c:url value='/forgot-password' />" method="post">
                <div class="row justify-content-center">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <input type="email" name="email" placeholder="Enter your email address" required style="width: 100%;">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="custom-btn">Send Reset Link</button>
                        </div>
                        <div class="mt-3 text-center">
                            <p>Remembered your password? <a href="<c:url value='/login' />" style="color: #ff8a00;">Login here</a></p>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
