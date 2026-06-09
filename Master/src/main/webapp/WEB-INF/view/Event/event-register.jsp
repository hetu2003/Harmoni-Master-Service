<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Register - Harmoni</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Breadcrumb -->
    <section class="py-3 bg-dark text-white">
        <div class="container">
            <h4 class="mb-1">Event <strong>Register</strong></h4>
            <nav><ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/home" class="text-light">Home</a>
                </li>
                <li class="breadcrumb-item active text-warning">${event.eventName}</li>
            </ol></nav>
        </div>
    </section>

    <section class="py-5 bg-light">
        <div class="container">
            <div class="row g-4">

                <%-- ── Left: Summary table + Registration form ── --%>
                <div class="col-lg-8">

                    <%-- Workhand slot summary --%>
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="mb-0">Workhand <strong>Summary</strong></h5>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table class="table table-bordered table-hover text-center mb-0">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Category ID</th>
                                        <th>Quantity Needed</th>
                                        <th>Price (per person)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="ew" items="${eventWorkhands}">
                                        <tr>
                                            <td>Category #${ew.workhnadCategoryId}</td>
                                            <td>${ew.numberOfWorkhand}</td>
                                            <td>&#8377;<fmt:formatNumber value="${ew.price}" maxFractionDigits="0"/></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty eventWorkhands}">
                                        <tr><td colspan="3" class="text-muted">No slots defined yet.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <%-- Registration form --%>
                    <div class="card shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="mb-0">Register <strong>Information</strong></h5>
                        </div>
                        <div class="card-body">
                            <form id="registerForm"
                                  action="${pageContext.request.contextPath}/event-register/${event.eventId}"
                                  method="POST">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                                <%-- Read-only workhand info --%>
                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small">Name</label>
                                        <input type="text" class="form-control bg-light"
                                               value="${workhand.name}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small">Username</label>
                                        <input type="text" class="form-control bg-light"
                                               value="${workhand.username}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small">Email</label>
                                        <input type="email" class="form-control bg-light"
                                               value="${workhand.email}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small">Mobile</label>
                                        <input type="text" class="form-control bg-light"
                                               value="${workhand.contactNumber}" disabled>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label text-muted small">Address</label>
                                        <input type="text" class="form-control bg-light"
                                               value="${workhand.streetAddress}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small">City</label>
                                        <input type="text" class="form-control bg-light"
                                               value="${workhand.city.cityName}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small">State</label>
                                        <input type="text" class="form-control bg-light"
                                               value="${workhand.state.stateName}" disabled>
                                    </div>
                                </div>

                                <%-- Category selector — the only actual input --%>
                                <div class="mb-4">
                                    <label class="form-label fw-semibold">
                                        Select Your Category <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" name="selected_category"
                                            id="categorySelect" required>
                                        <option value="" disabled selected>-- Select Category --</option>
                                        <c:forEach var="ew" items="${eventWorkhands}">
                                            <option value="${ew.eventWorkhnadId}">
                                                Category #${ew.workhnadCategoryId}
                                                &nbsp;(&#8377;<fmt:formatNumber value="${ew.price}" maxFractionDigits="0"/>)
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Please select a category.</div>
                                </div>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary px-5" id="submitBtn">
                                        <i class="fas fa-check-circle me-2"></i>Register Now
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <%-- ── Right: Event info sidebar ── --%>
                <div class="col-lg-4">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white"><h5 class="mb-0">Event <strong>Info</strong></h5></div>
                        <div class="card-body">
                            <ul class="list-unstyled">
                                <li>
                                    <i class="fas fa-map-marker-alt me-2 text-danger"></i>
                                    <strong>${event.city.cityName}, ${event.state.stateName}</strong>
                                </li>
                                <li class="mt-2">
                                    <i class="fas fa-building me-2 text-primary"></i>
                                    ${event.company.name}
                                </li>
                                <li class="mt-2">
                                    <i class="fas fa-tag me-2 text-primary"></i>
                                    ${event.eventSubcategory.eventSubcategoryName}
                                </li>
                                <li class="mt-2">
                                    <i class="fas fa-calendar me-2 text-primary"></i>
                                    ${event.startDatetime}
                                </li>
                                <li class="mt-2">
                                    <i class="fas fa-users me-2 text-primary"></i>
                                    Total Seats: <strong>${event.totalWorkhand}</strong>
                                </li>
                            </ul>
                            <hr>
                            <h6>Organizer Contact</h6>
                            <ul class="list-unstyled small text-muted">
                                <li><i class="fas fa-phone me-2"></i>${event.company.contactNumber}</li>
                                <li><i class="fas fa-envelope me-2"></i>${event.company.email}</li>
                                <li><i class="fas fa-map-marker-alt me-2"></i>
                                    ${event.company.city.cityName}, ${event.company.state.stateName}
                                </li>
                            </ul>
                            <p class="text-muted small">${event.company.companyDescription}</p>
                            <a href="${pageContext.request.contextPath}/contact"
                               class="btn btn-outline-primary w-100 mt-2">
                                <i class="fas fa-envelope me-1"></i>Contact Us
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/custom/Event/eventRegister.js"></script>
</body>
</html>
