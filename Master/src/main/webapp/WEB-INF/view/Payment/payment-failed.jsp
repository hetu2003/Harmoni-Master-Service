<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Payment Failed</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container text-center mt-5">
    <i class="fas fa-times-circle text-danger" style="font-size:4rem;"></i>
    <h3 class="mt-3">Payment Verification Failed</h3>
    <c:if test="${not empty errorMessage}">
        <p class="text-danger">${errorMessage}</p>
    </c:if>
    <p class="text-muted">Please contact support if money was deducted.</p>
    <a href="${pageContext.request.contextPath}/vendor/my-events" class="btn btn-primary mt-2">
        Back to My Events
    </a>
</div>
</body>
</html>