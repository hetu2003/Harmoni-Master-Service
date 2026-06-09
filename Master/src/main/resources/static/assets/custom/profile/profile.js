document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("profileUpdateForm");
    if (!form) return;

    form.addEventListener("submit", function (e) {
        e.preventDefault();

        const btn = document.getElementById("updateBtn");
        btn.disabled = true;
        btn.textContent = "Saving…";

        const formData = new FormData(form);

        fetch(getCtx() + "/profile/update", {
            method: "POST",
            body: formData,
        })
            .then((r) => r.json())
            .then((result) => {
                btn.disabled = false;
                btn.textContent = "SAVE CHANGES";
                showMsg(result.success ? "success" : "danger", result.message);
                if (result.success) {
                    window.scrollTo({ top: 0, behavior: "smooth" });
                }
            })
            .catch(() => {
                btn.disabled = false;
                btn.textContent = "SAVE CHANGES";
                showMsg("danger", "An unexpected error occurred. Please try again.");
            });
    });
});

function previewProfileImg(input, previewId) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = (e) => {
            const el = document.getElementById(previewId);
            if (el) {
                el.src = e.target.result;
                el.style.display = "block";
            }
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function showMsg(type, text) {
    const div = document.getElementById("message");
    if (!div) return;
    div.innerHTML = '<div class="alert alert-' + type + '">' + text + "</div>";
    div.style.display = "block";
    div.scrollIntoView({ behavior: "smooth", block: "nearest" });
}

function getCtx() {
    const scripts = document.querySelectorAll("script[src]");
    for (const s of scripts) {
        const m = s.src.match(/^(https?:\/\/[^/]+)(\/[^/]+)?\/assets\/custom\/profile\/profile\.js/);
        if (m) return m[2] || "";
    }
    return "";
}
