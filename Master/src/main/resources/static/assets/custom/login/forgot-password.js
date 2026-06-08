document.addEventListener("DOMContentLoaded", function() {
    const forgotPasswordForm = document.getElementById("forgotPasswordForm");
    const messageDiv = document.getElementById("message");

    if (forgotPasswordForm) {
        forgotPasswordForm.addEventListener("submit", function(event) {
            event.preventDefault();

            const formData = new FormData(forgotPasswordForm);
            const data = Object.fromEntries(formData.entries());

            if (messageDiv) {
                messageDiv.innerHTML = '<div class="alert alert-info">Sending request...</div>';
                messageDiv.style.display = 'block';
            }

            fetch(forgotPasswordForm.action, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    messageDiv.innerHTML = `<div class="alert alert-success">${result.message}</div>`;
                } else {
                    messageDiv.innerHTML = `<div class="alert alert-danger">${result.message}</div>`;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                if (messageDiv) {
                    messageDiv.innerHTML = '<div class="alert alert-danger">An unexpected error occurred.</div>';
                }
            });
        });
    }
});
