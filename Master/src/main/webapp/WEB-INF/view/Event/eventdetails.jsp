<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.detail-banner { background: linear-gradient(135deg, #1c1c2e 0%, #2d2d44 100%); padding: 50px 0; }
.status-badge-pending  { background: #fff3cd; color: #856404; border: 1px solid #ffc107; }
.status-badge-accepted { background: #d1e7dd; color: #0f5132; border: 1px solid #198754; }
.status-badge-rejected { background: #f8d7da; color: #842029; border: 1px solid #dc3545; }
.apply-btn { display: inline-block; }
</style>

<c:if test="${not empty successMessage}">
<div class="alert alert-success alert-dismissible m-3" style="border-left: 4px solid #28a745;">
    <i class="fas fa-check-circle mr-2"></i>${successMessage}
    <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
</div>
</c:if>
<c:if test="${not empty errorMessage}">
<div class="alert alert-danger alert-dismissible m-3" style="border-left: 4px solid #dc3545;">
    <i class="fas fa-exclamation-circle mr-2"></i>${errorMessage}
    <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
</div>
</c:if>

<!-- Banner -->
<section class="detail-banner">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb" style="background:transparent; padding:0; margin-bottom:12px;">
                <li class="breadcrumb-item"><a href="<c:url value='/home' />" style="color:#ccc;">Home</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/event' />" style="color:#ccc;">Events</a></li>
                <li class="breadcrumb-item active" style="color:#f0a500;">${event.eventName}</li>
            </ol>
        </nav>
        <h2 class="white-color mb-1 font-weight-bold">${event.eventName}
            <c:if test="${event.featured}">
                <span class="badge" style="background:#f0a500; color:#fff; font-size:0.7rem; vertical-align:middle; margin-left:8px;">
                    <i class="fas fa-star mr-1"></i>Featured
                </span>
            </c:if>
        </h2>
        <p class="mb-1" style="color:#ccc;">
            <i class="fas fa-calendar mr-2" style="color:#f0a500;"></i>${event.startDatetime} &mdash; ${event.endDatetime}
        </p>
        <p class="mb-0" style="color:#ccc;">
            <i class="fas fa-map-marker-alt mr-2" style="color:#f0a500;"></i>${event.streetAddress}, ${event.city.cityName}, ${event.state.stateName}
        </p>
    </div>
</section>


<!-- Event banner image -->
<c:if test="${not empty event.imagePath}">
<div style="max-height:300px; overflow:hidden;">
    <img src="${pageContext.request.contextPath}/${event.imagePath}" class="w-100" style="object-fit:cover; max-height:300px;" alt="${event.eventName}">
</div>
</c:if>

<section style="padding: 50px 0;">
    <div class="container">
        <div class="row">

            <!-- Left: main content -->
            <div class="col-lg-8">

                <!-- About -->
                <div class="card mb-4 shadow-sm">
                    <div class="card-header" style="background:#f8f9fa; border-bottom:2px solid #f0a500;">
                        <h5 class="mb-0 font-weight-bold">About This Event</h5>
                    </div>
                    <div class="card-body">${event.description}</div>
                </div>

                <!-- Apply / Status block (WORKHAND only) -->
                <c:if test="${not isCompany}">
                    <div class="mb-4">
                        <c:choose>
                            <c:when test="${alreadyRegistered and myApplicationStatus == 'PENDING'}">
                                <div class="alert" style="border-left:4px solid #ffc107; background:#fffbf0;">
                                    <i class="fas fa-clock mr-2" style="color:#ffc107;"></i>
                                    <strong>Application Pending</strong> — The company is reviewing your application. We'll notify you once a decision is made.
                                </div>
                            </c:when>
                            <c:when test="${alreadyRegistered and myApplicationStatus == 'ACCEPTED'}">
                                <div class="alert" style="border-left:4px solid #28a745; background:#f0fff4;">
                                    <i class="fas fa-check-circle mr-2" style="color:#28a745;"></i>
                                    <strong>Application Accepted!</strong> — Congratulations! You have been accepted for this event.
                                </div>
                            </c:when>
                            <c:when test="${alreadyRegistered and myApplicationStatus == 'REJECTED'}">
                                <div class="alert" style="border-left:4px solid #dc3545; background:#fff5f5;">
                                    <i class="fas fa-times-circle mr-2" style="color:#dc3545;"></i>
                                    <strong>Application Not Accepted</strong> — Unfortunately your application was not accepted for this event.
                                </div>
                            </c:when>
                            <c:when test="${not empty currentUser}">
                                <a href="<c:url value='/event-register/${event.eventId}' />" class="custom-btn">
                                    <i class="fas fa-paper-plane mr-2"></i>Apply for This Event
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='/login' />" class="custom-btn">
                                    <i class="fas fa-lock mr-2"></i>Login to Apply
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <!-- Company manage applications link -->
                <c:if test="${isCompany and not empty user and (user.userId == event.companyId)}">
                    <div class="mb-4">
                        <a href="<c:url value='/vendor/workhand-requests/${event.eventId}' />" class="custom-btn mr-2">
                            <i class="fas fa-users mr-2"></i>Manage Applications
                        </a>
                        <a href="<c:url value='/vendor/event/${event.eventId}/edit' />" class="custom-btn">
                            <i class="fas fa-edit mr-1"></i>Edit Event
                        </a>
                    </div>
                </c:if>

                <!-- Workhand Feedback list -->
                <div class="card mb-4 shadow-sm">
                    <div class="card-header" style="background:#f8f9fa; border-bottom:2px solid #f0a500;">
                        <h5 class="mb-0 font-weight-bold">Workhand Feedback</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty workhnadFeedbacks}">
                                <p class="text-muted mb-0">No feedback yet for this event.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="fb" items="${workhnadFeedbacks}">
                                    <div style="border-bottom:1px solid #eee; padding-bottom:12px; margin-bottom:12px;">
                                        <strong>${fb.workhand.name}</strong>
                                        <span class="badge badge-secondary ml-2">${fb.workhand.role.roleName}</span>
                                        <small class="text-muted ml-2">${fb.feedbackDate}</small>
                                        <p class="mt-1 mb-0">${fb.feedback}</p>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Feedback form: approved workhands who haven't given feedback -->
                <c:if test="${not isCompany and not empty approvedForFeedback and empty alreadyFeedback}">
                    <div class="card shadow-sm">
                        <div class="card-header" style="background:#f8f9fa; border-bottom:2px solid #f0a500;">
                            <h5 class="mb-0 font-weight-bold">Leave Your Feedback</h5>
                        </div>
                        <div class="card-body">
                            <form action="<c:url value='/feedback' />" method="POST">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <input type="hidden" name="workhand_id" value="${currentUser.userId}">
                                <input type="hidden" name="event_id"    value="${event.eventId}">
                                <div class="form-group">
                                    <label>Your Feedback</label>
                                    <textarea class="form-control" name="feedback" rows="4"
                                              placeholder="Share your experience..." required></textarea>
                                </div>
                                <button type="submit" class="custom-btn">
                                    <i class="fas fa-paper-plane mr-2"></i>Submit Feedback
                                </button>
                            </form>
                        </div>
                    </div>
                </c:if>

            </div>

            <!-- Right: sidebar -->
            <div class="col-lg-4">

                <div class="card shadow-sm mb-3">
                    <div class="card-header" style="background:#f8f9fa; border-bottom:2px solid #f0a500;">
                        <h6 class="mb-0 font-weight-bold">Organizer</h6>
                    </div>
                    <div class="card-body">
                        <h5 class="font-weight-bold">${event.company.name}</h5>
                        <ul class="list-unstyled text-muted small mb-0">
                            <li class="mb-1"><i class="fas fa-phone mr-2"></i>${event.company.contactNumber}</li>
                            <li class="mb-1"><i class="fas fa-envelope mr-2"></i>${event.company.email}</li>
                            <li class="mb-1"><i class="fas fa-map-marker-alt mr-2"></i>${event.company.city.cityName}, ${event.company.state.stateName}</li>
                        </ul>
                        <c:if test="${not empty event.company.companyDescription}">
                            <p class="text-muted small mt-2 mb-0">${event.company.companyDescription}</p>
                        </c:if>
                    </div>
                </div>

                <div class="card shadow-sm mb-3">
                    <div class="card-header" style="background:#f8f9fa; border-bottom:2px solid #f0a500;">
                        <h6 class="mb-0 font-weight-bold">Event Details</h6>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled small mb-0">
                            <li class="mb-2">
                                <i class="fas fa-tag mr-2" style="color:#f0a500;"></i>
                                ${event.eventSubcategory.eventSubcategoryName}
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-users mr-2" style="color:#f0a500;"></i>
                                Total Positions: <strong>${event.totalWorkhand}</strong>
                            </li>
                            <li>
                                <i class="fas fa-rupee-sign mr-2" style="color:#f0a500;"></i>
                                Total Budget: <strong>&#8377;<fmt:formatNumber value="${event.totalPrice}" maxFractionDigits="0"/></strong>
                            </li>
                        </ul>
                    </div>
                </div>

                <a href="<c:url value='/event' />" class="custom-btn d-block text-center" style="padding:10px 0; font-size:0.88rem;">
                    <i class="fas fa-arrow-left mr-2"></i>Back to Events
                </a>

            </div>

        </div>

    </div>
</section>
