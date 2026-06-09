<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f4f6fb; }
        .sidebar { min-height: 100vh; background: #1a1d2e; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 8px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: #0d6efd22; color: #fff; }
        .stat-card { border: none; border-radius: 12px; }
    </style>
</head>
<body>
<div class="d-flex">

    <!-- Sidebar -->
    <div class="sidebar d-flex flex-column p-3" style="width:230px; min-width:230px;">
        <a class="text-white text-decoration-none mb-4 d-block" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="fas fa-calendar-star me-2 text-primary"></i><strong>Harmoni Admin</strong>
        </a>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${active == 'dashboard' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt fa-fw me-2"></i>Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${active == 'users' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users fa-fw me-2"></i>Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${active == 'events' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/events">
                    <i class="fas fa-calendar-alt fa-fw me-2"></i>Events
                </a>
            </li>
        </ul>
        <div class="mt-auto">
            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt fa-fw me-2"></i>Logout
            </a>
        </div>
    </div>

    <!-- Main content -->
    <div class="flex-grow-1 p-4">

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show">
                ${successMessage} <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${errorMessage} <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <h4 class="fw-bold mb-4">Dashboard Overview</h4>

        <!-- Stat cards -->
        <div class="row g-3 mb-4">
            <div class="col-xl-2 col-md-4 col-6">
                <div class="card stat-card shadow-sm text-center p-3 bg-primary text-white">
                    <i class="fas fa-user-tie fa-2x mb-2"></i>
                    <h3 class="fw-bold mb-0">${totalCompanies}</h3>
                    <small>Companies</small>
                </div>
            </div>
            <div class="col-xl-2 col-md-4 col-6">
                <div class="card stat-card shadow-sm text-center p-3 bg-info text-white">
                    <i class="fas fa-hard-hat fa-2x mb-2"></i>
                    <h3 class="fw-bold mb-0">${totalWorkhands}</h3>
                    <small>Workhands</small>
                </div>
            </div>
            <div class="col-xl-2 col-md-4 col-6">
                <div class="card stat-card shadow-sm text-center p-3 bg-success text-white">
                    <i class="fas fa-calendar-check fa-2x mb-2"></i>
                    <h3 class="fw-bold mb-0">${totalEvents}</h3>
                    <small>Events</small>
                </div>
            </div>
            <div class="col-xl-2 col-md-4 col-6">
                <div class="card stat-card shadow-sm text-center p-3 bg-secondary text-white">
                    <i class="fas fa-clipboard-list fa-2x mb-2"></i>
                    <h3 class="fw-bold mb-0">${totalRegs}</h3>
                    <small>Registrations</small>
                </div>
            </div>
            <div class="col-xl-2 col-md-4 col-6">
                <div class="card stat-card shadow-sm text-center p-3 bg-warning text-dark">
                    <i class="fas fa-user-check fa-2x mb-2"></i>
                    <h3 class="fw-bold mb-0">${approvedRegs}</h3>
                    <small>Approved</small>
                </div>
            </div>
            <div class="col-xl-2 col-md-4 col-6">
                <div class="card stat-card shadow-sm text-center p-3 bg-dark text-white">
                    <i class="fas fa-credit-card fa-2x mb-2"></i>
                    <h3 class="fw-bold mb-0">${paidRegs}</h3>
                    <small>Paid</small>
                </div>
            </div>
        </div>

        <div class="row g-4">

            <!-- Recent Events -->
            <div class="col-lg-6">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white fw-semibold d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-calendar me-2 text-primary"></i>Recent Events</span>
                        <a href="${pageContext.request.contextPath}/admin/events" class="btn btn-sm btn-outline-primary">View All</a>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 small">
                                <thead class="table-light">
                                    <tr><th>Event</th><th>Company</th><th class="text-center">Featured</th><th>Actions</th></tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="ev" items="${recentEvents}">
                                        <tr>
                                            <td>
                                                <span class="fw-semibold text-truncate d-inline-block" style="max-width:140px;"
                                                      title="${ev.eventName}">${ev.eventName}</span>
                                            </td>
                                            <td class="text-muted">
                                                <c:if test="${ev.company != null}">${ev.company.name}</c:if>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${ev.featured}">
                                                        <span class="badge bg-warning text-dark"><i class="fas fa-star me-1"></i>Featured</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-light text-muted">—</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/admin/events/${ev.id}/toggle-featured"
                                                      method="POST" class="d-inline">
                                                    <input type="hidden" name="from" value="dashboard">
                                                    <button class="btn btn-xs btn-outline-warning btn-sm">
                                                        <i class="fas fa-star"></i>
                                                    </button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/admin/events/${ev.id}/delete"
                                                      method="POST" class="d-inline"
                                                      onsubmit="return confirm('Delete this event?')">
                                                    <button class="btn btn-xs btn-outline-danger btn-sm">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Registrations -->
            <div class="col-lg-6">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white fw-semibold d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-clipboard-list me-2 text-success"></i>Recent Registrations</span>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-outline-success">Users</a>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 small">
                                <thead class="table-light">
                                    <tr><th>#ID</th><th>Status</th><th>Payment</th><th>Date</th></tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="reg" items="${recentRegs}">
                                        <tr>
                                            <td class="text-muted">#${reg.registrationId}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${reg.registrationStatus}">
                                                        <span class="badge bg-success">Approved</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Pending</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${reg.paymentStatus}">
                                                        <span class="badge bg-warning text-dark">Paid</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-light text-muted">Unpaid</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-muted">${reg.registrationDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
