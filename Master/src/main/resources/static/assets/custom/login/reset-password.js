document.addEventListener("DOMContentLoaded", function() {
    const resetPasswordForm = document.getElementById("resetPasswordForm");

    if (resetPasswordForm) {
        resetPasswordForm.addEventListener("submit", function(event) {
            // This is a standard form submission, no AJAX needed here
            // as the controller handles the redirect.
        });
    }
});
