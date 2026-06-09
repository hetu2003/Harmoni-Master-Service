// ─── Role Selection ────────────────────────────────────────────────────────
function selectRole(roleId) {
    document.getElementById("role-selector").style.display = "none";
    document.getElementById("message").style.display = "none";

    if (roleId === 1) {
        document.getElementById("form-workhand").style.display = "block";
        document.getElementById("form-company").style.display = "none";
        document.getElementById("card-workhand").classList.add("selected");
        document.getElementById("card-company").classList.remove("selected");
    } else {
        document.getElementById("form-company").style.display = "block";
        document.getElementById("form-workhand").style.display = "none";
        document.getElementById("card-company").classList.add("selected");
        document.getElementById("card-workhand").classList.remove("selected");
    }
}

function resetRole() {
    document.getElementById("role-selector").style.display = "block";
    document.getElementById("form-workhand").style.display = "none";
    document.getElementById("form-company").style.display = "none";
    document.getElementById("message").style.display = "none";
    document.querySelectorAll(".role-card").forEach((c) => c.classList.remove("selected"));
}

// ─── Image Preview ─────────────────────────────────────────────────────────
function previewImg(input, previewId) {
    const preview = document.getElementById(previewId);
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = (e) => {
            preview.innerHTML = '<img src="' + e.target.result
                + '" style="width:100%;height:100%;object-fit:cover;">';
        };
        reader.readAsDataURL(input.files[0]);
    }
}

// ─── AJAX Form Submission (handles both forms) ─────────────────────────────
document.addEventListener("DOMContentLoaded", function () {
    const messageDiv = document.getElementById("message");

    ["registerFormWorkhand", "registerFormCompany"].forEach((formId) => {
        const form = document.getElementById(formId);
        if (!form) return;

        form.addEventListener("submit", function (e) {
            e.preventDefault();

            const isCompany = formId === "registerFormCompany";
            const btn = document.getElementById(isCompany ? "btnCompany" : "btnWorkhand");

            const formData = new FormData(form);

            showMsg("info", "Registering your account…");
            btn.disabled = true;
            btn.textContent = "Please wait…";

            fetch(form.action, {
                method: "POST",
                body: formData,
            })
                .then((r) => r.json())
                .then((result) => {
                    btn.disabled = false;
                    btn.textContent = isCompany ? "REGISTER AS COMPANY" : "REGISTER AS WORKHAND";

                    if (result.success) {
                        showMsg(
                            "success",
                            result.message +
                                " <br><small>A temporary password has been sent to your email. Redirecting to login…</small>"
                        );
                        setTimeout(() => {
                            window.location.href = result.redirectUrl;
                        }, 3000);
                    } else {
                        showMsg("danger", result.message || "Registration failed. Please try again.");
                    }
                })
                .catch(() => {
                    btn.disabled = false;
                    btn.textContent = isCompany ? "REGISTER AS COMPANY" : "REGISTER AS WORKHAND";
                    showMsg("danger", "An unexpected error occurred. Please try again.");
                });
        });
    });
});

function showMsg(type, html) {
    const div = document.getElementById("message");
    div.innerHTML = '<div class="alert alert-' + type + '">' + html + "</div>";
    div.style.display = "block";
    div.scrollIntoView({ behavior: "smooth", block: "nearest" });
}
