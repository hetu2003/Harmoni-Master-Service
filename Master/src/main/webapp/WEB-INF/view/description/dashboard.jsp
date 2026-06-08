<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="dashboard-section" class="contact-section sec-ptb-100 clearfix">
    <div class="container">
        <div class="section-title mb-50">
            <h2 class="big-title">Welcome to Your Dashboard</h2>
        </div>
        <div class="text-center">
            <h3>Login Successful!</h3>
            <p>Your session is active.</p>
            <p>Your email from the session is: <strong>${email}</strong></p>
            <br>
            <a href="<c:url value='/logout' />" class="custom-btn">Logout</a>
        </div>
    </div>
</section>
