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
            <%-- Message handling for errors --%>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="<c:url value='/login' />" method="post">
                <%-- Spring Security CSRF --%>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="row justify-content-center">
                    <%-- Changed from col-lg-6 to col-lg-12 to make it full width --%>
                    <div class="col-lg-12 col-md-12 col-sm-12">

                        <div class="form-item">
                            <input type="text" name="username" placeholder="Username" required style="width: 100%;">
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
                    </div>
                </div>
            </form>
        </div>

    </div>
</section>