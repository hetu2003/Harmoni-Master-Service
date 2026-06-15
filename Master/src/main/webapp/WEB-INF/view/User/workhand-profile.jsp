<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${workhand.name} - Workhand Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="fas fa-calendar-star me-2"></i>Harmoni
        </a>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/vendor/my-events" class="btn btn-outline-light btn-sm">
                <i class="fas fa-arrow-left me-1"></i>My Events
            </a>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="row g-4">

        <!-- Profile Card -->
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm text-center">
                <div class="card-body p-4">

                    <!-- Avatar -->
                    <c:choose>
                        <c:when test="${not empty workhand.profilePath}">
                            <img src="${pageContext.request.contextPath}${workhand.profilePath}"
                                 class="rounded-circle mb-3 border border-3"
                                 width="110" height="110" style="object-fit:cover;" alt="${workhand.name}">
                        </c:when>
                        <c:otherwise>
                            <div class="rounded-circle bg-secondary d-inline-flex align-items-center
                                        justify-content-center mb-3 border border-3 border-white shadow"
                                 style="width:110px;height:110px;font-size:2.5rem;color:#fff;">
                                <i class="fas fa-user"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <h4 class="fw-bold mb-1">${workhand.name}</h4>
                    <p class="text-muted mb-1">@${workhand.username}</p>

                    <!-- Rating stars -->
                    <div class="mb-3">
                        <c:choose>
                            <c:when test="${workhand.avgRating != null and workhand.avgRating > 0}">
                                <c:forEach begin="1" end="5" var="s">
                                    <i class="fas fa-star ${s <= workhand.avgRating ? 'text-warning' : 'text-muted'}"></i>
                                </c:forEach>
                                <span class="ms-1 small text-muted">${workhand.avgRating}/5</span>
                            </c:when>
                            <c:otherwise>
                                <c:forEach begin="1" end="5">
                                    <i class="fas fa-star text-muted"></i>
                                </c:forEach>
                                <span class="ms-1 small text-muted">Not rated yet</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <hr>

                    <ul class="list-unstyled text-start small text-muted">
                        <li class="mb-2">
                            <i class="fas fa-envelope fa-fw me-2 text-primary"></i>${workhand.email}
                        </li>
                        <li class="mb-2">
                            <i class="fas fa-phone fa-fw me-2 text-success"></i>${workhand.contactNumber}
                        </li>
                        <li class="mb-2">
                            <i class="fas fa-map-marker-alt fa-fw me-2 text-danger"></i>
                            <c:if test="${workhand.city != null}">${workhand.city.cityName}, </c:if>
                            <c:if test="${workhand.state != null}">${workhand.state.stateName}</c:if>
                        </li>
                        <c:if test="${not empty workhand.streetAddress}">
                            <li class="mb-2">
                                <i class="fas fa-home fa-fw me-2 text-info"></i>${workhand.streetAddress}
                            </li>
                        </c:if>
                    </ul>

                    <div class="mt-3 border-top pt-3">
                        <span class="text-muted small d-block mb-1">Total Approved Events</span>
                        <h3 class="fw-bold text-primary mb-0">${workhnadEvents.size()}</h3>
                    </div>

                </div>
            </div>
        </div>

        <!-- Approved Events History -->
        <div class="col-lg-8">
            <h5 class="fw-bold mb-4">
                <i class="fas fa-briefcase me-2 text-primary"></i>
                Event Work History
            </h5>

            <c:choose>
                <c:when test="${empty workhnadEvents}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        This workhand has no approved event history yet.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-3">
                        <c:forEach var="reg" items="${workhnadEvents}">
                            <div class="col-12">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-body p-3">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h6 class="fw-bold mb-1">${reg.event.eventName}</h6>
                                                <p class="text-muted small mb-1">
                                                    <i class="fas fa-building me-1"></i>${reg.event.company.name}
                                                    &nbsp;|&nbsp;
                                                    <i class="fas fa-map-marker-alt me-1"></i>
                                                    ${reg.event.city.cityName}, ${reg.event.state.stateName}
                                                </p>
                                                <p class="text-muted small mb-1">
                                                    <i class="fas fa-calendar me-1"></i>${reg.event.startDatetime}
                                                </p>
                                                <p class="small mb-0">
                                                    <span class="text-muted">Category #${reg.eventWorkhand.workhnadCategoryId}</span>
                                                    &nbsp;&bull;&nbsp;
                                                    <span class="text-success fw-semibold">
                                                        <i class="fas fa-rupee-sign me-1"></i>${reg.eventWorkhand.price}
                                                    </span>
                                                </p>
                                            </div>
                                            <div class="text-end">
                                                <c:choose>
                                                    <c:when test="${reg.paymentStatus}">
                                                        <span class="badge bg-success mb-1 d-block">Paid</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary mb-1 d-block">Unpaid</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${reg.rating != null and reg.rating > 0}">
                                                    <div class="small text-muted">
                                                        <c:forEach begin="1" end="${reg.rating}">
                                                            <i class="fas fa-star text-warning" style="font-size:.75rem;"></i>
                                                        </c:forEach>
                                                    </div>
                                                </c:if>
                                            </div>
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
