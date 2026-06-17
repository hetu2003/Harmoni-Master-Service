<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- page banner -->
<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">manage your events</span>
                            <h2 class="big-title">My <strong>Events</strong></h2>
                            <p class="white-color mb-0 mt-2">All your events with registration and payment summary</p>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="<c:url value='/home' />" class="breadcrumb-link">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">My Events</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section style="padding: 50px 0;">
    <div class="container">

        <!-- flash messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show mb-4">
                <i class="fas fa-check-circle mr-2"></i>${successMessage}
                <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show mb-4">
                <i class="fas fa-exclamation-circle mr-2"></i>${errorMessage}
                <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty rows}">
                <div class="text-center" style="padding: 80px 0;">
                    <i class="fas fa-calendar-times fa-4x mb-3 d-block" style="color: #ddd;"></i>
                    <h5>No events yet</h5>
                    <p class="text-muted">You haven't created any events.</p>
                    <a href="<c:url value='/vendor/event/add' />" class="custom-btn mt-2">
                        <i class="fas fa-plus mr-1"></i>Add Your First Event
                    </a>
                </div>
            </c:when>
            <c:otherwise>

                <!-- totals calculation -->
                <c:set var="sumTotal"    value="0" />
                <c:set var="sumApproved" value="0" />
                <c:set var="sumPaid"     value="0" />
                <c:forEach var="row" items="${rows}">
                    <c:set var="sumTotal"    value="${sumTotal    + row.total}" />
                    <c:set var="sumApproved" value="${sumApproved + row.approved}" />
                    <c:set var="sumPaid"     value="${sumPaid     + row.paid}" />
                </c:forEach>

                <!-- summary cards -->
                <div class="row mb-4">
                    <div class="col-md-3 col-6 mb-3">
                        <div style="background: linear-gradient(135deg, #1c1c2e, #2d2d44); color:#fff; border-radius:10px; padding:24px; text-align:center; box-shadow:0 3px 15px rgba(0,0,0,0.15);">
                            <h3 class="font-weight-bold mb-1" style="font-size:2rem;">${rows.size()}</h3>
                            <small style="opacity:0.8;">Total Events</small>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-3">
                        <div style="background: linear-gradient(135deg, #17a2b8, #138496); color:#fff; border-radius:10px; padding:24px; text-align:center; box-shadow:0 3px 15px rgba(0,0,0,0.15);">
                            <h3 class="font-weight-bold mb-1" style="font-size:2rem;">${sumTotal}</h3>
                            <small style="opacity:0.8;">Total Applications</small>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-3">
                        <div style="background: linear-gradient(135deg, #28a745, #1e7e34); color:#fff; border-radius:10px; padding:24px; text-align:center; box-shadow:0 3px 15px rgba(0,0,0,0.15);">
                            <h3 class="font-weight-bold mb-1" style="font-size:2rem;">${sumApproved}</h3>
                            <small style="opacity:0.8;">Approved Workhands</small>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-3">
                        <div style="background: linear-gradient(135deg, #f0a500, #d4920a); color:#fff; border-radius:10px; padding:24px; text-align:center; box-shadow:0 3px 15px rgba(0,0,0,0.15);">
                            <h3 class="font-weight-bold mb-1" style="font-size:2rem;">${sumPaid}</h3>
                            <small style="opacity:0.9;">Payments Done</small>
                        </div>
                    </div>
                </div>

                <!-- events table -->
                <div style="background:#fff; border-radius:10px; box-shadow:0 3px 18px rgba(0,0,0,0.08); overflow:hidden;">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0" style="font-size:0.9rem;">
                            <thead style="background: linear-gradient(135deg, #1c1c2e, #2d2d44); color:#fff;">
                                <tr>
                                    <th style="padding:14px 16px; font-weight:600;">#</th>
                                    <th style="padding:14px 16px; font-weight:600;">Event Name</th>
                                    <th style="padding:14px 16px; font-weight:600;">Category</th>
                                    <th style="padding:14px 16px; font-weight:600;">Date</th>
                                    <th style="padding:14px 16px; font-weight:600;">Location</th>
                                    <th style="padding:14px 16px; font-weight:600; text-align:center;">Applications</th>
                                    <th style="padding:14px 16px; font-weight:600; text-align:center;">Approved</th>
                                    <th style="padding:14px 16px; font-weight:600; text-align:center;">Paid</th>
                                    <th style="padding:14px 16px; font-weight:600;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${rows}" varStatus="loop">
                                    <tr style="border-bottom:1px solid #f0f0f0;">
                                        <td style="padding:14px 16px; color:#999;">${loop.index + 1}</td>
                                        <td style="padding:14px 16px;">
                                            <span class="font-weight-bold">${row.event.eventName}</span>
                                            <br><small style="color:#aaa;">ID #${row.event.eventId}</small>
                                        </td>
                                        <td style="padding:14px 16px;">
                                            <span style="background:#0056d2; color:#fff; padding:3px 8px; border-radius:4px; font-size:0.75rem;">${row.event.eventCategory.eventCategoryName}</span>
                                            <br><small style="color:#888;">${row.event.eventSubcategory.eventSubcategoryName}</small>
                                        </td>
                                        <td style="padding:14px 16px; font-size:0.82rem; color:#666;">
                                            <i class="fas fa-calendar-alt mr-1" style="color:#28a745;"></i>${row.event.startDatetime}
                                            <br><span style="color:#aaa;">&#8594; ${row.event.endDatetime}</span>
                                        </td>
                                        <td style="padding:14px 16px; font-size:0.82rem; color:#666;">
                                            <i class="fas fa-map-marker-alt mr-1" style="color:#e44;"></i>${row.event.city.cityName}, ${row.event.state.stateName}
                                        </td>
                                        <td style="padding:14px 16px; text-align:center;">
                                            <span style="background:#17a2b8; color:#fff; padding:4px 10px; border-radius:20px; font-weight:600;">${row.total}</span>
                                        </td>
                                        <td style="padding:14px 16px; text-align:center;">
                                            <span style="background:#28a745; color:#fff; padding:4px 10px; border-radius:20px; font-weight:600;">${row.approved}</span>
                                        </td>
                                        <td style="padding:14px 16px; text-align:center;">
                                            <span style="background:#f0a500; color:#fff; padding:4px 10px; border-radius:20px; font-weight:600;">${row.paid}</span>
                                        </td>
                                        <td style="padding:14px 16px;">
                                            <a href="<c:url value='/vendor/workhand-requests/${row.event.eventId}' />"
                                               class="btn btn-sm btn-outline-primary mb-1 d-block" style="font-size:0.78rem;">
                                                <i class="fas fa-users mr-1"></i>Requests
                                            </a>
                                            <a href="<c:url value='/vendor/payment/${row.event.eventId}' />"
                                               class="btn btn-sm d-block" style="font-size:0.78rem; background:#f0a500; color:#fff; border:none;">
                                                <i class="fas fa-credit-card mr-1"></i>Payments
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </c:otherwise>
        </c:choose>

    </div>
</section>
