<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- page banner -->
<section style="background: linear-gradient(135deg, #1c1c2e 0%, #2d2d44 100%); padding: 60px 0;">
    <div class="container">
        <div class="section-title text-center mb-0">
            <small class="sub-title">past events</small>
            <h2 class="big-title white-color mt-2">Recently <strong>Closed Events</strong></h2>
            <p class="white-color mb-0 mt-2">${totalEvents} recently closed events</p>
        </div>
    </div>
</section>

<!-- Back button bar -->
<div style="background:#fff; border-bottom:1px solid #eee; padding:10px 0;">
    <div class="container">
        <a href="<c:url value='/event' />" class="custom-btn" style="padding:9px 22px; font-size:0.88rem;">
            <i class="fas fa-arrow-left mr-2"></i>Back to Events
        </a>
    </div>
</div>

<!-- Event list -->
<section style="padding: 60px 0; background: #f8f9fa;">
    <div class="container">

        <c:choose>
            <c:when test="${empty events.content}">
                <div class="text-center py-5">
                    <i class="fas fa-calendar-times fa-4x text-muted mb-3 d-block"></i>
                    <h4 class="text-muted">No recently closed events found.</h4>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach var="ev" items="${events.content}">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card h-100 shadow-sm border-0" style="border-radius:10px; overflow:hidden; opacity:0.88;">

                                <!-- Event image -->
                                <c:choose>
                                    <c:when test="${not empty ev.imagePath}">
                                        <img src="${pageContext.request.contextPath}/${ev.imagePath}"
                                             class="card-img-top"
                                             style="height:180px; object-fit:cover; filter:grayscale(30%);"
                                             alt="${ev.eventName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="height:180px; background:linear-gradient(135deg,#555,#333);
                                                    display:flex; align-items:center; justify-content:center;">
                                            <i class="fas fa-calendar-check fa-3x text-white"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Closed badge overlay -->
                                <div style="position:absolute; top:12px; left:12px;">
                                    <span class="badge" style="background:#6c757d; color:#fff; font-size:0.75rem; padding:5px 10px;">
                                        <i class="fas fa-lock mr-1"></i>Closed
                                    </span>
                                </div>

                                <div class="card-body p-3">
                                    <span class="badge mb-2" style="background:linear-gradient(to bottom right,#ff3e00,#ffbe30);color:#fff;">
                                        ${ev.eventCategory.eventCategoryName}
                                    </span>
                                    <h6 class="font-weight-bold mb-1">${ev.eventName}</h6>
                                    <p class="text-muted small mb-1">
                                        <i class="fas fa-map-marker-alt mr-1"></i>
                                        ${ev.city.cityName}, ${ev.state.stateName}
                                    </p>
                                    <p class="text-muted small mb-2">
                                        <i class="fas fa-calendar mr-1"></i>${ev.startDatetime}
                                        &mdash; ${ev.endDatetime}
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="fas fa-users mr-1"></i>${ev.totalWorkhand} positions
                                        </small>
                                        <a href="${pageContext.request.contextPath}/event-details/${ev.eventId}"
                                           class="btn btn-sm btn-outline-secondary">
                                            <i class="fas fa-eye mr-1"></i>View
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination -->
                <c:if test="${events.totalPages > 1}">
                    <div class="text-center mt-4">
                        <ul class="pagination justify-content-center flex-wrap" style="gap:4px;">
                            <c:if test="${events.number > 0}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${events.number - 1}">&laquo; Prev</a>
                                </li>
                            </c:if>
                            <c:forEach var="pg" items="${totalPageList}">
                                <li class="page-item ${pg == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${pg - 1}">${pg}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${events.number + 1 < events.totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${events.number + 1}">Next &raquo;</a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </c:if>

            </c:otherwise>
        </c:choose>
    </div>
</section>
