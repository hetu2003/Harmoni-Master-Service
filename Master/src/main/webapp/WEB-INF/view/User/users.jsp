<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Harmoni Admin</title>
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
        @media(max-width:768px) { .sidebar { display:none; } .main-content { margin-left:0; } }
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
           class="d-flex align-items-center gap-2 rounded p-2 mb-1">
            <i class="fas fa-tachometer-alt fa-fw"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/users"
           class="d-flex align-items-center gap-2 rounded p-2 mb-1 active">
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

<!-- Main -->
<div class="main-content p-4">

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <h4 class="fw-bold mb-4"><i class="fas fa-users me-2"></i>Manage Users</h4>

    <!-- Filters -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body p-3">
            <form action="${pageContext.request.contextPath}/admin/users" method="GET"
                  class="row g-2 align-items-end">
                <div class="col-md-4">
                    <input type="text" class="form-control" name="search"
                           value="${search}" placeholder="Search by name...">
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="role">
                        <option value="ALL" ${selectedRole == 'ALL' ? 'selected' : ''}>All Roles</option>
                        <option value="WORKHAND" ${selectedRole == 'WORKHAND' ? 'selected' : ''}>Workhand</option>
                        <option value="COMPANY"  ${selectedRole == 'COMPANY'  ? 'selected' : ''}>Company</option>
                        <option value="ADMIN"    ${selectedRole == 'ADMIN'    ? 'selected' : ''}>Admin</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-dark w-100" type="submit">
                        <i class="fas fa-search me-1"></i>Filter
                    </button>
                </div>
                <div class="col-md-2">
                    <a href="${pageContext.request.contextPath}/admin/users"
                       class="btn btn-outline-secondary w-100">Reset</a>
                </div>
            </form>
        </div>
    </div>

    <!-- User Table -->
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Location</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty users or users.totalElements == 0}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-5">No users found</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="u" items="${users}" varStatus="loop">
                                    <tr class="${u.isActive == 0 ? 'table-secondary' : ''}">
                                        <td class="text-muted small">
                                            ${(currentPage - 1) * 10 + loop.index + 1}
                                        </td>
                                        <td>
                                            <span class="fw-semibold">${u.name}</span>
                                        </td>
                                        <td class="small text-muted">@${u.username}</td>
                                        <td class="small">${u.email}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.role.roleName == 'WORKHAND'}">
                                                    <span class="badge bg-info text-dark">Workhand</span>
                                                </c:when>
                                                <c:when test="${u.role.roleName == 'COMPANY'}">
                                                    <span class="badge bg-primary">Company</span>
                                                </c:when>
                                                <c:when test="${u.role.roleName == 'ADMIN'}">
                                                    <span class="badge bg-danger">Admin</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${u.role.roleName}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="small text-muted">
                                            <c:if test="${u.city != null}">${u.city.cityName}, </c:if>
                                            <c:if test="${u.state != null}">${u.state.stateName}</c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.isActive == 1 or u.isActive == null}">
                                                    <span class="badge bg-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/users/${u.userId}/toggle"
                                                  method="POST" class="d-inline">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                <button type="submit"
                                                        class="btn btn-sm ${u.isActive == 1 ? 'btn-outline-danger' : 'btn-outline-success'}"
                                                        onclick="return confirm('Toggle status for ${u.name}?')">
                                                    <c:choose>
                                                        <c:when test="${u.isActive == 1}">
                                                            <i class="fas fa-ban me-1"></i>Deactivate
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-check me-1"></i>Activate
                                                        </c:otherwise>
                                                    </c:choose>
                                                </button>
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
    <c:if test="${not empty totalPageList and totalPageList.size() > 1}">
        <nav class="mt-4 d-flex justify-content-center">
            <ul class="pagination">
                <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
                    <a class="page-link"
                       href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 2}&role=${selectedRole}<c:if test='${not empty search}'>&search=${search}</c:if>">
                        &laquo;
                    </a>
                </li>
                <c:forEach var="pg" items="${totalPageList}">
                    <li class="page-item <c:if test='${pg == currentPage}'>active</c:if>">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/admin/users?page=${pg - 1}&role=${selectedRole}<c:if test='${not empty search}'>&search=${search}</c:if>">
                            ${pg}
                        </a>
                    </li>
                </c:forEach>
                <li class="page-item <c:if test='${currentPage == totalPageList.size()}'>disabled</c:if>">
                    <a class="page-link"
                       href="${pageContext.request.contextPath}/admin/users?page=${currentPage}&role=${selectedRole}<c:if test='${not empty search}'>&search=${search}</c:if>">
                        &raquo;
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    setTimeout(function() {
        document.querySelectorAll('.alert').forEach(function(a) { a.classList.remove('show'); });
    }, 4000);
</script>
</body>
</html>
