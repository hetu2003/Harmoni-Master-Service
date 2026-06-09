/**
 * eventDetails.js
 * Auto-dismiss flash alerts and basic feedback form validation.
 */
document.addEventListener('DOMContentLoaded', function () {

    // Auto-dismiss alerts after 4 seconds
    document.querySelectorAll('.alert[id="flashMsg"], .alert.alert-success, .alert.alert-danger')
        .forEach(function (el) {
            setTimeout(function () {
                el.classList.remove('show');
                el.classList.add('fade');
                setTimeout(function () { el.remove(); }, 300);
            }, 4000);
        });

    // Feedback form validation
    var feedbackForm = document.getElementById('feedbackForm');
    if (feedbackForm) {
        feedbackForm.addEventListener('submit', function (e) {
            var textarea = feedbackForm.querySelector('textarea[name="feedback"]');
            if (!textarea || textarea.value.trim().length < 5) {
                e.preventDefault();
                if (textarea) {
                    textarea.classList.add('is-invalid');
                    textarea.focus();
                }
                return;
            }
            textarea.classList.remove('is-invalid');
            var btn = feedbackForm.querySelector('button[type="submit"]');
            if (btn) btn.disabled = true;
        });
    }
});
