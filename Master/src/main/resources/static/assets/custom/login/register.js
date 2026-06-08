// This script will handle the AJAX registration functionality

document.addEventListener("DOMContentLoaded", function() {
    const registerForm = document.getElementById("registerForm");
    const messageDiv = document.getElementById("message");

    if (registerForm) {
        registerForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent the default form submission

            // Create a FormData object from the form
            const formData = new FormData(registerForm);

            // Show a loading message
            if (messageDiv) {
                messageDiv.innerHTML = '<div class="alert alert-info">Registering...</div>';
                messageDiv.style.display = 'block';
            }

            fetch(registerForm.action, {
                method: 'POST',
                body: formData // Send the form data as multipart/form-data
                // No 'Content-Type' header needed; the browser sets it automatically for FormData
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    // On success, redirect to the login page
                    window.location.href = result.redirectUrl;
                } else {
                    // On failure, display the error message
                    if (messageDiv) {
                        messageDiv.innerHTML = `<div class="alert alert-danger">${result.message}</div>`;
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                if (messageDiv) {
                    messageDiv.innerHTML = '<div class="alert alert-danger">An unexpected error occurred. Please try again.</div>';
                }
            });
        });
    }
});
