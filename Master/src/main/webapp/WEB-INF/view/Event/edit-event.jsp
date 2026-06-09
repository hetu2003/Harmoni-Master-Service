<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Event - ${event.eventName}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <%-- Flash messages --%>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show m-3" id="flashMsg">
            <i class="fas fa-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show m-3" id="flashMsg">
            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Header -->
    <section class="py-3 bg-dark text-white">
        <div class="container">
            <h4 class="mb-0">
                <i class="fas fa-edit me-2"></i>Edit Event &mdash;
                <strong>${event.eventName}</strong>
            </h4>
        </div>
    </section>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-9">

                <div class="card shadow-sm">
                    <div class="card-body p-4">

                        <form id="editEventForm"
                              action="${pageContext.request.contextPath}/vendor/event/${event.eventId}/edit"
                              method="POST">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                            <!-- ── Category & Subcategory ── -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        Event Category <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" name="cat_id" id="catSelect" required>
                                        <option value="" disabled>-- Choose Category --</option>
                                        <c:forEach var="cat" items="${eventCategories}">
                                            <option value="${cat.eventCategoryId}"
                                                <c:if test="${cat.eventCategoryId == event.eventCategory.eventCategoryId}">
                                                    selected
                                                </c:if>>
                                                ${cat.eventCategoryName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        Event Subcategory <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" name="subcat_id" id="subcatSelect" required>
                                        <%-- Pre-populate existing subcategories; JS updates on cat change --%>
                                        <c:forEach var="sub" items="${eventSubcategories}">
                                            <option value="${sub.eventSubcategoryId}"
                                                <c:if test="${sub.eventSubcategoryId == event.eventSubcategory.eventSubcategoryId}">
                                                    selected
                                                </c:if>>
                                                ${sub.eventSubcategoryName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <!-- ── Event Name ── -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    Event Name <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" name="event_name"
                                       value="${event.eventName}" required>
                            </div>

                            <!-- ── Start & End Date/Time ── -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        Start Date &amp; Time <span class="text-danger">*</span>
                                    </label>
                                    <input type="datetime-local" class="form-control"
                                           name="start_datetime" id="startDatetime"
                                           value="${startDatetimeStr}"
                                           required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        End Date &amp; Time <span class="text-danger">*</span>
                                    </label>
                                    <input type="datetime-local" class="form-control"
                                           name="end_datetime" id="endDatetime"
                                           value="${endDatetimeStr}"
                                           required>
                                    <div class="invalid-feedback">
                                        End time must be after start time.
                                    </div>
                                </div>
                            </div>

                            <!-- ── Existing Workhand Slots ── -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    Workhand Category Slots
                                </label>
                                <div class="form-text text-muted mb-2">
                                    Existing slots are pre-filled below. Change the count to add or remove rows.
                                    All slots will be replaced on save.
                                </div>

                                <div class="mb-2">
                                    <label class="form-label">
                                        Number of Slots <span class="text-danger">*</span>
                                    </label>
                                    <input type="number" class="form-control" id="slotCount"
                                           min="1" max="20"
                                           value="${slots.size()}"
                                           oninput="generateSlots(this.value)">
                                </div>

                                <!-- Slot container pre-filled by JS using existing data -->
                                <div id="slotContainer" class="mb-3"></div>

                                <%-- Hidden JSON array for JS pre-fill --%>
                                <script id="existingSlotsData" type="application/json">
                                    [
                                    <c:forEach var="sl" items="${slots}" varStatus="vs">
                                        {
                                            "categoryId": ${sl.workhnadCategoryId},
                                            "count": ${sl.numberOfWorkhand},
                                            "price": "${sl.price}"
                                        }<c:if test="${not vs.last}">,</c:if>
                                    </c:forEach>
                                    ]
                                </script>
                            </div>

                            <!-- ── Address ── -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    Street Address <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" name="street_address"
                                       value="${event.streetAddress}" required>
                            </div>

                            <!-- ── State & City ── -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        State <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" name="state_id" id="stateSelect" required>
                                        <option value="" disabled>-- Choose State --</option>
                                        <c:forEach var="st" items="${states}">
                                            <option value="${st.stateId}"
                                                <c:if test="${st.stateId == event.state.stateId}">
                                                    selected
                                                </c:if>>
                                                ${st.stateName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        City <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" name="city_id" id="citySelect" required>
                                        <%-- Pre-populated cities for the existing state; AJAX refreshes on change --%>
                                        <c:forEach var="ct" items="${cities}">
                                            <option value="${ct.cityId}"
                                                <c:if test="${ct.cityId == event.city.cityId}">
                                                    selected
                                                </c:if>>
                                                ${ct.cityName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <!-- ── Description ── -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    Event Description <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" name="description" rows="5"
                                          required>${event.description}</textarea>
                            </div>

                            <!-- ── Submit ── -->
                            <div class="d-flex gap-3">
                                <button type="submit" class="btn btn-warning px-5" id="submitBtn">
                                    <i class="fas fa-save me-2"></i>Save Changes
                                </button>
                                <a href="${pageContext.request.contextPath}/vendor/my-events"
                                   class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Cancel
                                </a>
                            </div>

                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var CTX = '${pageContext.request.contextPath}';
        /* Selected city ID so AJAX city-load can re-select it after state change */
        var SELECTED_CITY_ID = ${event.city.cityId};
    </script>
    <script src="${pageContext.request.contextPath}/static/js/addEvent.js"></script>
    <script>
        /* Pre-fill existing workhand slot rows from embedded JSON */
        (function () {
            var raw = document.getElementById('existingSlotsData');
            if (!raw) return;
            var slots;
            try { slots = JSON.parse(raw.textContent); } catch (e) { return; }
            var n = slots.length;
            var countInput = document.getElementById('slotCount');
            if (countInput) countInput.value = n;
            generateSlots(n);
            slots.forEach(function (s, i) {
                var catInput  = document.getElementById('wh_cat_' + i);
                var numInput  = document.getElementById('wh_num_' + i);
                var priceInput = document.getElementById('wh_price_' + i);
                if (catInput)   catInput.value   = s.categoryId;
                if (numInput)   numInput.value   = s.count;
                if (priceInput) priceInput.value = s.price;
            });
        })();
    </script>
</body>
</html>
