<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"><strong>Register</strong> Page</h2>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="<c:url value='/login' />" class="breadcrumb-link">Login</a></li>
                                <li class="breadcrumb-item active"><a href="#" aria-current="page">Register</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="contact-section" class="contact-section sec-ptb-100 clearfix">
    <div class="container">
        <div class="section-title mb-40">
            <small class="sub-title">Create Account</small>
            <h5 class="big-title">HAVE AN ACCOUNT?
                <strong><a href="<c:url value='/login' />" style="color:#ff8a00;"> Login</a></strong> Now
            </h5>
        </div>

        <div class="contact-form form-wrapper">

            <div id="message" style="display:none;"></div>

            <!-- ── Step 1: Choose Role ── -->
            <div id="role-selector" class="text-center mb-40">
                <p style="font-size:17px;color:#555;margin-bottom:22px;">
                    I am registering as a…
                </p>
                <div class="d-flex justify-content-center" style="gap:24px;flex-wrap:wrap;">

                    <div id="card-workhand" class="role-card" onclick="selectRole(1)"
                         style="cursor:pointer;border:2px solid #e0e0e0;border-radius:12px;padding:28px 36px;
                                min-width:200px;transition:all .25s;background:#fff;">
                        <div style="font-size:48px;margin-bottom:10px;">&#128736;</div>
                        <h4 style="margin:0 0 6px;color:#333;">Workhand</h4>
                        <p style="color:#888;font-size:13px;margin:0;">Individual worker / freelancer</p>
                    </div>

                    <div id="card-company" class="role-card" onclick="selectRole(2)"
                         style="cursor:pointer;border:2px solid #e0e0e0;border-radius:12px;padding:28px 36px;
                                min-width:200px;transition:all .25s;background:#fff;">
                        <div style="font-size:48px;margin-bottom:10px;">&#127970;</div>
                        <h4 style="margin:0 0 6px;color:#333;">Company</h4>
                        <p style="color:#888;font-size:13px;margin:0;">Business / event organiser</p>
                    </div>

                </div>
            </div>

            <!-- ── WORKHAND Form (roleId = 1) ── -->
            <div id="form-workhand" style="display:none;">
                <div class="text-center mb-30">
                    <h3 style="color:#ff8a00;">Workhand Registration</h3>
                    <a href="#" onclick="resetRole();return false;" style="color:#888;font-size:13px;">
                        &larr; Choose a different role
                    </a>
                </div>
                <form id="registerFormWorkhand" action="<c:url value='/register' />" method="post"
                      enctype="multipart/form-data">
                    <input type="hidden" name="roleId" value="1">
                    <div class="row">

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="text" name="username" placeholder="Username *" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="email" name="email" placeholder="Email Address *" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="text" name="firstName" placeholder="First Name *" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="text" name="lastName" placeholder="Last Name * hidden" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="tel" name="contactNumber" placeholder="Contact Number (10-digit phone) *"
                                       pattern="[0-9]{10}" title="Enter a 10-digit phone number" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="text" name="streetAddress" placeholder="Street Address *" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <select name="stateId" id="stateId-wh" required onchange="loadCities(this,'cityId-wh')"
                                        style="width:100%;padding:14px;border:1px solid #e0e0e0;border-radius:4px;font-size:14px;color:#555;">
                                    <option value="">Select State *</option>
                                    <c:forEach var="st" items="${states}">
                                        <option value="${st.id}">${st.stateName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <select name="cityId" id="cityId-wh" required
                                        style="width:100%;padding:14px;border:1px solid #e0e0e0;border-radius:4px;font-size:14px;color:#555;">
                                    <option value="">Select City *</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-item">
                                <label style="display:block;text-align:center;margin-bottom:10px;">Profile Picture <span style="color:red">*</span> <small style="color:#888;font-weight:normal;">(PNG or JPG)</small></label>
                                <!-- Preview box -->
                                <div id="preview-workhand"
                                     style="width:110px;height:110px;border-radius:50%;border:2px dashed #ccc;
                                            margin:10px auto;overflow:hidden;display:flex;align-items:center;
                                            justify-content:center;background:#f5f5f5;color:#bbb;font-size:13px;">
                                    Preview
                                </div>
                                <input class="p-2" type="file" name="profilePhoto"
                                       accept="image/png,image/jpeg" required
                                       onchange="previewImg(this,'preview-workhand')">
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12 text-center mt-20">
                            <button type="submit" id="btnWorkhand" class="custom-btn">REGISTER AS WORKHAND</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- ── COMPANY Form (roleId = 2) ── -->
            <div id="form-company" style="display:none;">
                <div class="text-center mb-30">
                    <h3 style="color:#ff8a00;">Company Registration</h3>
                    <a href="#" onclick="resetRole();return false;" style="color:#888;font-size:13px;">
                        &larr; Choose a different role
                    </a>
                </div>
                <form id="registerFormCompany" action="<c:url value='/register' />" method="post"
                      enctype="multipart/form-data">
                    <input type="hidden" name="roleId" value="2">
                    <!-- Company name is sent as firstName; lastName left empty for backend trim -->
                    <input type="hidden" name="lastName" value="">
                    <div class="row">

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="text" name="username" placeholder="Username *" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="email" name="email" placeholder="Email Address *" required>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-item">
                                <input type="text" name="firstName" placeholder="Company Name (Full legal company name) *" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="tel" name="contactNumber" placeholder="Contact Number (10-digit phone) *"
                                       pattern="[0-9]{10}" title="Enter a 10-digit phone number" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <input type="text" name="streetAddress" placeholder="Street Address *" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <select name="stateId" id="stateId-co" required onchange="loadCities(this,'cityId-co')"
                                        style="width:100%;padding:14px;border:1px solid #e0e0e0;border-radius:4px;font-size:14px;color:#555;">
                                    <option value="">Select State *</option>
                                    <c:forEach var="st" items="${states}">
                                        <option value="${st.id}">${st.stateName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <select name="cityId" id="cityId-co" required
                                        style="width:100%;padding:14px;border:1px solid #e0e0e0;border-radius:4px;font-size:14px;color:#555;">
                                    <option value="">Select City *</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-item">
                                <textarea name="specialCategory" rows="4"
                                          placeholder="Company Description (Brief description of your company, services, specialties…)"
                                          style="width:100%;padding:14px;border:1px solid #e0e0e0;border-radius:6px;
                                                 resize:vertical;font-family:inherit;font-size:14px;"></textarea>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-item">
                                <label style="display:block;text-align:center;margin-bottom:10px;">Company Logo <span style="color:red">*</span> <small style="color:#888;font-weight:normal;">(PNG or JPG)</small></label>
                                <!-- Preview box -->
                                <div id="preview-company"
                                     style="width:140px;height:140px;border-radius:8px;border:2px dashed #ccc;
                                            margin:10px auto;overflow:hidden;display:flex;align-items:center;
                                            justify-content:center;background:#f5f5f5;color:#bbb;font-size:13px;">
                                    Preview
                                </div>
                                <input class="p-2" type="file" name="profilePhoto"
                                       accept="image/png,image/jpeg" required
                                       onchange="previewImg(this,'preview-company')">
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12 text-center mt-20">
                            <button type="submit" id="btnCompany" class="custom-btn">REGISTER AS COMPANY</button>
                        </div>
                    </div>
                </form>
            </div>

        </div><!-- /.form-wrapper -->
    </div>
</section>

<style>
.role-card:hover, .role-card.selected {
    border-color: #ff8a00 !important;
    box-shadow: 0 4px 16px rgba(255,138,0,.18);
    transform: translateY(-3px);
}
.mt-20 { margin-top: 20px; }
.mb-40 { margin-bottom: 40px; }
.mb-30 { margin-bottom: 30px; }
</style>

<script>
var _ctxPath = '${pageContext.request.contextPath}';
function loadCities(stateSelect, citySelectId) {
    var stateId = stateSelect.value;
    var citySelect = document.getElementById(citySelectId);
    citySelect.innerHTML = '<option value="">Loading cities…</option>';
    if (!stateId) {
        citySelect.innerHTML = '<option value="">Select City *</option>';
        return;
    }
    fetch(_ctxPath + '/location/cities/' + stateId)
        .then(function(r) {
            if (!r.ok) throw new Error('HTTP ' + r.status);
            return r.json();
        })
        .then(function(cities) {
            citySelect.innerHTML = '<option value="">Select City *</option>';
            if (cities.length === 0) {
                citySelect.innerHTML = '<option value="">No cities found</option>';
                return;
            }
            cities.forEach(function(c) {
                var opt = document.createElement('option');
                opt.value = c.id;
                opt.textContent = c.name;
                citySelect.appendChild(opt);
            });
        })
        .catch(function(err) {
            citySelect.innerHTML = '<option value="">Error loading cities</option>';
            console.error('City load failed:', err);
        });
}
</script>
<script src="<c:url value='/assets/custom/login/register.js' />"></script>