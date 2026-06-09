<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Event - Harmoni</title>
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
            <h4 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Add <strong>New Event</strong></h4>
        </div>
    </section>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-9">

                <div class="card shadow-sm">
                    <div class="card-body p-4">

                        <form id="addEventForm"
                              action="${pageContext.request.contextPath}/vendor/event/add"
                              method="POST"
                              enctype="multipart/form-data">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                            <!-- ── Category & Subcategory ── -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        Event Category <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" name="cat_id" id="catSelect" required>
                                        <option value="" disabled selected>-- Choose Category --</option>
                                        <c:forEach var="cat" items="${eventCategories}">
                                            <option value="${cat.eventCategoryId}">
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
                                        <option value="" disabled selected>-- Select category first --</option>
                                    </select>
                                </div>
                            </div>

                            <!-- ── Event Name ── -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    Event Name <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" name="event_name"
                                       placeholder="e.g. Annual Gala Dinner 2025" required>
                            </div>

                            <!-- ── Start & End Date/Time ── -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        Start Date &amp; Time <span class="text-danger">*</span>
                                    </label>
                                    <input type="datetime-local" class="form-control"
                                           name="start_datetime" id="startDatetime" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        End Date &amp; Time <span class="text-danger">*</span>
                                    </label>
                                    <input type="datetime-local" class="form-control"
                                           name="end_datetime" id="endDatetime" required>
                                    <div class="invalid-feedback">
                                        End time must be after start time.
                                    </div>
                                </div>
                            </div>

                            <!-- ── Workhand Slots ── -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    Number of Workhand Category Slots <span class="text-danger">*</span>
                                </label>
                                <input type="number" class="form-control" id="slotCount"
                                       min="1" max="20" placeholder="e.g. 3"
                                       oninput="generateSlots(this.value)">
                                <div class="form-text text-muted">
                                    Enter how many different worker categories this event needs,
                                    then fill in the details below.
                                </div>
                            </div>

                            <!-- Dynamic slot rows injected here by JS -->
                            <div id="slotContainer" class="mb-3"></div>

                            <!-- ── Address ── -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    Street Address <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" name="street_address"
                                       placeholder="e.g. 12, MG Road" required>
                            </div>

                            <!-- ── State & City ── -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        State <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" name="state_id" id="stateSelect" required>
                                        <option value="" disabled selected>-- Choose State --</option>
                                        <c:forEach var="st" items="${states}">
                                            <option value="${st.stateId}">${st.stateName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        City <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" name="city_id" id="citySelect" required>
                                        <option value="" disabled selected>-- Select state first --</option>
                                    </select>
                                </div>
                            </div>

                            <!-- ── Description ── -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    Event Description <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" name="description" rows="5"
                                          placeholder="Describe the event..." required></textarea>
                            </div>

                            <!-- ── Event Banner Image ── -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    Event Banner Image <span class="text-muted small">(optional, JPG/PNG)</span>
                                </label>
                                <input type="file" class="form-control" name="imageFile"
                                       accept="image/jpeg,image/png,image/webp">
                                <div class="form-text text-muted">
                                    Recommended: 1200×400 px, max 5 MB.
                                </div>
                            </div>

                            <!-- ── Submit ── -->
                            <div class="d-flex gap-3">
                                <button type="submit" class="btn btn-primary px-5" id="submitBtn">
                                    <i class="fas fa-calendar-plus me-2"></i>Create Event
                                </button>
                                <a href="${pageContext.request.contextPath}/vendor/my-events"
                                   class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Back to My Events
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
        /* Context path for AJAX calls */
        var CTX = '${pageContext.request.contextPath}';
    </script>
    <script src="${pageContext.request.contextPath}/assets/custom/Event/addEvent.js"></script>
</body>
</html>
