<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f4f6fb; }
        .notif-card { border-left: 4px solid #dee2e6; transition: background .15s; }
        .notif-card.unread { border-left-color: #0d6efd; background: #f0f6ff; }
        .notif-icon { width: 42px; height: 42px; border-radius: 50%;
                      display: flex; align-items: center; justify-content: center; font-size: 1.1rem; flex-shrink: 0; }
        .notif-icon.REGISTRATION { background: #d1ecf1; color: #0c5460; }
        .notif-icon.APPROVAL      { background: #d4edda; color: #155724; }
        .notif-icon.REJECTION     { background: #f8d7da; color: #721c24; }
        .notif-icon.PAYMENT       { background: #fff3cd; color: #856404; }
        .notif-icon.INFO          { background: #e2e3e5; color: #383d41; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="fas fa-calendar-star me-2"></i>Harmoni
        </a>
        <div class="d-flex align-items-center gap-3">
            <a href="${pageContext.request.contextPath}/home" class="nav-link text-white">
                <i class="fas fa-home me-1"></i>Home
            </a>
        </div>
    </div>
</nav>

<div class="container my-4" style="max-width: 720px;">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-0">
                <i class="fas fa-bell me-2 text-primary"></i>Notifications
            </h4>
            <c:if test="${unreadCount > 0}">
                <small class="text-muted">${unreadCount} unread</small>
            </c:if>
        </div>
        <c:if test="${unreadCount > 0}">
            <form action="${pageContext.request.contextPath}/notifications/read-all" method="POST">
                <button type="submit" class="btn btn-sm btn-outline-primary">
                    <i class="fas fa-check-double me-1"></i>Mark all read
                </button>
            </form>
        </c:if>
    </div>

    <!-- Notification list -->
    <c:choose>
        <c:when test="${empty notifications}">
            <div class="text-center py-5 text-muted">
                <i class="fas fa-bell-slash fa-3x mb-3 d-block"></i>
                <h5>No notifications yet</h5>
                <p class="small">You'll be notified about registrations, approvals, and payments here.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="d-flex flex-column gap-2">
                <c:forEach var="n" items="${notifications}">
                    <div class="card border-0 shadow-sm notif-card ${n.read ? '' : 'unread'}">
                        <div class="card-body d-flex align-items-start gap-3 py-3">

                            <!-- Icon by type -->
                            <div class="notif-icon ${n.type}">
                                <c:choose>
                                    <c:when test="${n.type == 'REGISTRATION'}">
                                        <i class="fas fa-clipboard-list"></i>
                                    </c:when>
                                    <c:when test="${n.type == 'APPROVAL'}">
                                        <i class="fas fa-user-check"></i>
                                    </c:when>
                                    <c:when test="${n.type == 'REJECTION'}">
                                        <i class="fas fa-user-times"></i>
                                    </c:when>
                                    <c:when test="${n.type == 'PAYMENT'}">
                                        <i class="fas fa-credit-card"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-info-circle"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Message -->
                            <div class="flex-grow-1">
                                <p class="mb-1 ${n.read ? 'text-muted' : 'fw-semibold'}">${n.message}</p>
                                <small class="text-muted">
                                    <i class="fas fa-clock me-1"></i>${n.createdAt}
                                </small>
                            </div>

                            <!-- Actions -->
                            <div class="d-flex flex-column align-items-end gap-1">
                                <c:if test="${!n.read}">
                                    <form action="${pageContext.request.contextPath}/notifications/${n.notificationId}/read"
                                          method="POST">
                                        <button type="submit" class="btn btn-xs btn-outline-primary btn-sm"
                                                title="Mark as read">
                                            <i class="fas fa-check"></i>
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${n.eventId != null}">
                                    <a href="${pageContext.request.contextPath}/event-details/${n.eventId}"
                                       class="btn btn-xs btn-outline-secondary btn-sm"
                                       title="View event">
                                        <i class="fas fa-external-link-alt"></i>
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
