document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("forgotPasswordForm");
    if (!form) return;

    form.addEventListener("submit", function (e) {
        e.preventDefault();

        const email = document.getElementById("fpEmail").value.trim();
        const btn = document.getElementById("sendBtn");
        const messageDiv = document.getElementById("message");

        if (!email) {
            showMsg("danger", "Please enter your email address.");
            return;
        }

        btn.disabled = true;
        btn.textContent = "Sending…";
        messageDiv.style.display = "none";

        // Backend accepts form POST and redirects; we just need to trigger it.
        // Using fetch with form-urlencoded so Spring's @ModelAttribute binds correctly.
        fetch(getCtx() + "/forgot-password", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "email=" + encodeURIComponent(email),
            redirect: "follow",
        })
            .then(() => {
                btn.disabled = false;
                btn.textContent = "SEND RESET LINK";
                showSuccessState();
            })
            .catch(() => {
                btn.disabled = false;
                btn.textContent = "SEND RESET LINK";
                showMsg("danger", "An unexpected error occurred. Please try again.");
            });
    });
});

function showSuccessState() {
    document.getElementById("form-section").style.display = "none";
    document.getElementById("success-section").style.display = "block";
    document.getElementById("message").style.display = "none";
}

function showMsg(type, text) {
    const div = document.getElementById("message");
    div.innerHTML = '<div class="alert alert-' + type + '">' + text + "</div>";
    div.style.display = "block";
}

function getCtx() {
    const scripts = document.querySelectorAll("script[src]");
    for (const s of scripts) {
        const m = s.src.match(/^(https?:\/\/[^/]+)(\/[^/]+)?\/assets\/custom\/login\/forgot-password\.js/);
        if (m) return m[2] || "";
    }
    return "";
}
