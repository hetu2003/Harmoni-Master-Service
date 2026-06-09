document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("resetPasswordForm");
    const newPwInput = document.getElementById("newPassword");

    if (newPwInput) {
        newPwInput.addEventListener("input", updateStrength);
    }

    if (form) {
        form.addEventListener("submit", function (e) {
            e.preventDefault();

            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const token = document.getElementById("resetToken").value;

            if (newPassword !== confirmPassword) {
                showMsg("danger", "Passwords do not match. Please try again.");
                return;
            }
            if (newPassword.length < 8) {
                showMsg("danger", "Password must be at least 8 characters.");
                return;
            }

            const btn = document.getElementById("resetBtn");
            btn.disabled = true;
            btn.textContent = "Resetting…";

            // Use standard form-urlencoded POST so Spring @ModelAttribute binds correctly
            fetch(getCtx() + "/reset-password", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "token=" + encodeURIComponent(token)
                    + "&newPassword=" + encodeURIComponent(newPassword),
                redirect: "follow",
            })
                .then((r) => {
                    btn.disabled = false;
                    btn.textContent = "RESET PASSWORD";
                    // If redirect went to /login it succeeded
                    if (r.url && r.url.includes("/login")) {
                        showMsg("success", "Password reset successfully! Redirecting to login…");
                        setTimeout(() => (window.location.href = r.url), 2000);
                    } else {
                        showMsg("success", "Password reset successfully! Redirecting…");
                        setTimeout(() => (window.location.href = getCtx() + "/login"), 2000);
                    }
                })
                .catch(() => {
                    btn.disabled = false;
                    btn.textContent = "RESET PASSWORD";
                    showMsg("danger", "An unexpected error occurred. Please try again.");
                });
        });
    }
});

function updateStrength() {
    const pw = document.getElementById("newPassword").value;
    const fill = document.getElementById("strengthFill");
    let score = 0;
    if (pw.length >= 8) score++;
    if (/[A-Z]/.test(pw)) score++;
    if (/[0-9]/.test(pw)) score++;
    if (/[^A-Za-z0-9]/.test(pw)) score++;
    const colors = ["#eee", "#e53935", "#fb8c00", "#43a047", "#1b5e20"];
    const pcts = ["0%", "25%", "50%", "75%", "100%"];
    fill.style.width = pcts[score];
    fill.style.background = colors[score];
}

function togglePw(id) {
    const el = document.getElementById(id);
    el.type = el.type === "password" ? "text" : "password";
}

function showMsg(type, text) {
    const div = document.getElementById("message");
    div.innerHTML = '<div class="alert alert-' + type + '">' + text + "</div>";
    div.style.display = "block";
    div.scrollIntoView({ behavior: "smooth", block: "nearest" });
}

function getCtx() {
    const scripts = document.querySelectorAll("script[src]");
    for (const s of scripts) {
        const m = s.src.match(/^(https?:\/\/[^/]+)(\/[^/]+)?\/assets\/custom\/login\/reset-password\.js/);
        if (m) return m[2] || "";
    }
    return "";
}
