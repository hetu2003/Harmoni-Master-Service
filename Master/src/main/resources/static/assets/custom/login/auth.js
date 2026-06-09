// ─── Username / Password AJAX Login ───────────────────────────────────────
document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById("loginForm");
    const messageDiv = document.getElementById("message");

    if (loginForm) {
        loginForm.addEventListener("submit", function (event) {
            event.preventDefault();

            const formData = new FormData(loginForm);
            const data = Object.fromEntries(formData.entries());

            messageDiv.innerHTML = '<div class="alert alert-info">Logging in...</div>';
            messageDiv.style.display = "block";

            fetch(loginForm.action, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data),
            })
                .then((r) => r.json())
                .then((result) => {
                    if (result.success) {
                        window.location.href = result.redirectUrl;
                    } else {
                        messageDiv.innerHTML =
                            '<div class="alert alert-danger">' + result.message + "</div>";
                    }
                })
                .catch(() => {
                    messageDiv.innerHTML =
                        '<div class="alert alert-danger">An unexpected error occurred. Please try again.</div>';
                });
        });
    }
});

// ─── Tab Switching ─────────────────────────────────────────────────────────
function switchLoginTab(tab) {
    const messageDiv = document.getElementById("message");
    messageDiv.style.display = "none";

    const panels = ["panel-password", "panel-otp"];
    const buttons = ["tab-password", "tab-otp"];

    panels.forEach((id) => {
        document.getElementById(id).style.display = id === "panel-" + tab ? "block" : "none";
    });
    buttons.forEach((id) => {
        const btn = document.getElementById(id);
        const isActive = id === "tab-" + tab;
        btn.style.background = isActive ? "" : "#555";
        if (isActive) {
            btn.classList.add("active-tab");
        } else {
            btn.classList.remove("active-tab");
        }
    });
}

// ─── Email OTP Flow ────────────────────────────────────────────────────────
function getContextPath() {
    // Derive context path from the current URL so hardcoding isn't needed
    const scripts = document.querySelectorAll("script[src]");
    for (const s of scripts) {
        const m = s.src.match(/^(https?:\/\/[^/]+)(\/[^/]+)?\/assets\/custom\/login\/auth\.js/);
        if (m) return m[2] || "";
    }
    return "";
}

function sendOtp() {
    const email = document.getElementById("otpEmail").value.trim();
    const messageDiv = document.getElementById("message");
    const btn = document.getElementById("sendOtpBtn");

    if (!email) {
        showMessage("danger", "Please enter your email address.");
        return;
    }

    btn.disabled = true;
    btn.textContent = "Sending…";
    messageDiv.style.display = "none";

    fetch(getContextPath() + "/login/email/send-otp", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: email }),
    })
        .then((r) => r.json())
        .then((result) => {
            btn.disabled = false;
            btn.textContent = "SEND OTP";
            if (result.success) {
                document.getElementById("otpEmailDisplay").textContent = email;
                document.getElementById("otp-step-email").style.display = "none";
                document.getElementById("otp-step-verify").style.display = "block";
                showMessage("success", result.message);
            } else {
                showMessage("danger", result.message || "Failed to send OTP.");
            }
        })
        .catch(() => {
            btn.disabled = false;
            btn.textContent = "SEND OTP";
            showMessage("danger", "An unexpected error occurred. Please try again.");
        });
}

function verifyOtp() {
    const email = document.getElementById("otpEmail").value.trim();
    const otp = document.getElementById("otpCode").value.trim();
    const messageDiv = document.getElementById("message");

    if (!otp || otp.length !== 6) {
        showMessage("danger", "Please enter the 6-digit OTP.");
        return;
    }

    showMessage("info", "Verifying OTP…");

    fetch(getContextPath() + "/login/email/verify-otp", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: email, otp: otp }),
    })
        .then((r) => r.json())
        .then((result) => {
            if (result.success) {
                window.location.href = result.redirectUrl;
            } else {
                showMessage("danger", result.message || "Invalid OTP. Please try again.");
                document.getElementById("otpCode").value = "";
            }
        })
        .catch(() => {
            showMessage("danger", "An unexpected error occurred. Please try again.");
        });
}

function resendOtp() {
    document.getElementById("otpCode").value = "";
    sendOtp();
}

function resetOtpFlow() {
    document.getElementById("otp-step-email").style.display = "block";
    document.getElementById("otp-step-verify").style.display = "none";
    document.getElementById("otpEmail").value = "";
    document.getElementById("otpCode").value = "";
    document.getElementById("message").style.display = "none";
}

function showMessage(type, text) {
    const div = document.getElementById("message");
    div.innerHTML = '<div class="alert alert-' + type + '">' + text + "</div>";
    div.style.display = "block";
}
