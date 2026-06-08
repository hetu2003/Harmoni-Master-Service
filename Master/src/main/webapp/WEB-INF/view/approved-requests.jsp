<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Approved Requests - ${event.eventName}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <section class="py-3 bg-dark text-white">
        <div class="container">
            <h4 class="mb-1">Approved <strong>Requests</strong></h4>
            <small class="text-muted">${event.eventName} &mdash; Event #${event.eventId}</small>
        </div>
    </section>

    <div class="container my-4">

        <div class="d-flex gap-2 mb-4 flex-wrap">
            <a href="${pageContext.request.contextPath}/vendor/workhand-requests/${event.eventId}"
               class="btn btn-outline-primary">
                <i class="fas fa-clock me-1"></i>Pending
            </a>
            <a href="${pageContext.request.contextPath}/vendor/approved-requests/${event.eventId}"
               class="btn btn-success">
                <i class="fas fa-check me-1"></i>Approved
            </a>
            <a href="${pageContext.request.contextPath}/vendor/payment/${event.eventId}"
               class="btn btn-outline-warning">
                <i class="fas fa-credit-card me-1"></i>Payment
            </a>
        </div>

        <c:choose>
            <c:when test="${empty approvedRequests}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>No approved workhands for this event yet.
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-success">
                            <tr>
                                <th>#</th>
                                <th>Workhand</th>
                                <th>Category Slot</th>
                                <th>Price</th>
                                <th>Payment</th>
                                <th>Rating</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="req" items="${approvedRequests}" varStatus="loop">
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
                                    <td>
                                        <c:choose>
                                            <c:when test="${req.paymentStatus}">
                                                <span class="badge bg-success">Paid</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Unpaid</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${req.rating != null and req.rating > 0}">
                                                <span class="text-warning">
                                                    <c:forEach begin="1" end="${req.rating}">&#9733;</c:forEach>
                                                </span>
                                                <small>(${req.rating}/5)</small>
                                            </c:when>
                                            <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/vendor/approved-requests/${event.eventId}/revoke"
                                              method="POST" class="d-inline"
                                              onsubmit="return confirm('Revoke this workhand\'s approval?')">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                            <input type="hidden" name="registrationId" value="${req.registrationId}">
                                            <button type="submit" class="btn btn-sm btn-danger">
                                                <i class="fas fa-times me-1"></i>Revoke
                                            </button>
                                        </form>
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
