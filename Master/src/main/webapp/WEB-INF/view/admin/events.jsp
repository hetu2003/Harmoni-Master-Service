<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Management - Harmoni Admin</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users fa-fw me-2"></i>Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/events">
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
            <h4 class="fw-bold mb-0">Event Management</h4>
            <span class="text-muted small">${events.totalElements} total events</span>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Event Name</th>
                                <th>Company</th>
                                <th>Category</th>
                                <th>Date</th>
                                <th class="text-center">Featured</th>
                                <th class="text-center">Status</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty events.content}">
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">No events found.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="ev" items="${events.content}" varStatus="loop">
                                        <tr>
                                            <td class="text-muted small">${loop.index + 1}</td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <c:if test="${not empty ev.imagePath}">
                                                        <img src="${pageContext.request.contextPath}/${ev.imagePath}"
                                                             width="40" height="40" class="rounded"
                                                             style="object-fit:cover;" alt="">
                                                    </c:if>
                                                    <div>
                                                        <span class="fw-semibold">${ev.eventName}</span>
                                                        <br><small class="text-muted">ID #${ev.id}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="small text-muted">
                                                <c:if test="${ev.company != null}">${ev.company.name}</c:if>
                                            </td>
                                            <td>
                                                <c:if test="${ev.eventCategory != null}">
                                                    <span class="badge bg-primary">${ev.eventCategory.eventCategoryName}</span>
                                                </c:if>
                                            </td>
                                            <td class="small text-muted">${ev.startDatetime}</td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${ev.featured}">
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="fas fa-star me-1"></i>Featured
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-light text-muted">—</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${ev.isActive == 1}">
                                                        <span class="badge bg-success">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Inactive</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <form action="${pageContext.request.contextPath}/admin/events/${ev.id}/toggle-featured"
                                                      method="POST" class="d-inline">
                                                    <input type="hidden" name="from" value="events">
                                                    <button type="submit" class="btn btn-sm btn-outline-warning"
                                                            title="Toggle Featured">
                                                        <i class="fas fa-star"></i>
                                                    </button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/admin/events/${ev.id}/delete"
                                                      method="POST" class="d-inline"
                                                      onsubmit="return confirm('Permanently delete this event?')">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger"
                                                            title="Delete Event">
                                                        <i class="fas fa-trash"></i>
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
        <c:if test="${events.totalPages > 1}">
            <nav class="mt-3" aria-label="Events pagination">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${events.first ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${events.number - 1}">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>
                    <c:forEach var="pg" items="${totalPageList}">
                        <li class="page-item ${pg == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${pg - 1}">${pg}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${events.last ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${events.number + 1}">
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
