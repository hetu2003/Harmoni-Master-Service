/**
 * eventRegister.js
 * Client-side validation for the event registration form.
 */
document.addEventListener('DOMContentLoaded', function () {

    var registerForm = document.getElementById('registerForm');
    if (!registerForm) return;

    registerForm.addEventListener('submit', function (e) {
        var categorySelect = document.getElementById('categorySelect');
        if (!categorySelect || !categorySelect.value) {
            e.preventDefault();
            if (categorySelect) {
                categorySelect.classList.add('is-invalid');
                categorySelect.focus();
            }
            return;
        }
        categorySelect.classList.remove('is-invalid');
        var btn = document.getElementById('submitBtn');
        if (btn) btn.disabled = true;
    });

    // Auto-dismiss error alerts after 4 seconds
    document.querySelectorAll('.alert.alert-danger').forEach(function (el) {
        setTimeout(function () {
            el.classList.remove('show');
            setTimeout(function () { el.remove(); }, 300);
        }, 4000);
    });
});
