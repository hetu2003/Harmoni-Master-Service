<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- breadcrumb-section - start -->
<section id="breadcrumb-section" class="breadcrumb-section clearfix" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />'); background-size:cover; background-position:center center;">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">my events</span>
                            <h2 class="big-title">add <strong>new event</strong></h2>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="<c:url value='/home' />" class="breadcrumb-link">Home</a></li>
                                <li class="breadcrumb-item"><a href="<c:url value='/vendor/my-events' />" class="breadcrumb-link">My Events</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Add Event</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>
<!-- breadcrumb-section - end -->

<section style="padding: 50px 0;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-9">

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

                <div style="background:#fff; border-radius:10px; box-shadow:0 3px 18px rgba(0,0,0,0.08); padding:32px;">
                    <form id="addEventForm"
                          action="<c:url value='/vendor/event/add' />"
                          method="POST"
                          enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                        <!-- Category & Subcategory -->
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="font-weight-bold">Event Category <span class="text-danger">*</span></label>
                                <select class="form-control" name="cat_id" id="catSelect" required>
                                    <option value="" disabled <c:if test="${empty f_cat_id}">selected</c:if>>-- Choose Category --</option>
                                    <c:forEach var="cat" items="${eventCategories}">
                                        <option value="${cat.eventCategoryId}"
                                            <c:if test="${cat.eventCategoryId == f_cat_id}">selected</c:if>>
                                            ${cat.eventCategoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="font-weight-bold">Event Subcategory <span class="text-danger">*</span></label>
                                <select class="form-control" name="subcat_id" id="subcatSelect" required>
                                    <option value="" disabled selected>-- Select category first --</option>
                                </select>
                            </div>
                        </div>

                        <!-- Event Name -->
                        <div class="mb-3">
                            <label class="font-weight-bold">Event Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="event_name"
                                   value="${f_event_name}"
                                   placeholder="e.g. Annual Gala Dinner 2025" required>
                        </div>

                        <!-- Start & End Date/Time -->
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="font-weight-bold">Start Date &amp; Time <span class="text-danger">*</span></label>
                                <input type="datetime-local" class="form-control" name="start_datetime"
                                       id="startDatetime" value="${f_start_datetime}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="font-weight-bold">End Date &amp; Time <span class="text-danger">*</span></label>
                                <input type="datetime-local" class="form-control" name="end_datetime"
                                       id="endDatetime" value="${f_end_datetime}" required>
                                <div class="invalid-feedback">End time must be after start time.</div>
                            </div>
                        </div>

                        <!-- Workhand Role Slots -->
                        <div class="mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <label class="font-weight-bold mb-0">
                                    Workhand Roles Required <span class="text-danger">*</span>
                                </label>
                                <button type="button" class="custom-btn" style="padding:6px 16px; font-size:0.82rem;" onclick="addSlotRow()">
                                    <i class="fas fa-plus mr-1"></i>Add Another Role
                                </button>
                            </div>
                            <div style="background:#f8f9fa; border-radius:6px; padding:12px 14px; margin-bottom:6px;">
                                <div class="row mb-1" style="font-size:0.8rem; font-weight:600; color:#666;">
                                    <div class="col-md-5">Role / Category</div>
                                    <div class="col-md-3">No. of People</div>
                                    <div class="col-md-3">Price per Person (&#8377;)</div>
                                    <div class="col-md-1"></div>
                                </div>
                            </div>
                            <div id="slotContainer"></div>
                        </div>

                        <!-- Street Address -->
                        <div class="mb-3">
                            <label class="font-weight-bold">Street Address <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="street_address"
                                   value="${f_street_address}"
                                   placeholder="e.g. 12, MG Road" required>
                        </div>

                        <!-- State & City -->
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="font-weight-bold">State <span class="text-danger">*</span></label>
                                <select class="form-control" name="state_id" id="stateSelect" required>
                                    <option value="" disabled <c:if test="${empty f_state_id}">selected</c:if>>-- Choose State --</option>
                                    <c:forEach var="st" items="${states}">
                                        <option value="${st.stateId}"
                                            <c:if test="${st.stateId == f_state_id}">selected</c:if>>
                                            ${st.stateName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="font-weight-bold">City <span class="text-danger">*</span></label>
                                <select class="form-control" name="city_id" id="citySelect" required>
                                    <option value="" disabled selected>-- Select state first --</option>
                                </select>
                            </div>
                        </div>

                        <!-- Description -->
                        <div class="mb-4">
                            <label class="font-weight-bold">Event Description <span class="text-danger">*</span></label>
                            <textarea class="form-control" name="description" rows="5"
                                      placeholder="Describe the event..." required>${f_description}</textarea>
                        </div>

                        <!-- Event Banner Image -->
                        <div class="mb-4">
                            <label class="font-weight-bold">Event Banner Image <span class="text-muted small">(optional, JPG/PNG)</span></label>
                            <input type="file" class="form-control-file" name="imageFile"
                                   accept="image/jpeg,image/png,image/webp">
                            <small class="form-text text-muted">Recommended: 1200&times;400 px, max 5 MB.</small>
                        </div>

                        <!-- Submit -->
                        <div class="d-flex">
                            <button type="submit" class="custom-btn mr-3" id="submitBtn">
                                <i class="fas fa-calendar-plus mr-2"></i>Create Event
                            </button>
                            <a href="<c:url value='/vendor/my-events' />" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left mr-2"></i>Back to My Events
                            </a>
                        </div>

                    </form>
                </div>

            </div>
        </div>
</section>

<%-- Pass workhand categories and pre-fill data to JavaScript --%>
<script>
var CTX = '${pageContext.request.contextPath}';

var WORKHAND_CATS = [
    <c:forEach var="cat" items="${workhnadCategories}" varStatus="s">
    { id: ${cat.workhnadCategoryId}, name: '${cat.workhnadCategoryName}' }<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];

<%-- Pre-fill slots after a validation error --%>
<c:if test="${not empty f_workhand_category_ids}">
var PREFILL_SLOTS = [
    <c:forEach var="catId" items="${f_workhand_category_ids}" varStatus="s">
    { catId: ${catId}, num: ${f_workhand_numbers[s.index]}, price: '${f_prices[s.index]}' }<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];
</c:if>

<%-- Pre-load subcategory + city dropdowns on validation reload --%>
<c:if test="${not empty f_cat_id}">
var PREFILL_CAT = ${f_cat_id};
var PREFILL_SUBCAT = ${not empty f_subcat_id ? f_subcat_id : 0};
</c:if>
<c:if test="${not empty f_state_id}">
var PREFILL_STATE = ${f_state_id};
var PREFILL_CITY  = ${not empty f_city_id ? f_city_id : 0};
</c:if>
</script>
<script src="${pageContext.request.contextPath}/assets/custom/Event/addEvent.js"></script>
<script>
(function() {
    var startEl = document.getElementById('startDatetime');
    var endEl   = document.getElementById('endDatetime');

    function updateEndMin() {
        if (startEl.value) endEl.min = startEl.value;
    }
    if (startEl) {
        startEl.addEventListener('change', updateEndMin);
        updateEndMin();
    }

    var form = document.getElementById('addEventForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            if (startEl.value && endEl.value && endEl.value <= startEl.value) {
                endEl.classList.add('is-invalid');
                endEl.setCustomValidity('End time must be after start time.');
                e.preventDefault();
            } else {
                endEl.classList.remove('is-invalid');
                endEl.setCustomValidity('');
            }
        });
        endEl && endEl.addEventListener('change', function() {
            if (startEl.value && endEl.value > startEl.value) {
                endEl.classList.remove('is-invalid');
                endEl.setCustomValidity('');
            }
        });
    }
})();
</script>


