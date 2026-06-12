/**
 * addEvent.js
 * Handles dynamic workhand slot management, AJAX subcategory / city loading,
 * and date validation for the Add Event and Edit Event forms.
 */

// ─── DOM READY ───────────────────────────────────────────────────────────────

document.addEventListener('DOMContentLoaded', function () {

    var catSelect   = document.getElementById('catSelect');
    var stateSelect = document.getElementById('stateSelect');

    // Subcategory: reload when category changes
    if (catSelect) {
        catSelect.addEventListener('change', function () {
            if (this.value) loadSubcategories(this.value, null);
        });
    }

    // City: reload when state changes
    if (stateSelect) {
        stateSelect.addEventListener('change', function () {
            if (this.value) loadCities(this.value, null);
        });
    }

    // Date validation on submit
    var form = document.getElementById('addEventForm') || document.getElementById('editEventForm');
    if (form) {
        form.addEventListener('submit', function (e) {
            var start = document.getElementById('startDatetime');
            var end   = document.getElementById('endDatetime');
            if (start && end && start.value && end.value) {
                if (new Date(end.value) <= new Date(start.value)) {
                    e.preventDefault();
                    end.classList.add('is-invalid');
                    end.focus();
                    return;
                }
                end.classList.remove('is-invalid');
            }
            var btn = document.getElementById('submitBtn');
            if (btn) btn.disabled = true;
        });
    }

    // ── Slot initialisation (add form) ───────────────────────────────────────
    var slotContainer = document.getElementById('slotContainer');
    if (slotContainer && typeof WORKHAND_CATS !== 'undefined') {
        if (typeof PREFILL_SLOTS !== 'undefined' && PREFILL_SLOTS && PREFILL_SLOTS.length > 0) {
            // Restore slots after a validation error
            PREFILL_SLOTS.forEach(function (s) {
                addSlotRow(s.catId, s.num, s.price);
            });
        } else if (slotContainer.querySelectorAll('.slot-row').length === 0) {
            addSlotRow(); // fresh form: one empty slot
        }
    }

    // ── Pre-reload subcategory + city after validation error ─────────────────
    if (typeof PREFILL_CAT !== 'undefined' && PREFILL_CAT) {
        loadSubcategories(PREFILL_CAT, typeof PREFILL_SUBCAT !== 'undefined' ? PREFILL_SUBCAT : null);
    }
    if (typeof PREFILL_STATE !== 'undefined' && PREFILL_STATE) {
        loadCities(PREFILL_STATE, typeof PREFILL_CITY !== 'undefined' ? PREFILL_CITY : null);
    }
});

// ─── SLOT MANAGEMENT ─────────────────────────────────────────────────────────

/**
 * Appends a new workhand role slot row to #slotContainer.
 * Optional catId, num, price pre-fill the row (used on validation reload).
 */
function addSlotRow(catId, num, price) {
    var container = document.getElementById('slotContainer');
    if (!container) return;

    var options = '<option value="" disabled' + (catId ? '' : ' selected') + '>-- Select Role --</option>';
    if (typeof WORKHAND_CATS !== 'undefined') {
        WORKHAND_CATS.forEach(function (cat) {
            var sel = (catId && cat.id == catId) ? ' selected' : '';
            options += '<option value="' + cat.id + '"' + sel + '>' + cat.name + '</option>';
        });
    }

    var row = document.createElement('div');
    row.className = 'slot-row row mb-2 align-items-center';
    row.innerHTML =
        '<div class="col-md-5">' +
            '<select class="form-control" name="workhand_category_ids" required>' +
                options +
            '</select>' +
        '</div>' +
        '<div class="col-md-3">' +
            '<input type="number" class="form-control" name="workhand_numbers"' +
                   ' placeholder="No. of people" min="1" required' +
                   (num ? ' value="' + num + '"' : '') + '>' +
        '</div>' +
        '<div class="col-md-3">' +
            '<input type="number" class="form-control" name="prices"' +
                   ' placeholder="Price (&#8377;)" step="0.01" min="0" required' +
                   (price ? ' value="' + price + '"' : '') + '>' +
        '</div>' +
        '<div class="col-md-1 text-center">' +
            '<button type="button" class="btn btn-sm btn-outline-danger" onclick="removeSlotRow(this)" title="Remove">' +
                '<i class="fas fa-times"></i>' +
            '</button>' +
        '</div>';

    container.appendChild(row);
}

