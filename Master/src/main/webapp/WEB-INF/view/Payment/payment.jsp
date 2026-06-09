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

    <%-- ... your existing header + table JSP unchanged ... --%>

    <%-- Hidden form — submitted programmatically after Razorpay callback --%>
    <form id="rzpVerifyForm" action="${pageContext.request.contextPath}/payment/verify"
          method="POST" style="display:none;">
        <input type="hidden" id="rzp_order_id"   name="razorpay_order_id">
        <input type="hidden" id="rzp_payment_id" name="razorpay_payment_id">
        <input type="hidden" id="rzp_signature"  name="razorpay_signature">
        <input type="hidden" id="rzp_reg_id"     name="registration_id">
        <input type="hidden" id="rzp_rating"     name="rating">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <%-- Razorpay hosted checkout library --%>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

    <script>
        var CTX = '${pageContext.request.contextPath}';

        /* ── Star rating (same as before) ── */
        document.querySelectorAll('.star-icon').forEach(function (star) {
            star.addEventListener('click', function () {
                var regId  = this.getAttribute('data-reg-id');
                var rating = parseInt(this.getAttribute('data-value'));
                document.getElementById('ratingInput' + regId).value = rating;
                var allStars = this.closest('.modal-body').querySelectorAll('.star-icon');
                allStars.forEach(function (s, idx) {
                    s.style.color = idx < rating ? '#f5c518' : '#ccc';
                });
                document.getElementById('ratingError' + regId).style.display = 'none';
            });
        });

        /* ── Confirm Payment — replaced with Razorpay flow ── */
        function submitPayment(registrationId) {
            var rating = parseInt(document.getElementById('ratingInput' + registrationId).value);
            if (!rating || rating < 1) {
                document.getElementById('ratingError' + registrationId).style.display = 'block';
                return;
            }

            // Step 1: Create Razorpay order on backend
            fetch(CTX + '/payment/create-order', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'registrationId=' + registrationId + '&rating=' + rating
            })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (!data.success) {
                    alert('Could not initiate payment: ' + data.error);
                    return;
                }

                // Step 2: Open Razorpay checkout
                var options = {
                    key:         data.keyId,
                    amount:      data.amount,       // in paise, as returned by Razorpay
                    currency:    data.currency,
                    name:        'Harmoni Events',
                    description: 'Workhand Payment',
                    order_id:    data.orderId,

                    handler: function (response) {
                        // Step 3: Populate hidden form and submit for server-side verification
                        document.getElementById('rzp_order_id').value   = response.razorpay_order_id;
                        document.getElementById('rzp_payment_id').value = response.razorpay_payment_id;
                        document.getElementById('rzp_signature').value  = response.razorpay_signature;
                        document.getElementById('rzp_reg_id').value     = data.registrationId;
                        document.getElementById('rzp_rating').value     = data.rating;
                        document.getElementById('rzpVerifyForm').submit();
                    },

                    prefill: {
                        name:    data.workhangName,
                        email:   data.workhangEmail,
                        contact: data.workhangPhone
                    },

                    theme: { color: '#0d6efd' },

                    modal: {
                        ondismiss: function () {
                            console.log('Checkout dismissed without payment.');
                        }
                    }
                };

                var rzp = new Razorpay(options);

                // Handle payment failure inside the modal
                rzp.on('payment.failed', function (resp) {
                    alert('Payment failed: ' + resp.error.description);
                });

                rzp.open();
            })
            .catch(function (err) {
                alert('Network error. Please try again.');
                console.error(err);
            });
        }
    </script>
</body>
</html>