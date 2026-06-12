<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Bootstrap 5 + FA6 loaded here so modal/flex classes work alongside base.jsp's Bootstrap 4 --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    .star-icon { font-size: 1.5rem; cursor: pointer; color: #ccc; transition: color .15s; }
    .star-icon:hover, .star-icon.active { color: #f5c518; }
    .event-banner { height: 180px; object-fit: cover; border-radius: 12px; }
    .event-banner-placeholder {
        height: 180px; border-radius: 12px; background: linear-gradient(135deg, #0d6efd, #6610f2);
        display: flex; align-items: center; justify-content: center; color: #fff; font-size: 3rem;
    }
</style>

<div class="container my-4">

    <!-- Flash messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Event header -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body">
            <div class="row g-3 align-items-center">
                <div class="col-md-3">
                    <c:choose>
                        <c:when test="${not empty event.imagePath}">
                            <img src="${pageContext.request.contextPath}/${event.imagePath}"
                                 class="w-100 event-banner" alt="${event.eventName}">
                        </c:when>
                        <c:otherwise>
                            <div class="event-banner-placeholder w-100">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-9">
                    <h4 class="fw-bold mb-1">${event.eventName}</h4>
                    <p class="text-muted mb-1">
                        <i class="fas fa-map-marker-alt me-1 text-danger"></i>
                        ${event.streetAddress}
                        <c:if test="${event.city != null}">, ${event.city.cityName}</c:if>
                        <c:if test="${event.state != null}">, ${event.state.stateName}</c:if>
                    </p>
                    <p class="text-muted mb-2">
                        <i class="fas fa-calendar me-1 text-primary"></i>
                        ${event.startDatetime} &rarr; ${event.endDatetime}
                    </p>
                    <div class="d-flex gap-3">
                        <span class="badge bg-primary fs-6">
                            <i class="fas fa-users me-1"></i>${workhands.size()} Approved
                        </span>
                        <span class="badge bg-success fs-6">
                            <i class="fas fa-rupee-sign me-1"></i>Total: &#8377;
                            <fmt:formatNumber value="${totalPrice}" maxFractionDigits="0"/>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Workhands table -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white fw-semibold">
            <i class="fas fa-credit-card me-2 text-primary"></i>
            Process Workhand Payments
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty workhands}">
                    <div class="text-center py-5 text-muted">
                        <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                        <h5>No approved workhands yet</h5>
                        <p class="small">Approve workhand requests first before processing payments.</p>
                        <a href="${pageContext.request.contextPath}/vendor/workhand-requests/${event.id}"
                           class="btn btn-primary">
                            <i class="fas fa-users me-1"></i>View Requests
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Workhand</th>
                                    <th>Category</th>
                                    <th>Amount</th>
                                    <th>Applied</th>
                                    <th class="text-center">Rating</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dto" items="${workhands}" varStatus="loop">
                                    <tr>
                                        <td class="text-muted small">${loop.index + 1}</td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <c:choose>
                                                    <c:when test="${not empty dto.workhand.profilePath}">
                                                        <img src="${pageContext.request.contextPath}/${dto.workhand.profilePath}"
                                                             class="rounded-circle" width="38" height="38"
                                                             style="object-fit:cover;" alt="${dto.workhand.name}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="rounded-circle bg-secondary d-flex align-items-center
                                                                    justify-content-center text-white"
                                                             style="width:38px;height:38px;font-size:.9rem;">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div>
                                                    <span class="fw-semibold">${dto.workhand.name}</span>
                                                    <br>
                                                    <small class="text-muted">${dto.workhand.email}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="small text-muted">
                                            Category #${dto.eventWorkhand.workhnadCategoryId}
                                        </td>
                                        <td class="fw-semibold text-success">
                                            &#8377;<fmt:formatNumber value="${dto.eventWorkhand.price}" maxFractionDigits="0"/>
                                        </td>
                                        <td class="small text-muted">${dto.registrationDate}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${dto.paymentStatus and dto.rating != null}">
                                                    <c:forEach begin="1" end="5" var="s">
                                                        <i class="fas fa-star ${s <= dto.rating ? 'text-warning' : 'text-muted'}"
                                                           style="font-size:.8rem;"></i>
                                                    </c:forEach>
                                                    <span class="ms-1 small text-muted">${dto.rating}/5</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted small">—</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${dto.paymentStatus}">
                                                    <span class="badge bg-success"><i class="fas fa-check me-1"></i>Paid</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark">Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${dto.paymentStatus}">
                                                    <span class="badge bg-success px-3 py-2"
                                                          title="Paid on ${dto.paymentDate}">
                                                        <i class="fas fa-check-circle me-1"></i>Already Paid
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-sm btn-primary"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#payModal${dto.registrationId}"
                                                            data-reg-id="${dto.registrationId}"
                                                            data-amount="${dto.eventWorkhand.price}"
                                                            data-name="${dto.workhand.name}">
                                                        <i class="fas fa-credit-card me-1"></i>Pay
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>

                                    <%-- Rating + Pay modal for each unpaid workhand --%>
                                    <c:if test="${!dto.paymentStatus}">
                                    <div class="modal fade" id="payModal${dto.registrationId}" tabindex="-1">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">
                                                        <i class="fas fa-credit-card me-2 text-primary"></i>
                                                        Pay ${dto.workhand.name}
                                                    </h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="alert alert-info d-flex align-items-center gap-2 py-2">
                                                        <i class="fas fa-info-circle"></i>
                                                        <span>Amount: <strong>&#8377;<fmt:formatNumber
                                                            value="${dto.eventWorkhand.price}" maxFractionDigits="0"/></strong></span>
                                                    </div>

                                                    <p class="fw-semibold mb-2">Rate this workhand:</p>
                                                    <div class="d-flex gap-2 mb-1" id="stars${dto.registrationId}">
                                                        <c:forEach begin="1" end="5" var="s">
                                                            <i class="fas fa-star star-icon"
                                                               data-reg-id="${dto.registrationId}"
                                                               data-value="${s}"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <input type="hidden" id="ratingInput${dto.registrationId}" value="0">
                                                    <div id="ratingError${dto.registrationId}"
                                                         class="text-danger small mt-1" style="display:none;">
                                                        Please select a rating before paying.
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                    <button type="button" class="btn btn-primary"
                                                            onclick="submitPayment(${dto.registrationId}, ${dto.eventWorkhand.price})">
                                                        <i class="fas fa-rupee-sign me-1"></i>Confirm &amp; Pay
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </c:if>

                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Summary footer -->
    <c:if test="${not empty workhands}">
        <div class="card border-0 shadow-sm mt-3">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted me-3">
                        Total workhands: <strong>${workhands.size()}</strong>
                    </span>
                    <span class="text-muted">
                        Total payout: <strong class="text-success">
                            &#8377;<fmt:formatNumber value="${totalPrice}" maxFractionDigits="0"/>
                        </strong>
                    </span>
                </div>
                <a href="${pageContext.request.contextPath}/vendor/event-history" class="btn btn-outline-secondary btn-sm">
                    <i class="fas fa-history me-1"></i>Event History
                </a>
            </div>
        </div>
    </c:if>

</div>

<!-- Hidden form for Razorpay POST-back -->
<form id="rzpVerifyForm" action="${pageContext.request.contextPath}/payment/verify"
      method="POST" style="display:none;">
    <input type="hidden" id="rzp_order_id"   name="razorpay_order_id">
    <input type="hidden" id="rzp_payment_id" name="razorpay_payment_id">
    <input type="hidden" id="rzp_signature"  name="razorpay_signature">
    <input type="hidden" id="rzp_reg_id"     name="registration_id">
    <input type="hidden" id="rzp_rating"     name="rating">
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
    var CTX = '${pageContext.request.contextPath}';

    document.querySelectorAll('.star-icon').forEach(function(star) {
        star.addEventListener('click', function() {
            var regId  = this.getAttribute('data-reg-id');
            var rating = parseInt(this.getAttribute('data-value'));
            document.getElementById('ratingInput' + regId).value = rating;
            document.querySelectorAll('#stars' + regId + ' .star-icon').forEach(function(s, idx) {
                s.style.color = idx < rating ? '#f5c518' : '#ccc';
            });
            document.getElementById('ratingError' + regId).style.display = 'none';
        });
        star.addEventListener('mouseover', function() {
            var regId = this.getAttribute('data-reg-id');
            var val   = parseInt(this.getAttribute('data-value'));
            document.querySelectorAll('#stars' + regId + ' .star-icon').forEach(function(s, idx) {
                s.style.color = idx < val ? '#f5c518' : '#ccc';
            });
        });
        star.addEventListener('mouseout', function() {
            var regId = this.getAttribute('data-reg-id');
            var saved = parseInt(document.getElementById('ratingInput' + regId).value);
            document.querySelectorAll('#stars' + regId + ' .star-icon').forEach(function(s, idx) {
                s.style.color = idx < saved ? '#f5c518' : '#ccc';
            });
        });
    });

    function submitPayment(registrationId, priceRaw) {
        var rating = parseInt(document.getElementById('ratingInput' + registrationId).value);
        if (!rating || rating < 1) {
            document.getElementById('ratingError' + registrationId).style.display = 'block';
            return;
        }

        fetch(CTX + '/payment/create-order', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'registrationId=' + registrationId + '&amount=' + Math.round(priceRaw * 100) + '&rating=' + rating
        })
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (!data.success) {
                alert('Could not initiate payment: ' + (data.error || 'Unknown error'));
                return;
            }
            var options = {
                key:         data.keyId,
                amount:      data.amount,
                currency:    data.currency || 'INR',
                name:        'Harmoni Events',
                description: 'Workhand Payment',
                order_id:    data.orderId,
                handler: function(response) {
                    document.getElementById('rzp_order_id').value   = response.razorpay_order_id;
                    document.getElementById('rzp_payment_id').value = response.razorpay_payment_id;
                    document.getElementById('rzp_signature').value  = response.razorpay_signature;
                    document.getElementById('rzp_reg_id').value     = data.registrationId;
                    document.getElementById('rzp_rating').value     = data.rating;
                    document.getElementById('rzpVerifyForm').submit();
                },
                theme: { color: '#0d6efd' },
                modal: {
                    ondismiss: function() {
                        console.log('Checkout closed without payment.');
                    }
                }
            };
            var rzp = new Razorpay(options);
            rzp.on('payment.failed', function(resp) {
                alert('Payment failed: ' + resp.error.description);
            });
            rzp.open();
        })
        .catch(function(err) {
            alert('Network error — please try again.');
            console.error(err);
        });
    }
</script>
