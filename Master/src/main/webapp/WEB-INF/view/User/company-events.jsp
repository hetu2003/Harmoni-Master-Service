<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty successMessage}">
<div class="alert alert-success alert-dismissible m-3" id="flashMsg" style="border-left:4px solid #28a745;">
    <i class="fas fa-check-circle mr-2"></i>${successMessage}
    <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
</div>
</c:if>
<c:if test="${not empty errorMessage}">
<div class="alert alert-danger alert-dismissible m-3" id="flashMsg" style="border-left:4px solid #dc3545;">
    <i class="fas fa-exclamation-circle mr-2"></i>${errorMessage}
    <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
</div>
</c:if>

<!-- page banner -->
<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">manage your events</span>
                            <h2 class="big-title">My <strong>Events</strong></h2>
                            <p class="white-color mb-0 mt-2">Total Events: ${totalEvent}</p>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="<c:url value='/home' />" class="breadcrumb-link">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">My Events</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- toolbar -->
<div style="background:#fff; border-bottom:1px solid #eee; padding:10px 0;">
    <div class="container text-right">
        <a href="<c:url value='/vendor/event/add' />" class="custom-btn" style="padding:9px 22px; font-size:0.88rem;">
            <i class="fas fa-plus mr-1"></i>Add Event
        </a>
    </div>
</div>

<div class="container" style="padding: 40px 0;">

    <c:choose>
        <c:when test="${empty events or (events.content != null and empty events.content)}">
            <div class="text-center" style="padding: 80px 0;">
                <i class="fas fa-calendar-times fa-4x mb-3 d-block text-muted"></i>
                <h5>No events yet</h5>
                <p class="mb-3 text-muted">You haven't created any events. Start by adding your first event.</p>
                <a href="<c:url value='/vendor/event/add' />" class="custom-btn">
                    <i class="fas fa-plus mr-2"></i>Add Event
                </a>
            </div>
        </c:when>
        <c:otherwise>

            <div class="row">
                <c:forEach var="ev" items="${events.content}">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 shadow-sm" style="border-radius:10px; overflow:hidden;">

                            <c:choose>
                                <c:when test="${not empty ev.imagePath}">
                                    <img src="${pageContext.request.contextPath}/${ev.imagePath}"
                                         style="height:150px; object-fit:cover; width:100%;" alt="${ev.eventName}">
                                </c:when>
                                <c:otherwise>
                                    <div style="height:150px; background:linear-gradient(135deg,#667eea,#764ba2);
                                                display:flex; align-items:center; justify-content:center;">
                                        <i class="fas fa-calendar-alt fa-2x" style="color:rgba(255,255,255,0.5);"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="card-body d-flex flex-column">

                                <div class="mb-2">
                                    <span class="badge badge-primary">${ev.eventCategory.eventCategoryName}</span>
                                    <span class="badge badge-secondary ml-1">${ev.eventSubcategory.eventSubcategoryName}</span>
                                    <c:if test="${ev.featured}">
                                        <span class="badge" style="background:#f0a500; color:#fff;">
                                            <i class="fas fa-star mr-1"></i>Featured
                                        </span>
                                    </c:if>
                                </div>

                                <h6 class="card-title font-weight-bold mb-1">${ev.eventName}</h6>

                                <p class="text-muted small mb-1">
                                    <i class="fas fa-map-marker-alt mr-1"></i>
                                    ${ev.city.cityName}, ${ev.state.stateName}
                                </p>
                                <p class="text-muted small mb-1">
                                    <i class="fas fa-calendar mr-1"></i>${ev.startDatetime}
                                </p>
                                <p class="text-muted small mb-3">
                                    <i class="fas fa-users mr-1 text-info"></i>${ev.totalWorkhand} workhands
                                    &nbsp;|&nbsp;
                                    <i class="fas fa-rupee-sign mr-1 text-success"></i>${ev.totalPrice}
                                </p>

                                <div class="mt-auto">
                                    <a href="<c:url value='/vendor/workhand-requests/${ev.eventId}' />"
                                       class="btn btn-sm btn-outline-primary mr-1 mb-1">
                                        <i class="fas fa-users mr-1"></i>Applications
                                    </a>
                                    <a href="<c:url value='/vendor/event/${ev.eventId}/edit' />"
                                       class="btn btn-sm btn-outline-warning mr-1 mb-1">
                                        <i class="fas fa-edit mr-1"></i>Edit
                                    </a>
                                    <button type="button" class="btn btn-sm btn-outline-danger mb-1"
                                            data-toggle="modal" data-target="#deleteModal${ev.eventId}">
                                        <i class="fas fa-trash mr-1"></i>Delete
                                    </button>
                                </div>

                            </div>
                        </div>

                        <!-- Delete modal -->
                        <div class="modal fade" id="deleteModal${ev.eventId}" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <i class="fas fa-exclamation-triangle text-danger mr-2"></i>Delete Event
                                        </h5>
                                        <button type="button" class="close" data-dismiss="modal">
                                            <span>&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Are you sure you want to delete <strong>${ev.eventName}</strong>?</p>
                                        <p class="text-danger small mb-0">This action cannot be undone.</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                        <form action="<c:url value='/vendor/event/${ev.eventId}/delete' />"
                                              method="POST" class="d-inline">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                            <button type="submit" class="btn btn-danger">
                                                <i class="fas fa-trash mr-1"></i>Yes, Delete
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <c:if test="${not empty totalPageList}">
                <nav class="d-flex justify-content-center mt-4">
                    <ul class="pagination">
                        <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
                            <a class="page-link" href="<c:url value='/vendor/my-events?page=${currentPage - 2}' />">&laquo;</a>
                        </li>
                        <c:forEach var="pg" items="${totalPageList}">
                            <li class="page-item <c:if test='${pg == currentPage}'>active</c:if>">
                                <a class="page-link" href="<c:url value='/vendor/my-events?page=${pg - 1}' />">${pg}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item <c:if test='${currentPage == totalPageList.size()}'>disabled</c:if>">
                            <a class="page-link" href="<c:url value='/vendor/my-events?page=${currentPage}' />">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>

        </c:otherwise>
    </c:choose>

</div>

<script>
var flashMsg = document.getElementById('flashMsg');
if (flashMsg) setTimeout(function() { flashMsg.style.display = 'none'; }, 4000);
</script>
