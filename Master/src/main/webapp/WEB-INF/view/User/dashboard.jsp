<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f4f6f9; }
        .sidebar {
            min-height: 100vh; background: #1a1a2e;
            position: fixed; top: 0; left: 0; width: 220px; z-index: 1000;
        }
        .sidebar a { color: #ced4da; text-decoration: none; }
        .sidebar a:hover, .sidebar a.active { color: #fff; background: rgba(255,255,255,.1); }
        .main-content { margin-left: 220px; }
        .stat-card { border-left: 4px solid; }
        @media(max-width:768px) {
            .sidebar { display: none; }
            .main-content { margin-left: 0; }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar p-3 d-flex flex-column">
    <div class="text-white fw-bold fs-5 mb-4 pb-3 border-bottom border-secondary">
        <i class="fas fa-shield-alt me-2 text-warning"></i>Harmoni Admin
    </div>
    <nav class="flex-grow-1">
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="d-flex align-items-center gap-2 rounded p-2 mb-1 active">
            <i class="fas fa-tachometer-alt fa-fw"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/users"
           class="d-flex align-items-center gap-2 rounded p-2 mb-1">
            <i class="fas fa-users fa-fw"></i> Users
        </a>
        <a href="${pageContext.request.contextPath}/event"
           class="d-flex align-items-center gap-2 rounded p-2 mb-1">
            <i class="fas fa-calendar fa-fw"></i> All Events
        </a>
    </nav>
    <div class="border-top border-secondary pt-3">
        <a href="${pageContext.request.contextPath}/logout"
           class="d-flex align-items-center gap-2 rounded p-2 text-danger">
            <i class="fas fa-sign-out-alt fa-fw"></i> Logout
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="main-content p-4">

    <!-- Flash messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show">
            ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <h4 class="fw-bold mb-4">Dashboard Overview</h4>

    <!-- Stats Cards -->
    <div class="row g-3 mb-5">
        <div class="col-md-4 col-xl-2">
            <div class="card stat-card border-left-primary shadow-sm h-100"
                 style="border-left-color:#0d6efd;">
                <div class="card-body text-center p-3">
                    <i class="fas fa-hard-hat fa-2x text-primary mb-2"></i>
                    <h3 class="fw-bold mb-0">${totalWorkhands}</h3>
                    <small class="text-muted">Workhands</small>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="border-left:4px solid #198754;">
                <div class="card-body text-center p-3">
                    <i class="fas fa-building fa-2x text-success mb-2"></i>
                    <h3 class="fw-bold mb-0">${totalCompanies}</h3>
                    <small class="text-muted">Companies</small>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="border-left:4px solid #6f42c1;">
                <div class="card-body text-center p-3">
                    <i class="fas fa-calendar-check fa-2x text-purple mb-2" style="color:#6f42c1;"></i>
                    <h3 class="fw-bold mb-0">${totalEvents}</h3>
                    <small class="text-muted">Total Events</small>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="border-left:4px solid #0dcaf0;">
                <div class="card-body text-center p-3">
                    <i class="fas fa-clipboard-list fa-2x text-info mb-2"></i>
                    <h3 class="fw-bold mb-0">${totalRegs}</h3>
                    <small class="text-muted">Registrations</small>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="border-left:4px solid #ffc107;">
                <div class="card-body text-center p-3">
                    <i class="fas fa-user-check fa-2x text-warning mb-2"></i>
                    <h3 class="fw-bold mb-0">${approvedRegs}</h3>
                    <small class="text-muted">Approved</small>
                </div>
            </div>
        </div>
        <div class="col-md-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="border-left:4px solid #20c997;">
                <div class="card-body text-center p-3">
                    <i class="fas fa-credit-card fa-2x text-teal mb-2" style="color:#20c997;"></i>
                    <h3 class="fw-bold mb-0">${paidRegs}</h3>
                    <small class="text-muted">Paid</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">

        <!-- Recent Registrations -->
        <div class="col-lg-7">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                    <h6 class="fw-bold mb-0"><i class="fas fa-clock me-2 text-primary"></i>Recent Registrations</h6>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle small">
                            <thead class="table-light">
                                <tr>
                                    <th>Workhand</th>
                                    <th>Event</th>
                                    <th>Status</th>
                                    <th>Payment</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty recentRegs}">
                                        <tr><td colspan="4" class="text-center text-muted py-4">No registrations yet</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="reg" items="${recentRegs}">
                                            <tr>
                                                <td>
                                                    <span class="fw-semibold">${reg.workhand.name}</span><br>
                                                    <small class="text-muted">${reg.workhand.email}</small>
                                                </td>
                                                <td>
                                                    <span>${reg.event.eventName}</span><br>
                                                    <small class="text-muted">${reg.event.company.name}</small>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${reg.registrationStatus}">
                                                            <span class="badge bg-success">Approved</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning text-dark">Pending</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${reg.paymentStatus}">
                                                            <span class="badge bg-success">Paid</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">Unpaid</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Events -->
        <div class="col-lg-5">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                    <h6 class="fw-bold mb-0"><i class="fas fa-calendar me-2 text-success"></i>Recent Events</h6>
                    <a href="${pageContext.request.contextPath}/event" class="btn btn-sm btn-outline-secondary">
                        View All
                    </a>
                </div>
                <div class="card-body p-0">
                    <ul class="list-group list-group-flush">
                        <c:choose>
                            <c:when test="${empty recentEvents}">
                                <li class="list-group-item text-center text-muted py-4">No events yet</li>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="ev" items="${recentEvents}">
                                    <li class="list-group-item border-0 py-2">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <span class="fw-semibold small">${ev.eventName}</span><br>
                                                <small class="text-muted">${ev.company.name} &bull; ${ev.city.cityName}</small>
                                            </div>
                                            <span class="badge bg-primary ms-2">${ev.eventCategory.eventCategoryName}</span>
                                        </div>
                                    </li>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>

    </div>

    <!-- Quick Actions -->
    <div class="mt-4">
        <h6 class="fw-bold mb-3">Quick Actions</h6>
        <div class="d-flex gap-2 flex-wrap">
            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-dark">
                <i class="fas fa-users me-2"></i>Manage Users
            </a>
            <a href="${pageContext.request.contextPath}/event" class="btn btn-outline-dark">
                <i class="fas fa-calendar me-2"></i>Browse Events
            </a>
            <a href="${pageContext.request.contextPath}/company" class="btn btn-outline-dark">
                <i class="fas fa-building me-2"></i>View Companies
            </a>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    /* Auto-dismiss flash alerts */
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(a) { a.classList.remove('show'); });
    }, 4000);
</script>
</body>
</html>
