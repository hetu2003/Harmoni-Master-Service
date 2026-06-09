<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${event.eventName} - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show m-3">
            <i class="fas fa-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Breadcrumb -->
    <section class="py-3 bg-dark text-white">
        <div class="container">
            <nav><ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/home" class="text-light">Home</a>
                </li>
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/event" class="text-light">Events</a>
                </li>
                <li class="breadcrumb-item active text-warning">${event.eventName}</li>
            </ol></nav>
        </div>
    </section>

    <div class="container my-5">
        <div class="row g-4">

            <%-- ── Left: Event details ── --%>
            <div class="col-lg-8">

                <h2 class="fw-bold">${event.eventName}</h2>

                <p class="text-muted mb-1">
                    <i class="fas fa-calendar me-1 text-primary"></i>
                    ${event.startDatetime} &mdash; ${event.endDatetime}
                </p>
                <p class="text-muted mb-3">
                    <i class="fas fa-map-marker-alt me-1 text-danger"></i>
                    ${event.streetAddress}, ${event.city.cityName}, ${event.state.stateName}
                </p>

                <!-- Description -->
                <div class="card mb-4 shadow-sm">
                    <div class="card-header"><h5 class="mb-0">About This Event</h5></div>
                    <div class="card-body">${event.description}</div>
                </div>

                <%-- Register button (workhand only, if not yet registered) --%>
                <c:if test="${not isCompany}">
                    <c:choose>
                        <c:when test="${not empty alreadyRegistered}">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>
                                You are already registered for this event.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/event-register/${event.eventId}"
                               class="btn btn-primary mb-4">
                                <i class="fas fa-pen me-2"></i>Register for This Event
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:if>

                <!-- Workhand Feedback list -->
                <div class="card mb-4 shadow-sm">
                    <div class="card-header"><h5 class="mb-0">Workhand Feedback</h5></div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty workhnadFeedbacks}">
                                <p class="text-muted mb-0">No feedback yet for this event.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="fb" items="${workhnadFeedbacks}">
                                    <div class="border-bottom pb-3 mb-3">
                                        <strong>${fb.workhand.name}</strong>
                                        <span class="badge bg-secondary ms-2">${fb.workhand.role.roleName}</span>
                                        <small class="text-muted ms-2">${fb.feedbackDate}</small>
                                        <p class="mt-1 mb-0">${fb.feedback}</p>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <%-- Feedback form: only for approved workhands who haven't already given feedback --%>
                <c:if test="${not isCompany and not empty approvedForFeedback and empty alreadyFeedback}">
                    <div class="card shadow-sm">
                        <div class="card-header"><h5 class="mb-0">Leave Your Feedback</h5></div>
                        <div class="card-body">
                            <form id="feedbackForm"
                                  action="${pageContext.request.contextPath}/feedback"
                                  method="POST">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <input type="hidden" name="workhand_id" value="${currentUser.userId}">
                                <input type="hidden" name="event_id"    value="${event.eventId}">
                                <div class="mb-3">
                                    <label class="form-label">Your Feedback</label>
                                    <textarea class="form-control" name="feedback" rows="4"
                                              placeholder="Share your experience..." required></textarea>
                                    <div class="invalid-feedback">Please write your feedback.</div>
                                </div>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-paper-plane me-2"></i>Submit Feedback
                                </button>
                            </form>
                        </div>
                    </div>
                </c:if>

            </div>

            <%-- ── Right: Sidebar ── --%>
            <div class="col-lg-4">

                <div class="card shadow-sm mb-3">
                    <div class="card-header"><h6 class="mb-0">Organizer</h6></div>
                    <div class="card-body">
                        <h5 class="fw-bold">${event.company.name}</h5>
                        <ul class="list-unstyled text-muted small">
                            <li><i class="fas fa-phone me-2"></i>${event.company.contactNumber}</li>
                            <li><i class="fas fa-envelope me-2"></i>${event.company.email}</li>
                            <li><i class="fas fa-map-marker-alt me-2"></i>
                                ${event.company.city.cityName}, ${event.company.state.stateName}
                            </li>
                        </ul>
                        <c:if test="${not empty event.company.companyDescription}">
                            <p class="text-muted small mb-0">${event.company.companyDescription}</p>
                        </c:if>
                    </div>
                </div>

                <div class="card shadow-sm">
                    <div class="card-header"><h6 class="mb-0">Event Details</h6></div>
                    <div class="card-body">
                        <ul class="list-unstyled small">
                            <li>
                                <i class="fas fa-tag me-2 text-primary"></i>
                                ${event.eventSubcategory.eventSubcategoryName}
                            </li>
                            <li class="mt-2">
                                <i class="fas fa-users me-2 text-primary"></i>
                                Total Seats: <strong>${event.totalWorkhand}</strong>
                            </li>
                            <li class="mt-2">
                                <i class="fas fa-rupee-sign me-2 text-primary"></i>
                                Total Budget:
                                <strong>&#8377;<fmt:formatNumber value="${event.totalPrice}" maxFractionDigits="0"/></strong>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/eventDetails.js"></script>
</body>
</html>
