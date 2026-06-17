<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${company.name} - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .event-card { transition: transform .18s; }
        .event-card:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,0,0,.1); }
        .company-banner {
            background: linear-gradient(135deg, #1a1a2e, #0f3460);
            min-height: 200px;
        }
        .btn-theme {
            background: linear-gradient(to bottom right, #ff3e00, #ffbe30);
            color: #fff !important;
            border: none;
            font-weight: 600;
            transition: all .3s ease-in-out;
        }
        .btn-theme:hover {
            background: linear-gradient(to bottom right, #ffbe30, #ff3e00);
            color: #fff !important;
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
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event">Events</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/company">Companies</a></li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${not empty user}">
                        <c:choose>
                            <c:when test="${user.roleId == 1}">
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/history">History</a></li>
                            </c:when>
                            <c:when test="${user.roleId == 2}">
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/vendor/my-events">My Events</a></li>
                            </c:when>
                            <c:when test="${user.roleId == 3}">
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Admin</a></li>
                            </c:when>
                        </c:choose>
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

<!-- Company Banner -->
<section class="company-banner text-white d-flex align-items-end pb-0">
    <div class="container pb-0">
        <div class="d-flex align-items-end gap-4 pb-4">
            <!-- Logo / Avatar -->
            <div>
                <c:choose>
                    <c:when test="${not empty company.profilePath}">
                        <img src="${pageContext.request.contextPath}/${company.profilePath}"
                             class="rounded-3 border border-3 border-white"
                             width="100" height="100" style="object-fit:cover;" alt="${company.name}">
                    </c:when>
                    <c:otherwise>
                        <div class="rounded-3 border border-3 border-white d-flex align-items-center
                                    justify-content-center"
                             style="width:100px;height:100px;font-size:3rem;background:#f0f0f0;">
                            &#127970;
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="pb-1">
                <h2 class="fw-bold mb-0">${company.name}</h2>
                <p class="text-white-50 mb-0">
                    <i class="fas fa-map-marker-alt me-1"></i>
                    ${company.city.cityName}, ${company.state.stateName}
                    &nbsp;|&nbsp;
                    <i class="fas fa-calendar-check me-1"></i>
                    ${totalEvents} total events
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Body -->
<div class="container my-5">
    <div class="row g-4">

        <!-- Left: Company Info -->
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-3">About ${company.name}</h5>

                    <c:if test="${not empty company.companyDescription}">
                        <p class="text-muted small">${company.companyDescription}</p>
                        <hr>
                    </c:if>

                    <ul class="list-unstyled small text-muted">
                        <li class="mb-2">
                            <i class="fas fa-envelope fa-fw me-2 text-primary"></i>${company.email}
                        </li>
                        <li class="mb-2">
                            <i class="fas fa-phone fa-fw me-2 text-success"></i>${company.contactNumber}
                        </li>
                        <c:if test="${not empty company.streetAddress}">
                            <li class="mb-2">
                                <i class="fas fa-map-marker-alt fa-fw me-2 text-danger"></i>
                                ${company.streetAddress}, ${company.city.cityName}, ${company.state.stateName}
                            </li>
                        </c:if>
                    </ul>

                    <div class="mt-3 pt-3 border-top text-center">
                        <span class="text-muted small">Total Events</span>
                        <h3 class="fw-bold text-primary mb-0">${totalEvents}</h3>
                    </div>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/company"
               class="btn btn-theme w-100 mt-3">
                <i class="fas fa-arrow-left me-2"></i>Back to Companies
            </a>
        </div>

        <!-- Right: Upcoming Events -->
        <div class="col-lg-8">
            <h4 class="fw-bold mb-4">Upcoming Events by <span class="text-primary">${company.name}</span></h4>

            <c:choose>
                <c:when test="${empty upcomingEvents}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        No upcoming events from this company at the moment.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-3">
                        <c:forEach var="ev" items="${upcomingEvents}">
                            <div class="col-md-6">
                                <div class="card h-100 event-card border-0 shadow-sm">
                                    <div class="card-body p-3">
                                        <span class="badge mb-2" style="background:linear-gradient(to bottom right,#ff3e00,#ffbe30);color:#fff;">${ev.eventCategory.eventCategoryName}</span>
                                        <h6 class="fw-bold mb-1">${ev.eventName}</h6>
                                        <p class="text-muted small mb-1">
                                            <i class="fas fa-map-marker-alt me-1"></i>
                                            ${ev.city.cityName}, ${ev.state.stateName}
                                        </p>
                                        <p class="text-muted small mb-2">
                                            <i class="fas fa-calendar me-1"></i>${ev.startDatetime}
                                        </p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-info">
                                                <i class="fas fa-users me-1"></i>${ev.totalWorkhand} slots
                                            </small>
                                            <a href="${pageContext.request.contextPath}/event-details/${ev.eventId}"
                                               class="btn btn-sm btn-theme">Apply</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
