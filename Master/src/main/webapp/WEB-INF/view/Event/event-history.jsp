<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event History - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="fas fa-calendar-star me-2"></i>Harmoni
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/vendor/my-events">My Events</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/vendor/event-history">History</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Header -->
<section class="py-3 bg-dark text-white">
    <div class="container">
        <h4 class="mb-0"><i class="fas fa-history me-2"></i>Event <strong>History</strong></h4>
        <small class="text-white-50">All events with registration and payment summary</small>
    </div>
</section>

<div class="container my-5">

    <!-- Flash messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty rows}">
            <div class="text-center py-5 text-muted">
                <i class="fas fa-calendar-times fa-3x mb-3 d-block"></i>
                <h5>No events yet</h5>
                <a href="${pageContext.request.contextPath}/vendor/event/add" class="btn btn-primary mt-2">
                    <i class="fas fa-plus me-2"></i>Add Your First Event
                </a>
            </div>
        </c:when>
        <c:otherwise>

            <!-- Summary totals -->
            <c:set var="sumTotal"    value="0" />
            <c:set var="sumApproved" value="0" />
            <c:set var="sumPaid"     value="0" />
            <c:forEach var="row" items="${rows}">
                <c:set var="sumTotal"    value="${sumTotal    + row.total}"    />
                <c:set var="sumApproved" value="${sumApproved + row.approved}" />
                <c:set var="sumPaid"     value="${sumPaid     + row.paid}"     />
            </c:forEach>

            <div class="row g-3 mb-4">
                <div class="col-md-3 col-6">
                    <div class="card border-0 bg-dark text-white text-center p-3">
                        <h4 class="fw-bold">${rows.size()}</h4>
                        <small>Total Events</small>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="card border-0 bg-info text-white text-center p-3">
                        <h4 class="fw-bold">${sumTotal}</h4>
                        <small>Total Applications</small>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="card border-0 bg-success text-white text-center p-3">
                        <h4 class="fw-bold">${sumApproved}</h4>
                        <small>Approved Workhands</small>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="card border-0 bg-warning text-dark text-center p-3">
                        <h4 class="fw-bold">${sumPaid}</h4>
                        <small>Payments Done</small>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Event Name</th>
                                    <th>Category</th>
                                    <th>Date</th>
                                    <th>Location</th>
                                    <th class="text-center">Applications</th>
                                    <th class="text-center">Approved</th>
                                    <th class="text-center">Paid</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${rows}" varStatus="loop">
                                    <tr>
                                        <td class="text-muted small">${loop.index + 1}</td>
                                        <td>
                                            <span class="fw-semibold">${row.event.eventName}</span>
                                            <br>
                                            <small class="text-muted">ID #${row.event.eventId}</small>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary">${row.event.eventCategory.eventCategoryName}</span>
                                            <br>
                                            <small>${row.event.eventSubcategory.eventSubcategoryName}</small>
                                        </td>
                                        <td class="small text-muted">
                                            ${row.event.startDatetime}<br>
                                            <span class="text-muted">→ ${row.event.endDatetime}</span>
                                        </td>
                                        <td class="small text-muted">
                                            ${row.event.city.cityName}, ${row.event.state.stateName}
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-info text-dark fs-6">${row.total}</span>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-success fs-6">${row.approved}</span>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-warning text-dark fs-6">${row.paid}</span>
                                        </td>
                                        <td>
                                            <div class="d-flex flex-column gap-1">
                                                <a href="${pageContext.request.contextPath}/vendor/workhand-requests/${row.event.eventId}"
                                                   class="btn btn-sm btn-outline-primary">
                                                    <i class="fas fa-users me-1"></i>Requests
                                                </a>
                                                <a href="${pageContext.request.contextPath}/vendor/payment/${row.event.eventId}"
                                                   class="btn btn-sm btn-outline-warning">
                                                    <i class="fas fa-credit-card me-1"></i>Payments
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </c:otherwise>
    </c:choose>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
