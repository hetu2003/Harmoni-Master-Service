<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment - ${event.eventName}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show m-3">
            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <section class="py-3 bg-dark text-white">
        <div class="container">
            <h4 class="mb-1">Payment &mdash; <strong>${event.eventName}</strong></h4>
            <small class="text-muted">Event #${event.eventId}</small>
        </div>
    </section>

    <div class="container my-4">

        <div class="d-flex gap-2 mb-4 flex-wrap">
            <a href="${pageContext.request.contextPath}/vendor/workhand-requests/${event.eventId}"
               class="btn btn-outline-primary">
                <i class="fas fa-clock me-1"></i>Pending
            </a>
            <a href="${pageContext.request.contextPath}/vendor/approved-requests/${event.eventId}"
               class="btn btn-outline-success">
                <i class="fas fa-check me-1"></i>Approved
            </a>
            <a href="${pageContext.request.contextPath}/vendor/payment/${event.eventId}"
               class="btn btn-warning">
                <i class="fas fa-credit-card me-1"></i>Payment
            </a>
        </div>

        <div class="alert alert-secondary d-flex justify-content-between align-items-center mb-4">
            <span><i class="fas fa-wallet me-2"></i><strong>Total Payable:</strong></span>
            <span class="fs-5 fw-bold">
                &#8377;<fmt:formatNumber value="${totalPrice}" maxFractionDigits="0"/>
            </span>
        </div>

        <c:choose>
            <c:when test="${empty workhands}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>No approved workhands available for payment.
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle">
                        <thead class="table-warning">
                            <tr>
                                <th>#</th>
                                <th>Workhand</th>
                                <th>Category</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Rating</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="wh" items="${workhands}" varStatus="loop">
                                <tr>
                                    <td class="text-muted small">${loop.index + 1}</td>
                                    <td>
                                        <span class="fw-semibold">${wh.workhand.name}</span><br>
                                        <small class="text-muted">${wh.workhand.email}</small>
                                    </td>
                                    <td>Category #${wh.eventWorkhand.workhnadCategoryId}</td>
                                    <td>&#8377;<fmt:formatNumber value="${wh.eventWorkhand.price}" maxFractionDigits="0"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${wh.paymentStatus}">
                                                <span class="badge bg-success">Paid</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Unpaid</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${wh.paymentStatus and wh.rating != null}">
                                            <span class="text-warning">
                                                <c:forEach begin="1" end="${wh.rating}">&#9733;</c:forEach>
                                            </span>
                                            (${wh.rating}/5)
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${not wh.paymentStatus}">
                                            <button class="btn btn-sm btn-primary"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#payModal${wh.registrationId}">
                                                <i class="fas fa-credit-card me-1"></i>Pay &amp; Rate
                                            </button>

                                            <%-- Pay + Rate modal --%>
                                            <div class="modal fade" id="payModal${wh.registrationId}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">
                                                                Pay &amp; Rate — ${wh.workhand.name}
                                                            </h5>
                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p class="mb-1">
                                                                <strong>Amount:</strong>
                                                                &#8377;<fmt:formatNumber value="${wh.eventWorkhand.price}" maxFractionDigits="0"/>
                                                            </p>
                                                            <p class="mb-3">
                                                                <strong>Category:</strong>
                                                                Category #${wh.eventWorkhand.workhnadCategoryId}
                                                            </p>
                                                            <label class="form-label fw-semibold">
                                                                Rate this workhand (1–5) <span class="text-danger">*</span>
                                                            </label>
                                                            <div class="star-rating mb-1">
                                                                <c:forEach begin="1" end="5" var="star">
                                                                    <i class="fas fa-star fs-3 star-icon"
                                                                       data-value="${star}"
                                                                       data-reg-id="${wh.registrationId}"
                                                                       style="cursor:pointer;color:#ccc;"></i>
                                                                </c:forEach>
                                                            </div>
                                                            <input type="hidden"
                                                                   id="ratingInput${wh.registrationId}"
                                                                   value="0">
                                                            <div class="text-danger small"
                                                                 id="ratingError${wh.registrationId}"
                                                                 style="display:none;">
                                                                Please select a rating before confirming.
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary"
                                                                    data-bs-dismiss="modal">Cancel</button>
                                                            <button type="button" class="btn btn-success"
                                                                    onclick="submitPayment(${wh.registrationId})">
                                                                <i class="fas fa-check me-1"></i>Confirm Payment
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- /modal --%>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var ctx = '${pageContext.request.contextPath}';

        // Star rating hover/click
        document.querySelectorAll('.star-icon').forEach(function(star) {
            star.addEventListener('click', function() {
                var regId  = this.getAttribute('data-reg-id');
                var rating = parseInt(this.getAttribute('data-value'));
                document.getElementById('ratingInput' + regId).value = rating;

                // Colour all stars in same modal up to clicked
                var allStars = this.closest('.modal-body').querySelectorAll('.star-icon');
                allStars.forEach(function(s, idx) {
                    s.style.color = (idx < rating) ? '#f5c518' : '#ccc';
                });
                document.getElementById('ratingError' + regId).style.display = 'none';
            });
        });

        function submitPayment(registrationId) {
            var rating = parseInt(document.getElementById('ratingInput' + registrationId).value);
            if (!rating || rating < 1) {
                document.getElementById('ratingError' + registrationId).style.display = 'block';
                return;
            }
            window.location.href = ctx + '/vendor/payment/success'
                + '?registration_id=' + registrationId
                + '&rating=' + rating;
        }
    </script>
</body>
</html>
