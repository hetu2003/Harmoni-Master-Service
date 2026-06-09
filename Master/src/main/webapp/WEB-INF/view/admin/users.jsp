<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Harmoni Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f4f6fb; }
        .sidebar { min-height: 100vh; background: #1a1d2e; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 8px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: #0d6efd22; color: #fff; }
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt fa-fw me-2"></i>Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users fa-fw me-2"></i>Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/events">
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

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold mb-0">User Management</h4>
            <span class="text-muted small">${users.totalElements} total users</span>
        </div>

        <!-- Filters -->
        <div class="card shadow-sm border-0 mb-3">
            <div class="card-body py-2">
                <form method="GET" action="${pageContext.request.contextPath}/admin/users"
                      class="row g-2 align-items-center">
                    <div class="col-auto">
                        <select name="role" class="form-select form-select-sm">
                            <option value="ALL"      ${selectedRole == 'ALL'      ? 'selected' : ''}>All Roles</option>
                            <option value="ADMIN"    ${selectedRole == 'ADMIN'    ? 'selected' : ''}>Admin</option>
                            <option value="COMPANY"  ${selectedRole == 'COMPANY'  ? 'selected' : ''}>Company</option>
                            <option value="WORKHAND" ${selectedRole == 'WORKHAND' ? 'selected' : ''}>Workhand</option>
                        </select>
                    </div>
                    <div class="col">
                        <input type="text" name="search" class="form-control form-control-sm"
                               placeholder="Search by name..." value="${search}">
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary btn-sm">
                            <i class="fas fa-search me-1"></i>Filter
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary btn-sm ms-1">
                            Reset
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Users table -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Location</th>
                                <th class="text-center">Status</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty users.content}">
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">
                                            No users found.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="user" items="${users.content}" varStatus="loop">
                                        <tr>
                                            <td class="text-muted small">${loop.index + 1}</td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <c:choose>
                                                        <c:when test="${not empty user.profilePath}">
                                                            <img src="${pageContext.request.contextPath}/${user.profilePath}"
                                                                 class="rounded-circle" width="32" height="32"
                                                                 style="object-fit:cover;" alt="${user.name}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="rounded-circle bg-secondary d-flex align-items-center
                                                                        justify-content-center text-white"
                                                                 style="width:32px;height:32px;font-size:.8rem;">
                                                                <i class="fas fa-user"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <span class="fw-semibold">${user.name}</span>
                                                </div>
                                            </td>
                                            <td class="text-muted small">@${user.username}</td>
                                            <td class="small">${user.email}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.role.roleName == 'ADMIN'}">
                                                        <span class="badge bg-danger">Admin</span>
                                                    </c:when>
                                                    <c:when test="${user.role.roleName == 'COMPANY'}">
                                                        <span class="badge bg-primary">Company</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-info text-dark">Workhand</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="small text-muted">
                                                <c:if test="${user.city != null}">${user.city.cityName},&nbsp;</c:if>
                                                <c:if test="${user.state != null}">${user.state.stateName}</c:if>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${user.isActive == 1}">
                                                        <span class="badge bg-success">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Inactive</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <form action="${pageContext.request.contextPath}/admin/users/${user.userId}/toggle"
                                                      method="POST" class="d-inline">
                                                    <c:choose>
                                                        <c:when test="${user.isActive == 1}">
                                                            <button type="submit" class="btn btn-sm btn-outline-danger"
                                                                    onclick="return confirm('Deactivate ${user.name}?')">
                                                                <i class="fas fa-ban"></i>
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="submit" class="btn btn-sm btn-outline-success"
                                                                    onclick="return confirm('Activate ${user.name}?')">
                                                                <i class="fas fa-check"></i>
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>
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

        <!-- Pagination -->
        <c:if test="${users.totalPages > 1}">
            <nav class="mt-3" aria-label="User pagination">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${users.first ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?page=${users.number - 1}&role=${selectedRole}&search=${search}">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>
                    <c:forEach var="pg" items="${totalPageList}">
                        <li class="page-item ${pg == currentPage ? 'active' : ''}">
                            <a class="page-link"
                               href="?page=${pg - 1}&role=${selectedRole}&search=${search}">${pg}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${users.last ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?page=${users.number + 1}&role=${selectedRole}&search=${search}">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
