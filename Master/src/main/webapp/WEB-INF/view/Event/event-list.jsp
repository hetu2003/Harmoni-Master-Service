<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- page banner -->
<section style="background: linear-gradient(135deg, #1c1c2e 0%, #2d2d44 100%); padding: 60px 0;">
    <div class="container">
        <div class="section-title text-center mb-0">
            <small class="sub-title">upcoming events</small>
            <h2 class="big-title white-color mt-2">Browse <strong>Events</strong></h2>
            <p class="white-color mb-0 mt-2">
                <c:choose>
                    <c:when test="${not empty keyword}">
                        Search results for &ldquo;<strong>${keyword}</strong>&rdquo; &mdash; ${totalEvents} events found
                    </c:when>
                    <c:otherwise>${totalEvents} upcoming events available</c:otherwise>
                </c:choose>
            </p>
        </div>
    </div>
</section>

<!-- Create Event button — COMPANY / ADMIN only -->
<c:if test="${not empty user && (user.roleId == 2 || user.roleId == 3)}">
<div style="background:#fff; border-bottom:1px solid #eee; padding:10px 0;">
    <div class="container text-right">
        <a href="<c:url value='/vendor/event/add' />" class="custom-btn" style="padding:9px 22px; font-size:0.88rem;">
            <i class="fas fa-plus mr-1"></i>Create New Event
        </a>
    </div>
</div>
</c:if>

<!-- filter bar -->
<div style="background: #f8f9fa; border-bottom: 1px solid #dee2e6; padding: 14px 0;">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6 mb-2 mb-md-0">
                <form action="<c:url value='/event/search' />" method="POST">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <c:if test="${not empty selectedCatId}">
                        <input type="hidden" name="catId" value="${selectedCatId}">
                    </c:if>
                    <div class="input-group">
                        <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="Search by name, city, company...">
                        <div class="input-group-append">
                            <button class="btn btn-dark" type="submit"><i class="fas fa-search"></i></button>
                            <c:if test="${not empty keyword}">
                                <a href="<c:url value='/event' />" class="btn btn-outline-secondary ml-1"><i class="fas fa-times"></i></a>
                            </c:if>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-md-4 mb-2 mb-md-0">
                <select class="form-control" id="catFilter" onchange="applyCatFilter(this.value)">
                    <option value="">All Categories</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.eventCategoryId}" <c:if test="${cat.eventCategoryId == selectedCatId}">selected</c:if>>${cat.eventCategoryName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2 text-right">
                <a href="<c:url value='/event' />" class="btn btn-outline-secondary btn-sm"><i class="fas fa-redo mr-1"></i>Reset</a>
            </div>
        </div>
    </div>
</div>

<!-- events grid -->
<section style="padding: 60px 0;">
    <div class="container">
        <c:choose>
            <c:when test="${events.totalElements == 0}">
                <div class="text-center" style="padding: 80px 0;">
                    <i class="fas fa-search fa-4x mb-3 d-block" style="color: #ddd;"></i>
                    <h5>No events found</h5>
                    <c:if test="${not empty keyword}">
                        <p class="text-muted">Try different keywords or <a href="<c:url value='/event' />">browse all events</a>.</p>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach var="ev" items="${events.content}">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div style="border-radius:10px; box-shadow:0 3px 18px rgba(0,0,0,0.1); overflow:hidden; height:100%; display:flex; flex-direction:column; background:#fff; transition:transform .2s;">

                                <!-- banner -->
                                <c:choose>
                                    <c:when test="${not empty ev.imagePath}">
                                        <img src="${pageContext.request.contextPath}/${ev.imagePath}" style="height:190px; object-fit:cover; width:100%;" alt="${ev.eventName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="height:190px; background:linear-gradient(135deg,#667eea,#764ba2); display:flex; align-items:center; justify-content:center;">
                                            <i class="fas fa-calendar-alt fa-3x" style="color:rgba(255,255,255,0.45);"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div style="padding:20px; flex:1; display:flex; flex-direction:column;">

                                    <!-- badges -->
                                    <div class="mb-2">
                                        <span style="background:#0056d2; color:#fff; padding:3px 9px; border-radius:4px; font-size:0.75rem;">${ev.eventCategory.eventCategoryName}</span>
                                        <c:if test="${not empty ev.eventSubcategory.eventSubcategoryName}">
                                            <span style="border:1px solid #ddd; padding:3px 9px; border-radius:4px; font-size:0.75rem; margin-left:4px;">${ev.eventSubcategory.eventSubcategoryName}</span>
                                        </c:if>
                                        <c:if test="${ev.featured}">
                                            <span style="background:#f0a500; color:#fff; padding:3px 9px; border-radius:4px; font-size:0.75rem; margin-left:4px;"><i class="fas fa-star mr-1"></i>Featured</span>
                                        </c:if>
                                    </div>

                                    <h5 class="font-weight-bold mb-2" style="line-height:1.3;">${ev.eventName}</h5>

                                    <p class="mb-1" style="font-size:0.85rem; color:#666;">
                                        <i class="fas fa-building mr-1" style="color:#0056d2;"></i>
                                        <a href="${pageContext.request.contextPath}/company/${ev.company.userId}" style="color:#666; text-decoration:none;">${ev.company.name}</a>
                                    </p>
                                    <p class="mb-1" style="font-size:0.85rem; color:#666;">
                                        <i class="fas fa-map-marker-alt mr-1" style="color:#e44;"></i>${ev.city.cityName}, ${ev.state.stateName}
                                    </p>
                                    <p class="mb-3" style="font-size:0.85rem; color:#666;">
                                        <i class="fas fa-calendar-alt mr-1" style="color:#28a745;"></i>${ev.startDatetime}
                                    </p>

                                    <!-- footer -->
                                    <div class="mt-auto d-flex justify-content-between align-items-center">
                                        <div>
                                            <span style="font-size:0.82rem; color:#17a2b8; font-weight:600; display:block;"><i class="fas fa-users mr-1"></i>${ev.totalWorkhand} needed</span>
                                            <span style="font-size:0.82rem; color:#28a745; font-weight:600;"><i class="fas fa-rupee-sign mr-1"></i>${ev.totalPrice}</span>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/event-details/${ev.eventId}" class="custom-btn" style="padding:8px 18px; font-size:0.82rem;">View &amp; Apply</a>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- pagination -->
                <c:if test="${not empty totalPageList}">
                    <div class="d-flex justify-content-center mt-4">
                        <ul class="pagination">
                            <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/event?page=${currentPage - 2}<c:if test='${not empty selectedCatId}'>&catId=${selectedCatId}</c:if>">&laquo;</a>
                            </li>
                            <c:forEach var="pg" items="${totalPageList}">
                                <li class="page-item <c:if test='${pg == currentPage}'>active</c:if>">
                                    <a class="page-link" href="${pageContext.request.contextPath}/event?page=${pg - 1}<c:if test='${not empty selectedCatId}'>&catId=${selectedCatId}</c:if>">${pg}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item <c:if test='${currentPage == totalPageList.size()}'>disabled</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/event?page=${currentPage}<c:if test='${not empty selectedCatId}'>&catId=${selectedCatId}</c:if>">&raquo;</a>
                            </li>
                        </ul>
                    </div>
                </c:if>

            </c:otherwise>
        </c:choose>
    </div>
</section>

<script>
function applyCatFilter(catId) {
    var url = '${pageContext.request.contextPath}/event';
    if (catId) url += '?catId=' + catId;
    window.location.href = url;
}
</script>
