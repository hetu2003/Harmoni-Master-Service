<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Events - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .event-card { transition: transform .18s, box-shadow .18s; }
        .event-card:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,0,0,.1); }
        .filter-bar { background: #f8f9fa; border-bottom: 1px solid #dee2e6; }
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/event">Events</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/company">Companies</a></li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${pageContext.request.userPrincipal != null}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/history">History</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                        </li>
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
    <div class="container">
        <h3 class="mb-1">Browse <strong>Events</strong></h3>
        <p class="text-white-50 mb-0">
            <c:choose>
                <c:when test="${not empty keyword}">
                    Search results for "<strong>${keyword}</strong>" —
                    <c:choose>
                        <c:when test="${events instanceof java.util.List}">${events.size()}</c:when>
                        <c:otherwise>${totalEvents}</c:otherwise>
                    </c:choose>
                    events found
                </c:when>
                <c:otherwise>
                    ${totalEvents} upcoming events available
                </c:otherwise>
            </c:choose>
        </p>
    </div>
</section>

<!-- Filter & Search Bar -->
<div class="filter-bar py-3">
    <div class="container">
        <div class="row g-2 align-items-end">

            <!-- Keyword search -->
            <div class="col-md-5">
                <form action="${pageContext.request.contextPath}/event/search" method="POST" id="searchForm">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <c:if test="${not empty selectedCatId}">
                        <input type="hidden" name="catId" value="${selectedCatId}">
                    </c:if>
                    <div class="input-group">
                        <input type="text" class="form-control" name="keyword"
                               value="${keyword}" placeholder="Search by name, city, company...">
                        <button class="btn btn-dark" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                        <c:if test="${not empty keyword}">
                            <a href="${pageContext.request.contextPath}/event" class="btn btn-outline-secondary">
                                <i class="fas fa-times"></i>
                            </a>
                        </c:if>
                    </div>
                </form>
            </div>

            <!-- Category filter -->
            <div class="col-md-4">
                <select class="form-select" id="catFilter" onchange="applyCatFilter(this.value)">
                    <option value="">All Categories</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.eventCategoryId}"
                            <c:if test="${cat.eventCategoryId == selectedCatId}">selected</c:if>>
                            ${cat.eventCategoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Reset -->
            <div class="col-md-3 text-end">
                <a href="${pageContext.request.contextPath}/event" class="btn btn-outline-secondary btn-sm">
                    <i class="fas fa-redo me-1"></i>Reset Filters
                </a>
            </div>

        </div>
    </div>
</div>

<!-- Event Grid -->
<div class="container py-5">

    <c:choose>
        <c:when test="${(events instanceof java.util.List and empty events) or
                        (not (events instanceof java.util.List) and events.totalElements == 0)}">
            <div class="text-center py-5">
                <i class="fas fa-search fa-3x text-muted mb-3 d-block"></i>
                <h5 class="text-muted">No events found</h5>
                <c:if test="${not empty keyword}">
                    <p class="text-muted">Try different keywords or
                        <a href="${pageContext.request.contextPath}/event">browse all events</a>.
                    </p>
                </c:if>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="ev" items="${events}">
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 event-card border-0 shadow-sm">

                            <%-- Banner image --%>
                            <c:choose>
                                <c:when test="${not empty ev.imagePath}">
                                    <img src="${pageContext.request.contextPath}/${ev.imagePath}"
                                         class="card-img-top"
                                         style="height:160px; object-fit:cover;"
                                         alt="${ev.eventName}">
                                </c:when>
                                <c:otherwise>
                                    <div style="height:160px; background:linear-gradient(135deg,#0d6efd,#6610f2);
                                                display:flex; align-items:center; justify-content:center;">
                                        <i class="fas fa-calendar-alt fa-3x text-white opacity-50"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="card-body d-flex flex-column p-4">

                                <div class="mb-2 d-flex flex-wrap gap-1">
                                    <span class="badge bg-primary">${ev.eventCategory.eventCategoryName}</span>
                                    <span class="badge bg-light text-dark border">
                                        ${ev.eventSubcategory.eventSubcategoryName}
                                    </span>
                                    <c:if test="${ev.featured}">
                                        <span class="badge bg-warning text-dark">
                                            <i class="fas fa-star me-1"></i>Featured
                                        </span>
                                    </c:if>
                                </div>

                                <h5 class="fw-bold mb-1">${ev.eventName}</h5>

                                <p class="text-muted small mb-1">
                                    <i class="fas fa-building me-1"></i>
                                    <a href="${pageContext.request.contextPath}/company/${ev.company.userId}"
                                       class="text-muted text-decoration-none">
                                        ${ev.company.name}
                                    </a>
                                </p>

                                <p class="text-muted small mb-1">
                                    <i class="fas fa-map-marker-alt me-1"></i>
                                    ${ev.streetAddress}, ${ev.city.cityName}, ${ev.state.stateName}
                                </p>

                                <p class="text-muted small mb-3">
                                    <i class="fas fa-calendar-alt me-1"></i>
                                    ${ev.startDatetime}
                                </p>

                                <div class="mt-auto d-flex justify-content-between align-items-center">
                                    <div class="small">
                                        <span class="text-info fw-semibold">
                                            <i class="fas fa-users me-1"></i>${ev.totalWorkhand} needed
                                        </span>
                                        <br>
                                        <span class="text-success fw-semibold">
                                            <i class="fas fa-rupee-sign me-1"></i>${ev.totalPrice}
                                        </span>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/event-details/${ev.eventId}"
                                       class="btn btn-sm btn-dark">
                                        View &amp; Apply
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <%-- Pagination (only when result is a Page, not a List from search) --%>
            <c:if test="${not empty totalPageList}">
                <nav class="mt-5 d-flex justify-content-center">
                    <ul class="pagination">
                        <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/event?page=${currentPage - 2}<c:if test='${not empty selectedCatId}'>&catId=${selectedCatId}</c:if>">
                                &laquo;
                            </a>
                        </li>
                        <c:forEach var="pg" items="${totalPageList}">
                            <li class="page-item <c:if test='${pg == currentPage}'>active</c:if>">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/event?page=${pg - 1}<c:if test='${not empty selectedCatId}'>&catId=${selectedCatId}</c:if>">
                                    ${pg}
                                </a>
                            </li>
                        </c:forEach>
                        <li class="page-item <c:if test='${currentPage == totalPageList.size()}'>disabled</c:if>">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/event?page=${currentPage}<c:if test='${not empty selectedCatId}'>&catId=${selectedCatId}</c:if>">
                                &raquo;
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>

        </c:otherwise>
    </c:choose>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    var CTX = '${pageContext.request.contextPath}';
    function applyCatFilter(catId) {
        var url = CTX + '/event';
        if (catId) url += '?catId=' + catId;
        window.location.href = url;
    }
</script>
</body>
</html>
