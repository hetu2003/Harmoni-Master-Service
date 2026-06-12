<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Banner -->
<section style="background: linear-gradient(135deg, #1c1c2e 0%, #2d2d44 100%); padding: 40px 0;">
    <div class="container">
        <h4 class="white-color font-weight-bold mb-1">Rejected <strong>Applications</strong></h4>
        <p class="mb-0" style="color:#ccc;">${event.eventName} &mdash; Event #${event.eventId}</p>
    </div>
</section>

<div class="container mt-4">

    <!-- Capacity bar -->
    <div class="card mb-4 shadow-sm">
        <div class="card-body py-3">
            <div class="row text-center">
                <div class="col-md-3">
                    <div class="h4 font-weight-bold text-primary mb-0">${event.totalWorkhand}</div>
                    <small class="text-muted">Total Positions</small>
                </div>
                <div class="col-md-3">
                    <div class="h4 font-weight-bold text-success mb-0">${acceptedCount}</div>
                    <small class="text-muted">Accepted</small>
                </div>
                <div class="col-md-3">
                    <div class="h4 font-weight-bold text-warning mb-0">${pendingCount}</div>
                    <small class="text-muted">Pending</small>
                </div>
                <div class="col-md-3">
                    <div class="h4 font-weight-bold text-danger mb-0">${rejectedCount}</div>
                    <small class="text-muted">Rejected</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Tab nav -->
    <div class="d-flex mb-4" style="gap:8px; flex-wrap:wrap;">
        <a href="<c:url value='/vendor/workhand-requests/${event.eventId}' />"
           class="btn btn-outline-primary">
            <i class="fas fa-clock mr-1"></i>Pending
            <c:if test="${pendingCount > 0}">
                <span class="badge badge-primary ml-1">${pendingCount}</span>
            </c:if>
        </a>
        <a href="<c:url value='/vendor/approved-requests/${event.eventId}' />"
           class="btn btn-outline-success">
            <i class="fas fa-check mr-1"></i>Accepted
            <c:if test="${acceptedCount > 0}">
                <span class="badge badge-success ml-1">${acceptedCount}</span>
            </c:if>
        </a>
        <a href="<c:url value='/vendor/rejected-requests/${event.eventId}' />"
           class="btn btn-danger">
            <i class="fas fa-times mr-1"></i>Rejected
            <c:if test="${rejectedCount > 0}">
                <span class="badge badge-light ml-1">${rejectedCount}</span>
            </c:if>
        </a>
        <a href="<c:url value='/vendor/payment/${event.eventId}' />"
           class="btn btn-outline-warning ml-auto">
            <i class="fas fa-credit-card mr-1"></i>Payment
        </a>
    </div>

    <c:choose>
        <c:when test="${empty rejectedRequests}">
            <div class="alert alert-info">
                <i class="fas fa-info-circle mr-2"></i>No rejected applications for this event.
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-hover shadow-sm" style="background:#fff; border-radius:8px; overflow:hidden;">
                    <thead style="background:#dc3545; color:#fff;">
                        <tr>
                            <th>#</th>
                            <th>Applicant</th>
                            <th>Role Applied For</th>
                            <th>Pay</th>
                            <th>Applied On</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="req" items="${rejectedRequests}" varStatus="loop">
                            <tr>
                                <td class="text-muted small">${loop.index + 1}</td>
                                <td>
                                    <a href="<c:url value='/vendor/workhand-profile/${req.workhand.userId}' />"
                                       class="font-weight-bold text-decoration-none">
                                        ${req.workhand.name}
                                    </a>
                                    <br>
                                    <small class="text-muted">${req.workhand.email}</small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty req.eventWorkhand.workhnadCategory.workhnadCategoryName}">
                                            ${req.eventWorkhand.workhnadCategory.workhnadCategoryName}
                                        </c:when>
                                        <c:otherwise>Category #${req.eventWorkhand.workhnadCategoryId}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>&#8377;<fmt:formatNumber value="${req.eventWorkhand.price}" maxFractionDigits="0"/></td>
                                <td>${req.registrationDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>

</div>
