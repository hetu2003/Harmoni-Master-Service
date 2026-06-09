<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Companies - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .company-card { transition: transform .18s, box-shadow .18s; }
        .company-card:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,0,0,.1); }
        .avatar-circle {
            width: 60px; height: 60px; border-radius: 50%;
            background: #e9ecef; display: flex; align-items: center;
            justify-content: center; font-size: 1.5rem; color: #6c757d;
            flex-shrink: 0;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="fas fa-calendar-star me-2"></i>Harmoni
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event">Events</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/company">Companies</a></li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${pageContext.request.userPrincipal != null}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/history">History</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Header -->
<section class="py-4 bg-dark text-white">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h3 class="mb-0">Event <strong>Companies</strong></h3>
            <small class="text-white-50">${totalCount} companies registered</small>
        </div>
    </div>
</section>

<!-- Search -->
<div class="bg-light border-bottom py-3">
    <div class="container">
        <form action="${pageContext.request.contextPath}/company" method="GET" class="d-flex gap-2">
            <input type="text" class="form-control" name="search"
                   value="${search}" placeholder="Search company by name...">
            <button class="btn btn-dark px-4" type="submit">
                <i class="fas fa-search me-1"></i>Search
            </button>
            <c:if test="${not empty search}">
                <a href="${pageContext.request.contextPath}/company" class="btn btn-outline-secondary">
                    <i class="fas fa-times"></i>
                </a>
            </c:if>
        </form>
    </div>
</div>

<!-- Company Grid -->
<div class="container py-5">

    <c:choose>
        <c:when test="${empty companies}">
            <div class="text-center py-5">
                <i class="fas fa-building fa-3x text-muted mb-3 d-block"></i>
                <h5 class="text-muted">No companies found</h5>
                <c:if test="${not empty search}">
                    <a href="${pageContext.request.contextPath}/company" class="btn btn-outline-dark btn-sm mt-2">
                        View all companies
                    </a>
                </c:if>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="co" items="${companies}">
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 company-card border-0 shadow-sm">
                            <div class="card-body p-4">
                                <div class="d-flex gap-3 mb-3">
                                    <!-- Logo or initials avatar -->
                                    <c:choose>
                                        <c:when test="${not empty co.profilePath}">
                                            <img src="${pageContext.request.contextPath}/${co.profilePath}"
                                                 class="rounded-circle" width="60" height="60"
                                                 style="object-fit:cover;" alt="${co.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="avatar-circle">
                                                <i class="fas fa-building"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div>
                                        <h5 class="fw-bold mb-0">${co.name}</h5>
                                        <small class="text-muted">
                                            <i class="fas fa-map-marker-alt me-1"></i>
                                            ${co.city.cityName}, ${co.state.stateName}
                                        </small>
                                    </div>
                                </div>

                                <c:if test="${not empty co.companyDescription}">
                                    <p class="text-muted small mb-3">
                                        <c:choose>
                                            <c:when test="${co.companyDescription.length() > 120}">
                                                ${co.companyDescription.substring(0, 120)}...
                                            </c:when>
                                            <c:otherwise>${co.companyDescription}</c:otherwise>
                                        </c:choose>
                                    </p>
                                </c:if>

                                <p class="small text-muted mb-3">
                                    <i class="fas fa-phone me-1"></i>${co.contactNumber}
                                    &nbsp;|&nbsp;
                                    <i class="fas fa-envelope me-1"></i>${co.email}
                                </p>

                                <a href="${pageContext.request.contextPath}/company/${co.userId}"
                                   class="btn btn-sm btn-dark w-100">
                                    <i class="fas fa-eye me-1"></i>View Profile &amp; Events
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
