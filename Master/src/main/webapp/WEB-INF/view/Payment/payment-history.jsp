<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Payments - Harmoni</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event">Events</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/history">History</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/payment-history">Payments</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Header -->
<section class="py-3 bg-dark text-white">
    <div class="container">
        <h4 class="mb-0"><i class="fas fa-wallet me-2"></i>My <strong>Payment History</strong></h4>
    </div>
</section>

<div class="container my-5">

    <!-- Summary Stats -->
    <div class="row g-3 mb-5">
        <div class="col-md-3 col-6">
            <div class="card border-0 bg-success text-white text-center p-3 shadow-sm">
                <i class="fas fa-check-circle fa-2x mb-2 opacity-75"></i>
                <h4 class="fw-bold mb-0">${paidCount}</h4>
                <small>Paid</small>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="card border-0 bg-warning text-dark text-center p-3 shadow-sm">
                <i class="fas fa-clock fa-2x mb-2 opacity-75"></i>
                <h4 class="fw-bold mb-0">${unpaidCount}</h4>
                <small>Pending</small>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="card border-0 bg-primary text-white text-center p-3 shadow-sm">
                <i class="fas fa-rupee-sign fa-2x mb-2 opacity-75"></i>
                <h4 class="fw-bold mb-0">${totalEarned}</h4>
                <small>Total Earned</small>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="card border-0 bg-secondary text-white text-center p-3 shadow-sm">
                <i class="fas fa-hourglass-half fa-2x mb-2 opacity-75"></i>
                <h4 class="fw-bold mb-0">${totalPending}</h4>
                <small>Pending Amount</small>
            </div>
        </div>
    </div>

    <!-- Payment Table -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-semibold">Approved Registrations</h5>
            <div class="d-flex gap-2">
                <button class="btn btn-sm btn-outline-success active" id="filterAll"
                        onclick="filterTable('all')">All</button>
                <button class="btn btn-sm btn-outline-success" id="filterPaid"
                        onclick="filterTable('paid')">Paid</button>
                <button class="btn btn-sm btn-outline-warning" id="filterPending"
                        onclick="filterTable('pending')">Pending</button>
            </div>
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty approved}">
                    <div class="text-center py-5 text-muted">
                        <i class="fas fa-wallet fa-3x mb-3 d-block"></i>
                        <p>No approved registrations yet. Apply for events to start earning!</p>
                        <a href="${pageContext.request.contextPath}/event" class="btn btn-dark btn-sm">Browse Events</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle" id="paymentTable">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Event</th>
                                    <th>Company</th>
                                    <th>Date</th>
                                    <th>Category</th>
                                    <th>Amount</th>
                                    <th>Payment</th>
                                    <th>Paid On</th>
                                    <th>Rating</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="reg" items="${approved}" varStatus="loop">
                                    <tr class="payment-row ${reg.paymentStatus ? 'paid-row' : 'pending-row'}">
                                        <td class="text-muted small">${loop.index + 1}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/event-details/${reg.event.eventId}"
                                               class="fw-semibold text-decoration-none text-dark">
                                                ${reg.event.eventName}
                                            </a>
                                        </td>
                                        <td class="small">${reg.event.company.name}</td>
                                        <td class="small text-muted">${reg.event.startDatetime}</td>
                                        <td class="small">
                                            Category #${reg.eventWorkhand.workhnadCategoryId}
                                        </td>
                                        <td class="fw-semibold text-success">
                                            <i class="fas fa-rupee-sign me-1"></i>${reg.eventWorkhand.price}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${reg.paymentStatus}">
                                                    <span class="badge bg-success">
                                                        <i class="fas fa-check me-1"></i>Paid
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark">
                                                        <i class="fas fa-clock me-1"></i>Pending
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="small text-muted">
                                            <c:choose>
                                                <c:when test="${reg.paymentDate != null}">${reg.paymentDate}</c:when>
                                                <c:otherwise>—</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${reg.rating != null and reg.rating > 0}">
                                                    <span class="text-warning">
                                                        <c:forEach begin="1" end="${reg.rating}">&#9733;</c:forEach>
                                                    </span>
                                                    <small class="text-muted">${reg.rating}/5</small>
                                                </c:when>
                                                <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="mt-3 d-flex gap-2">
        <a href="${pageContext.request.contextPath}/history" class="btn btn-outline-dark">
            <i class="fas fa-history me-2"></i>Full Registration History
        </a>
        <a href="${pageContext.request.contextPath}/event" class="btn btn-dark">
            <i class="fas fa-search me-2"></i>Browse More Events
        </a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function filterTable(type) {
        var rows = document.querySelectorAll('.payment-row');
        rows.forEach(function(row) {
            if (type === 'all') {
                row.style.display = '';
            } else if (type === 'paid') {
                row.style.display = row.classList.contains('paid-row') ? '' : 'none';
            } else {
                row.style.display = row.classList.contains('pending-row') ? '' : 'none';
            }
        });
        document.getElementById('filterAll').classList.toggle('active', type === 'all');
        document.getElementById('filterPaid').classList.toggle('active', type === 'paid');
        document.getElementById('filterPending').classList.toggle('active', type === 'pending');
    }
</script>
</body>
</html>
