<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="text-center py-5">
            <div class="mb-4">
                <i class="fas fa-check-circle text-success" style="font-size: 5rem;"></i>
            </div>
            <h2 class="fw-bold text-success mb-2">Registration Successful!</h2>
            <p class="text-muted mb-1">
                Your registration has been submitted successfully.
            </p>
            <p class="text-muted mb-4">
                The company will review your request and approve it shortly.<br>
                A confirmation email has been sent to your registered email address.
            </p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="${pageContext.request.contextPath}/event"
                   class="btn btn-primary px-4">
                    <i class="fas fa-list me-2"></i>Browse More Events
                </a>
                <a href="${pageContext.request.contextPath}/home"
                   class="btn btn-outline-secondary px-4">
                    <i class="fas fa-home me-2"></i>Go Home
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
