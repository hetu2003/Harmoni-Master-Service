<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Registration History - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <section class="py-3 bg-dark text-white">
        <div class="container">
            <h4 class="mb-0">My <strong>Registration History</strong></h4>
        </div>
    </section>

    <div class="container my-5">

        <c:choose>
            <c:when test="${registrations.totalElements == 0}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>
                    You have not registered for any events yet.
                    <a href="${pageContext.request.contextPath}/event" class="alert-link">Browse events</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="reg" items="${registrations.content}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card h-100 shadow-sm">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-truncate" style="max-width:160px;"
                                          title="${reg.event.eventName}">
                                        ${reg.event.eventName}
                                    </span>
                                    <c:choose>
                                        <c:when test="${reg.paymentStatus}">
                                            <span class="badge bg-success">Paid</span>
                                        </c:when>
                                        <c:when test="${reg.registrationStatus}">
                                            <span class="badge bg-warning text-dark">Approved</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Pending</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-body">
                                    <ul class="list-unstyled small text-muted mb-0">
                                        <li>
                                            <i class="fas fa-building me-2"></i>
                                            ${reg.event.company.name}
                                        </li>
                                        <li class="mt-1">
                                            <i class="fas fa-calendar me-2"></i>
                                            ${reg.registrationDate}
                                        </li>
                                        <li class="mt-1">
                                            <i class="fas fa-user-tag me-2"></i>
                                            Category #${reg.eventWorkhand.workhnadCategoryId}
                                        </li>
                                        <li class="mt-1">
                                            <i class="fas fa-rupee-sign me-2"></i>
                                            &#8377;<fmt:formatNumber value="${reg.eventWorkhand.price}" maxFractionDigits="0"/>
                                        </li>
                                        <c:if test="${reg.paymentStatus and reg.rating != null}">
                                            <li class="mt-1">
                                                <i class="fas fa-star me-2 text-warning"></i>
                                                Rating: <strong>${reg.rating}/5</strong>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                                <div class="card-footer bg-transparent">
                                    <a href="${pageContext.request.contextPath}/event-details/${reg.event.eventId}"
                                       class="btn btn-sm btn-outline-primary w-100">
                                        <i class="fas fa-eye me-1"></i>View Event
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <%-- Pagination --%>
                <c:if test="${registrations.totalPages > 1}">
                    <nav class="mt-4" aria-label="History pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${registrations.first ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${registrations.number - 1}">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                            <c:forEach var="pg" items="${totalPageList}">
                                <li class="page-item ${pg == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${pg - 1}">${pg}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${registrations.last ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${registrations.number + 1}">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
