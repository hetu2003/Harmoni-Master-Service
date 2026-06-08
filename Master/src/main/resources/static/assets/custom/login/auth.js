// This script will handle the AJAX login functionality

document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.getElementById("loginForm");
    const messageDiv = document.getElementById("message");

    if (loginForm) {
        loginForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent the default form submission

            const formData = new FormData(loginForm);
            const data = Object.fromEntries(formData.entries());

            // Show a loading message
            messageDiv.innerHTML = '<div class="alert alert-info">Logging in...</div>';
            messageDiv.style.display = 'block';

            fetch(loginForm.action, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    // Spring Security requires a CSRF token for AJAX POST requests
                    // We will handle this in the JSP.
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    // On success, redirect to the dashboard
                    window.location.href = result.redirectUrl;
                } else {
                    // On failure, display the error message
                    messageDiv.innerHTML = `<div class="alert alert-danger">${result.message}</div>`;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                messageDiv.innerHTML = '<div class="alert alert-danger">An unexpected error occurred. Please try again.</div>';
            });
        });
    }
});
