<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty errorMessage}">
<div class="alert alert-danger alert-dismissible m-3" style="border-left:4px solid #dc3545;">
    <i class="fas fa-exclamation-circle mr-2"></i>${errorMessage}
    <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
</div>
</c:if>

<!-- Banner -->
<section style="background: linear-gradient(135deg, #1c1c2e 0%, #2d2d44 100%); padding: 50px 0;">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb" style="background:transparent; padding:0; margin-bottom:10px;">
                <li class="breadcrumb-item"><a href="<c:url value='/home' />" style="color:#ccc;">Home</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/event' />" style="color:#ccc;">Events</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/event-details/${event.eventId}' />" style="color:#ccc;">${event.eventName}</a></li>
                <li class="breadcrumb-item active" style="color:#f0a500;">Apply</li>
            </ol>
        </nav>
        <h2 class="white-color font-weight-bold mb-1">Apply for <strong>${event.eventName}</strong></h2>
        <p class="mb-0" style="color:#ccc;">Select your role and submit your application</p>
    </div>
</section>

<section style="padding: 50px 0; background:#f8f9fa;">
    <div class="container">
        <div class="row">

            <!-- Left: slot summary + form -->
            <div class="col-lg-8">

                <div class="card mb-4 shadow-sm">
                    <div class="card-header" style="background:#fff; border-bottom:2px solid #f0a500;">
                        <h5 class="mb-0 font-weight-bold">Available Roles</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover text-center mb-0">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Role / Category</th>
                                        <th>Positions Needed</th>
                                        <th>Pay (per person)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="ew" items="${eventWorkhands}">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty ew.workhnadCategory.workhnadCategoryName}">
                                                        ${ew.workhnadCategory.workhnadCategoryName}
                                                    </c:when>
                                                    <c:otherwise>Category #${ew.workhnadCategoryId}</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${ew.numberOfWorkhand}</td>
                                            <td>&#8377;<fmt:formatNumber value="${ew.price}" maxFractionDigits="0"/></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty eventWorkhands}">
                                        <tr><td colspan="3" class="text-muted">No roles defined yet.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm">
                    <div class="card-header" style="background:#fff; border-bottom:2px solid #f0a500;">
                        <h5 class="mb-0 font-weight-bold">Your Information</h5>
                    </div>
                    <div class="card-body">
                        <form id="registerForm"
                              action="<c:url value='/event-register/${event.eventId}' />"
                              method="POST">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label class="text-muted small">Name</label>
                                    <input type="text" class="form-control bg-light" value="${workhand.name}" disabled>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label class="text-muted small">Username</label>
                                    <input type="text" class="form-control bg-light" value="${workhand.username}" disabled>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label class="text-muted small">Email</label>
                                    <input type="email" class="form-control bg-light" value="${workhand.email}" disabled>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label class="text-muted small">Mobile</label>
                                    <input type="text" class="form-control bg-light" value="${workhand.contactNumber}" disabled>
                                </div>
                                <div class="col-md-12 form-group">
                                    <label class="text-muted small">Address</label>
                                    <input type="text" class="form-control bg-light" value="${workhand.streetAddress}" disabled>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label class="text-muted small">City</label>
                                    <input type="text" class="form-control bg-light" value="${workhand.city.cityName}" disabled>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label class="text-muted small">State</label>
                                    <input type="text" class="form-control bg-light" value="${workhand.state.stateName}" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-weight-bold">Select Your Role <span class="text-danger">*</span></label>
                                <select class="form-control" name="selected_category" id="categorySelect" required>
                                    <option value="" disabled selected>-- Select a role --</option>
                                    <c:forEach var="ew" items="${eventWorkhands}">
                                        <option value="${ew.eventWorkhnadId}">
                                            <c:choose>
                                                <c:when test="${not empty ew.workhnadCategory.workhnadCategoryName}">
                                                    ${ew.workhnadCategory.workhnadCategoryName}
                                                </c:when>
                                                <c:otherwise>Category #${ew.workhnadCategoryId}</c:otherwise>
                                            </c:choose>
                                            &nbsp;— &#8377;<fmt:formatNumber value="${ew.price}" maxFractionDigits="0"/> per person
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="text-center mt-3">
                                <button type="submit" class="custom-btn" id="submitBtn">
                                    <i class="fas fa-paper-plane mr-2"></i>Submit Application
                                </button>
                                <a href="<c:url value='/event-details/${event.eventId}' />" class="btn btn-outline-secondary ml-2">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>

            </div>

            <!-- Right: event info -->
            <div class="col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-header" style="background:#fff; border-bottom:2px solid #f0a500;">
                        <h6 class="mb-0 font-weight-bold">Event Info</h6>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled small">
                            <li class="mb-2">
                                <i class="fas fa-map-marker-alt mr-2 text-danger"></i>
                                <strong>${event.city.cityName}, ${event.state.stateName}</strong>
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-building mr-2" style="color:#f0a500;"></i>${event.company.name}
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-tag mr-2" style="color:#f0a500;"></i>${event.eventSubcategory.eventSubcategoryName}
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-calendar mr-2" style="color:#f0a500;"></i>${event.startDatetime}
                            </li>
                            <li>
                                <i class="fas fa-users mr-2" style="color:#f0a500;"></i>
                                Total Positions: <strong>${event.totalWorkhand}</strong>
                            </li>
                        </ul>
                        <hr>
                        <h6>Organizer Contact</h6>
                        <ul class="list-unstyled small text-muted">
                            <li class="mb-1"><i class="fas fa-phone mr-2"></i>${event.company.contactNumber}</li>
                            <li class="mb-1"><i class="fas fa-envelope mr-2"></i>${event.company.email}</li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
