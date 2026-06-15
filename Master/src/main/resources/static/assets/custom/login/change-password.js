document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("changePasswordForm");
    const newPwInput = document.getElementById("newPassword");

    if (newPwInput) {
        newPwInput.addEventListener("input", updateStrength);
    }

    if (form) {
        form.addEventListener("submit", function (e) {
            e.preventDefault();

            const username = document.getElementById("username").value.trim();
            const oldPassword = document.getElementById("oldPassword").value;
            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            if (newPassword !== confirmPassword) {
                showMsg("danger", "New passwords do not match.");
                return;
            }
            if (newPassword.length < 8) {
                showMsg("danger", "New password must be at least 8 characters.");
                return;
            }

            const btn = document.getElementById("submitBtn");
            btn.disabled = true;
            btn.textContent = "Updating…";

            fetch(getCtx() + "/change-password", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ username, oldPassword, newPassword }),
            })
                .then((r) => r.json())
                .then((result) => {
                    btn.disabled = false;
                    btn.textContent = "CHANGE PASSWORD";
                    if (result.success) {
                        showMsg("success", result.message + " Redirecting to home…");
                        setTimeout(() => (window.location.href = getCtx() + "/home"), 2000);
                    } else {
                        showMsg("danger", result.message || "Failed to change password.");
                    }
                })
                .catch(() => {
                    btn.disabled = false;
                    btn.textContent = "CHANGE PASSWORD";
                    showMsg("danger", "An unexpected error occurred. Please try again.");
                });
        });
    }
});

function updateStrength() {
    const pw = document.getElementById("newPassword").value;
    const fill = document.getElementById("strengthFill");
    const label = document.getElementById("strengthLabel");
    let score = 0;
    if (pw.length >= 8) score++;
    if (/[A-Z]/.test(pw)) score++;
    if (/[0-9]/.test(pw)) score++;
    if (/[^A-Za-z0-9]/.test(pw)) score++;

    const levels = [
        { pct: "0%", color: "#eee", text: "" },
        { pct: "25%", color: "#e53935", text: "Weak" },
        { pct: "50%", color: "#fb8c00", text: "Fair" },
        { pct: "75%", color: "#43a047", text: "Good" },
        { pct: "100%", color: "#1b5e20", text: "Strong" },
    ];
    const l = levels[score];
    fill.style.width = l.pct;
    fill.style.background = l.color;
    label.textContent = l.text;
    label.style.color = l.color;
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
        const m = s.src.match(/^(https?:\/\/[^/]+)(\/[^/]+)?\/assets\/custom\/login\/change-password\.js/);
        if (m) return m[2] || "";
    }
    return "";
}
