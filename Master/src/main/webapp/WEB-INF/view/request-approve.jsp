<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Workhand Requests - ${event.eventName}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show m-3">
            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <section class="py-3 bg-dark text-white">
        <div class="container">
            <h4 class="mb-1">Workhand <strong>Requests</strong></h4>
            <small class="text-muted">${event.eventName} &mdash; Event #${event.eventId}</small>
        </div>
    </section>

    <div class="container my-4">

        <%-- Tab navigation --%>
        <div class="d-flex gap-2 mb-4 flex-wrap">
            <a href="${pageContext.request.contextPath}/vendor/workhand-requests/${event.eventId}"
               class="btn btn-primary">
                <i class="fas fa-clock me-1"></i>Pending
            </a>
            <a href="${pageContext.request.contextPath}/vendor/approved-requests/${event.eventId}"
               class="btn btn-outline-success">
                <i class="fas fa-check me-1"></i>Approved
            </a>
            <a href="${pageContext.request.contextPath}/vendor/payment/${event.eventId}"
               class="btn btn-outline-warning">
                <i class="fas fa-credit-card me-1"></i>Payment
            </a>
        </div>

        <c:choose>
            <c:when test="${empty workhnadRequests}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>No pending requests for this event.
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Workhand</th>
                                <th>Category Slot</th>
                                <th>Price</th>
                                <th>Registered On</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="req" items="${workhnadRequests}" varStatus="loop">
                                <tr>
                                    <td class="text-muted small">${loop.index + 1}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/vendor/workhand-profile/${req.workhand.userId}"
                                           class="fw-semibold text-decoration-none">
                                            ${req.workhand.name}
                                        </a>
                                        <br>
                                        <small class="text-muted">${req.workhand.email}</small>
                                    </td>
                                    <td>Category #${req.eventWorkhand.workhnadCategoryId}</td>
                                    <td>&#8377;<fmt:formatNumber value="${req.eventWorkhand.price}" maxFractionDigits="0"/></td>
                                    <td>${req.registrationDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${req.registrationStatus}">
                                                <span class="badge bg-success">Approved</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark">Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${not req.registrationStatus}">
                                            <a href="${pageContext.request.contextPath}/vendor/request-approve?registrationId=${req.registrationId}"
                                               class="btn btn-sm btn-success"
                                               onclick="return confirm('Approve this workhand?')">
                                                <i class="fas fa-check me-1"></i>Approve
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
