/**
 * addEvent.js
 * Handles dynamic workhand slot generation, AJAX subcategory / city loading,
 * and date validation for the Add Event and Edit Event forms.
 */

// ─── AJAX: load subcategories when category changes ──────────────────────────

document.addEventListener('DOMContentLoaded', function () {

    var catSelect    = document.getElementById('catSelect');
    var subcatSelect = document.getElementById('subcatSelect');
    var stateSelect  = document.getElementById('stateSelect');
    var citySelect   = document.getElementById('citySelect');

    if (catSelect) {
        catSelect.addEventListener('change', function () {
            var catId = this.value;
            if (!catId) return;
            loadSubcategories(catId);
        });
    }

    if (stateSelect) {
        stateSelect.addEventListener('change', function () {
            var stateId = this.value;
            if (!stateId) return;
            loadCities(stateId, null);
        });
    }

    // ── Date validation ─────────────────────────────────────────────────────
    var form = document.getElementById('addEventForm') || document.getElementById('editEventForm');
    if (form) {
        form.addEventListener('submit', function (e) {
            var start = document.getElementById('startDatetime');
            var end   = document.getElementById('endDatetime');
            if (start && end && end.value && start.value) {
                if (new Date(end.value) <= new Date(start.value)) {
                    e.preventDefault();
                    end.classList.add('is-invalid');
                    end.focus();
                    return;
                }
                end.classList.remove('is-invalid');
            }
            // Prevent double-submit
            var btn = document.getElementById('submitBtn');
            if (btn) btn.disabled = true;
        });
    }
});

// ─── AJAX: fetch subcategories for a given category ID ───────────────────────

function loadSubcategories(catId, selectedSubcatId) {
    var subcatSelect = document.getElementById('subcatSelect');
    if (!subcatSelect) return;

    fetch(CTX + '/vendor/get-subcat?cat_id=' + catId)
        .then(function (r) { return r.json(); })
        .then(function (data) {
            subcatSelect.innerHTML = '<option value="" disabled selected>-- Choose Subcategory --</option>';
            data.forEach(function (item) {
                var opt = document.createElement('option');
                opt.value       = item.id;
                opt.textContent = item.name;
                if (selectedSubcatId && item.id == selectedSubcatId) {
                    opt.selected = true;
                }
                subcatSelect.appendChild(opt);
            });
        })
        .catch(function (err) {
            console.error('Failed to load subcategories', err);
        });
}

// ─── AJAX: fetch cities for a given state ID ─────────────────────────────────

function loadCities(stateId, selectedCityId) {
    var citySelect = document.getElementById('citySelect');
    if (!citySelect) return;

    /* On edit page SELECTED_CITY_ID is set server-side; use it once, then clear */
    if (!selectedCityId && typeof SELECTED_CITY_ID !== 'undefined' && SELECTED_CITY_ID) {
        selectedCityId   = SELECTED_CITY_ID;
        SELECTED_CITY_ID = null; // consume once
    }

    fetch(CTX + '/get-city?state_id=' + stateId)
        .then(function (r) { return r.json(); })
        .then(function (data) {
            citySelect.innerHTML = '<option value="" disabled selected>-- Choose City --</option>';
            data.forEach(function (item) {
                var opt = document.createElement('option');
                opt.value       = item.id;
                opt.textContent = item.name;
                if (selectedCityId && item.id == selectedCityId) {
                    opt.selected = true;
                }
                citySelect.appendChild(opt);
            });
        })
        .catch(function (err) {
            console.error('Failed to load cities', err);
        });
}

// ─── Dynamic slot row generation ─────────────────────────────────────────────

/**
 * Generates N workhand-slot rows inside #slotContainer.
 * Each row has:
 *   - workhand_category_ids[]  (Integer — category number e.g. 1, 2, 3)
 *   - workhand_numbers[]       (Integer — how many of that category)
 *   - prices[]                 (BigDecimal — price per workhand for that slot)
 *
 * The names match @RequestParam lists in EventCrudController.
 */
function generateSlots(n) {
    n = parseInt(n);
    if (isNaN(n) || n < 1) {
        document.getElementById('slotContainer').innerHTML = '';
        return;
    }
    if (n > 20) n = 20;

    var container = document.getElementById('slotContainer');
    var existing  = container.querySelectorAll('.slot-row');

    /* Preserve values of rows already rendered */
    var saved = [];
    existing.forEach(function (row, i) {
        saved[i] = {
            cat:   row.querySelector('.wh-cat').value,
            num:   row.querySelector('.wh-num').value,
            price: row.querySelector('.wh-price').value
        };
    });

    /* Rebuild */
    container.innerHTML = '';

    /* Header labels (only when there are slots) */
    if (n > 0) {
        var header = document.createElement('div');
        header.className = 'row g-2 mb-1 fw-semibold text-muted small';
        header.innerHTML =
            '<div class="col-4">Category # <span class="text-danger">*</span></div>' +
            '<div class="col-4">No. of Workhands <span class="text-danger">*</span></div>' +
            '<div class="col-4">Price (&#8377;) <span class="text-danger">*</span></div>';
        container.appendChild(header);
    }

    for (var i = 0; i < n; i++) {
        var row = document.createElement('div');
        row.className = 'row g-2 mb-2 align-items-center slot-row';
        row.innerHTML =
            '<div class="col-4">' +
                '<input type="number" class="form-control wh-cat"' +
                       ' name="workhand_category_ids"' +
                       ' id="wh_cat_' + i + '"' +
                       ' placeholder="e.g. 1"' +
                       ' min="1" required>' +
            '</div>' +
            '<div class="col-4">' +
                '<input type="number" class="form-control wh-num"' +
                       ' name="workhand_numbers"' +
                       ' id="wh_num_' + i + '"' +
                       ' placeholder="e.g. 5"' +
                       ' min="1" required>' +
            '</div>' +
            '<div class="col-4">' +
                '<input type="number" class="form-control wh-price"' +
                       ' name="prices"' +
                       ' id="wh_price_' + i + '"' +
                       ' placeholder="e.g. 2000"' +
                       ' step="0.01" min="0" required>' +
            '</div>';
        container.appendChild(row);

        /* Restore saved values for previously-entered rows */
        if (saved[i]) {
            container.querySelector('#wh_cat_' + i).value   = saved[i].cat;
            container.querySelector('#wh_num_' + i).value   = saved[i].num;
            container.querySelector('#wh_price_' + i).value = saved[i].price;
        }
    }
}
