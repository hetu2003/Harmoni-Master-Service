<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Events - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <%-- Flash messages --%>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show m-3" id="flashMsg">
            <i class="fas fa-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show m-3" id="flashMsg">
            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Header -->
    <section class="py-3 bg-dark text-white">
        <div class="container d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-0">My <strong>Events</strong></h4>
                <small class="text-muted">
                    Total Events: ${totalEvent}
                </small>
            </div>
            <a href="${pageContext.request.contextPath}/vendor/event/add"
               class="btn btn-success">
                <i class="fas fa-plus me-2"></i>Add Event
            </a>
        </div>
    </section>

    <div class="container my-4">

        <c:choose>
            <c:when test="${empty events or (events.content != null and empty events.content)}">
                <div class="alert alert-info text-center py-5">
                    <i class="fas fa-calendar-times fa-3x mb-3 d-block text-muted"></i>
                    <h5>No events yet</h5>
                    <p class="mb-3">You haven't created any events. Start by adding your first event.</p>
                    <a href="${pageContext.request.contextPath}/vendor/event/add"
                       class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Add Event
                    </a>
                </div>
            </c:when>
            <c:otherwise>

                <div class="row g-4">
                    <c:forEach var="ev" items="${events}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card h-100 shadow-sm">

                                <%-- Banner image --%>
                                <c:choose>
                                    <c:when test="${not empty ev.imagePath}">
                                        <img src="${pageContext.request.contextPath}/${ev.imagePath}"
                                             class="card-img-top"
                                             style="height:140px; object-fit:cover;"
                                             alt="${ev.eventName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="height:140px; background:linear-gradient(135deg,#0d6efd,#6610f2);
                                                    display:flex; align-items:center; justify-content:center;">
                                            <i class="fas fa-calendar-alt fa-2x text-white opacity-50"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="card-body d-flex flex-column">

                                    <!-- Category badge -->
                                    <div class="mb-2 d-flex flex-wrap gap-1">
                                        <span class="badge bg-primary">
                                            ${ev.eventCategory.eventCategoryName}
                                        </span>
                                        <span class="badge bg-secondary">
                                            ${ev.eventSubcategory.eventSubcategoryName}
                                        </span>
                                        <c:if test="${ev.featured}">
                                            <span class="badge bg-warning text-dark">
                                                <i class="fas fa-star me-1"></i>Featured
                                            </span>
                                        </c:if>
                                    </div>

                                    <h5 class="card-title mb-1">${ev.eventName}</h5>

                                    <p class="text-muted small mb-2">
                                        <i class="fas fa-map-marker-alt me-1"></i>
                                        ${ev.streetAddress}, ${ev.city.cityName}, ${ev.state.stateName}
                                    </p>

                                    <p class="text-muted small mb-1">
                                        <i class="fas fa-calendar-alt me-1"></i>
                                        ${ev.startDatetime}
                                        &nbsp;&rarr;&nbsp;
                                        ${ev.endDatetime}
                                    </p>

                                    <p class="small mb-3">
                                        <i class="fas fa-users me-1 text-info"></i>
                                        ${ev.totalWorkhand} workhands &nbsp;|&nbsp;
                                        <i class="fas fa-rupee-sign me-1 text-success"></i>
                                        ${ev.totalPrice}
                                    </p>

                                    <!-- Action buttons -->
                                    <div class="mt-auto d-flex flex-wrap gap-1">
                                        <a href="${pageContext.request.contextPath}/vendor/workhand-requests/${ev.eventId}"
                                           class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-clock me-1"></i>Requests
                                        </a>
                                        <a href="${pageContext.request.contextPath}/vendor/event/${ev.eventId}/edit"
                                           class="btn btn-sm btn-outline-warning">
                                            <i class="fas fa-edit me-1"></i>Edit
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger"
                                                data-bs-toggle="modal"
                                                data-bs-target="#deleteModal${ev.eventId}">
                                            <i class="fas fa-trash me-1"></i>Delete
                                        </button>
                                    </div>

                                </div>
                            </div>

                            <%-- Delete Confirmation Modal --%>
                            <div class="modal fade" id="deleteModal${ev.eventId}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">
                                                <i class="fas fa-exclamation-triangle text-danger me-2"></i>
                                                Delete Event
                                            </h5>
                                            <button type="button" class="btn-close"
                                                    data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Are you sure you want to delete
                                                <strong>${ev.eventName}</strong>?
                                            </p>
                                            <p class="text-danger small mb-0">
                                                This action cannot be undone. All workhand registrations
                                                for this event will also be removed.
                                            </p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Cancel</button>
                                            <form action="${pageContext.request.contextPath}/vendor/event/${ev.eventId}/delete"
                                                  method="POST" class="d-inline">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                       value="${_csrf.token}">
                                                <button type="submit" class="btn btn-danger">
                                                    <i class="fas fa-trash me-1"></i>Yes, Delete
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- /Delete Modal --%>

                        </div>
                    </c:forEach>
                </div>

                <%-- Pagination (only rendered when events is a Page object) --%>
                <c:if test="${not empty totalPageList}">
                    <nav class="mt-5 d-flex justify-content-center">
                        <ul class="pagination">
                            <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/vendor/my-events?page=${currentPage - 2}">
                                    &laquo;
                                </a>
                            </li>
                            <c:forEach var="pg" items="${totalPageList}">
                                <li class="page-item <c:if test='${pg == currentPage}'>active</c:if>">
                                    <a class="page-link"
                                       href="${pageContext.request.contextPath}/vendor/my-events?page=${pg - 1}">
                                        ${pg}
                                    </a>
                                </li>
                            </c:forEach>
                            <li class="page-item <c:if test='${currentPage == totalPageList.size()}'>disabled</c:if>">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/vendor/my-events?page=${currentPage}">
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
        /* Auto-dismiss flash messages */
        var msg = document.getElementById('flashMsg');
        if (msg) setTimeout(function () {
            msg.classList.remove('show');
        }, 4000);
    </script>
</body>
</html>
