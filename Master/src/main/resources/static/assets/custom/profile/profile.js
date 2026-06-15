document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("profileUpdateForm");
    if (!form) return;

    form.addEventListener("submit", function (e) {
        e.preventDefault();

        const btn = document.getElementById("updateBtn");
        btn.disabled = true;
        btn.textContent = "Saving…";

        const formData = new FormData(form);
        const ctx = (typeof CTX_PATH !== "undefined" ? CTX_PATH : "");

        fetch(ctx + "/profile/update", {
            method: "POST",
            body: formData,
        })
            .then(function (r) { return r.json(); })
            .then(function (result) {
                if (result.success) {
                    showMsg("success", result.message + " Refreshing…");
                    setTimeout(function () { window.location.reload(); }, 1000);
                } else {
                    btn.disabled = false;
                    btn.textContent = "SAVE CHANGES";
                    showMsg("danger", result.message || "Update failed. Please try again.");
                }
            })
            .catch(function () {
                btn.disabled = false;
                btn.textContent = "SAVE CHANGES";
                showMsg("danger", "An unexpected error occurred. Please try again.");
            });
    });
});

function previewProfileImg(input, previewId) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function (e) {
            const el = document.getElementById(previewId);
            const placeholder = document.getElementById("profilePlaceholder") || document.getElementById("logoPlaceholder");
            if (el) {
                el.src = e.target.result;
                el.style.display = "block";
            }
            if (placeholder) {
                placeholder.style.display = "none";
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

function loadCities(stateSelect, citySelectId) {
    var stateId = stateSelect.value;
    var citySelect = document.getElementById(citySelectId);
    citySelect.innerHTML = '<option value="">Loading cities…</option>';
    if (!stateId) {
        citySelect.innerHTML = '<option value="" disabled selected>Select City *</option>';
        return;
    }
    var ctx = (typeof CTX_PATH !== "undefined" ? CTX_PATH : "");
    fetch(ctx + "/location/cities/" + stateId)
        .then(function (r) { if (!r.ok) throw new Error("HTTP " + r.status); return r.json(); })
        .then(function (cities) {
            citySelect.innerHTML = '<option value="" disabled selected>Select City *</option>';
            cities.forEach(function (c) {
                var opt = document.createElement("option");
                opt.value = c.id;
                opt.textContent = c.name;
                citySelect.appendChild(opt);
            });
        })
        .catch(function (err) {
            citySelect.innerHTML = '<option value="">Error loading cities</option>';
            console.error("City load failed:", err);
        });
}
