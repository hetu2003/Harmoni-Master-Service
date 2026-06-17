<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- page banner -->
<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('${pageContext.request.contextPath}/assets/images/breadcrumb/0.breadcrumb-bg.jpg');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">your event journey</span>
                            <h2 class="big-title">Registration <strong>History</strong></h2>
                            <p class="white-color mb-0 mt-2">All events you have registered for</p>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="breadcrumb-link">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">History</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="container my-5">

    <c:choose>
        <c:when test="${registrations.totalElements == 0}">
            <div class="text-center py-5 text-muted">
                <i class="fas fa-calendar-times fa-3x mb-3 d-block"></i>
                <h5>No registrations yet</h5>
                <p>You have not registered for any events yet.</p>
                <a href="${pageContext.request.contextPath}/event" class="btn btn-dark">
                    <i class="fas fa-search me-1"></i>Browse Events
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="reg" items="${registrations.content}">
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 shadow-sm border-0" style="border-radius:10px; overflow:hidden;">

                            <%-- Event banner --%>
                            <c:choose>
                                <c:when test="${not empty reg.event.imagePath}">
                                    <img src="${pageContext.request.contextPath}/${reg.event.imagePath}"
                                         style="height:140px; object-fit:cover; width:100%;" alt="${reg.event.eventName}">
                                </c:when>
                                <c:otherwise>
                                    <div style="height:140px; background:linear-gradient(135deg,#667eea,#764ba2);
                                                display:flex; align-items:center; justify-content:center;">
                                        <i class="fas fa-calendar-alt fa-3x" style="color:rgba(255,255,255,0.4);"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="card-header d-flex justify-content-between align-items-center bg-white border-bottom">
                                <span class="fw-bold text-truncate" style="max-width:160px;" title="${reg.event.eventName}">
                                    ${reg.event.eventName}
                                </span>
                                <c:choose>
                                    <c:when test="${reg.paymentStatus}">
                                        <span class="badge bg-success">Paid</span>
                                    </c:when>
                                    <c:when test="${reg.applicationStatus == 'ACCEPTED'}">
                                        <span class="badge bg-primary">Approved</span>
                                    </c:when>
                                    <c:when test="${reg.applicationStatus == 'REJECTED'}">
                                        <span class="badge bg-danger">Rejected</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark">Pending</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="card-body">
                                <ul class="list-unstyled small text-muted mb-0">
                                    <li><i class="fas fa-building me-2 text-primary"></i>${reg.event.company.name}</li>
                                    <li class="mt-1"><i class="fas fa-calendar me-2 text-secondary"></i>${reg.registrationDate}</li>
                                    <li class="mt-1"><i class="fas fa-user-tag me-2 text-info"></i>
                                        Category #${reg.eventWorkhand.workhnadCategoryId}
                                    </li>
                                    <li class="mt-1"><i class="fas fa-rupee-sign me-2 text-success"></i>
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

                            <div class="card-footer bg-transparent border-top-0 pt-0 pb-3 px-3">
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
                <nav class="mt-4">
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