/** Removes the slot row containing the given button. Keeps minimum 1 row. */
function removeSlotRow(btn) {
    var container = document.getElementById('slotContainer');
    if (container && container.querySelectorAll('.slot-row').length <= 1) {
        alert('At least one workhand role is required.');
        return;
    }
    btn.closest('.slot-row').remove();
}

// ─── AJAX: load subcategories ─────────────────────────────────────────────────

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
                if (selectedSubcatId && item.id == selectedSubcatId) opt.selected = true;
                subcatSelect.appendChild(opt);
            });
        })
        .catch(function (err) { console.error('Subcategory load failed', err); });
}

// ─── AJAX: load cities ────────────────────────────────────────────────────────

function loadCities(stateId, selectedCityId) {
    var citySelect = document.getElementById('citySelect');
    if (!citySelect) return;

    /* Edit page: SELECTED_CITY_ID is set server-side; use once then clear */
    if (!selectedCityId && typeof SELECTED_CITY_ID !== 'undefined' && SELECTED_CITY_ID) {
        selectedCityId   = SELECTED_CITY_ID;
        SELECTED_CITY_ID = null;
    }

    fetch(CTX + '/get-city?state_id=' + stateId)
        .then(function (r) { return r.json(); })
        .then(function (data) {
            citySelect.innerHTML = '<option value="" disabled selected>-- Choose City --</option>';
            data.forEach(function (item) {
                var opt = document.createElement('option');
                opt.value       = item.id;
                opt.textContent = item.name;
                if (selectedCityId && item.id == selectedCityId) opt.selected = true;
                citySelect.appendChild(opt);
            });
        })
        .catch(function (err) { console.error('City load failed', err); });
}

// ─── generateSlots (kept for backward compatibility with edit-event.jsp) ─────

function generateSlots(n) {
    n = parseInt(n);
    if (isNaN(n) || n < 1) {
        document.getElementById('slotContainer').innerHTML = '';
        return;
    }
    if (n > 20) n = 20;
    var container = document.getElementById('slotContainer');

    // Save current values before rebuilding
    var existing = container.querySelectorAll('.slot-row');
    var saved = [];
    existing.forEach(function (row) {
        var catEl   = row.querySelector('select[name="workhand_category_ids"]') || row.querySelector('.wh-cat');
        var numEl   = row.querySelector('input[name="workhand_numbers"]')       || row.querySelector('.wh-num');
        var priceEl = row.querySelector('input[name="prices"]')                 || row.querySelector('.wh-price');
        saved.push({
            cat:   catEl   ? catEl.value   : '',
            num:   numEl   ? numEl.value   : '',
            price: priceEl ? priceEl.value : ''
        });
    });
    container.innerHTML = '';

    if (typeof WORKHAND_CATS !== 'undefined' && WORKHAND_CATS.length > 0) {
        for (var i = 0; i < n; i++) {
            addSlotRow(
                saved[i] ? saved[i].cat   : null,
                saved[i] ? saved[i].num   : null,
                saved[i] ? saved[i].price : null
            );
        }
        return;
    }

    // Fallback plain inputs for pages without WORKHAND_CATS
    for (var i = 0; i < n; i++) {
        var row = document.createElement('div');
        row.className = 'slot-row row mb-2 align-items-center';
        row.innerHTML =
            '<div class="col-4"><input type="number" class="form-control wh-cat" name="workhand_category_ids"' +
                ' placeholder="Cat #" min="1" required' + (saved[i] ? ' value="' + saved[i].cat + '"' : '') + '></div>' +
            '<div class="col-4"><input type="number" class="form-control wh-num" name="workhand_numbers"' +
                ' placeholder="Count" min="1" required' + (saved[i] ? ' value="' + saved[i].num + '"' : '') + '></div>' +
            '<div class="col-4"><input type="number" class="form-control wh-price" name="prices"' +
                ' placeholder="Price" step="0.01" min="0" required' + (saved[i] ? ' value="' + saved[i].price + '"' : '') + '></div>';
        container.appendChild(row);
    }
}
