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
                                <label>Username <span style="color:red">*</span></label>
                                <input type="text" name="username" placeholder="Choose a username" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>Email Address <span style="color:red">*</span></label>
                                <input type="email" name="email" placeholder="your@email.com" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>First Name <span style="color:red">*</span></label>
                                <input type="text" name="firstName" placeholder="First name" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>Last Name <span style="color:red">*</span></label>
                                <input type="text" name="lastName" placeholder="Last name" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>Contact Number <span style="color:red">*</span></label>
                                <input type="tel" name="contactNumber" placeholder="10-digit phone"
                                       pattern="[0-9]{10}" title="Enter a 10-digit phone number" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>Street Address <span style="color:red">*</span></label>
                                <input type="text" name="streetAddress" placeholder="Street address" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>State ID <span style="color:red">*</span></label>
                                <input type="number" name="stateId" placeholder="e.g. 1" min="1" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>City ID <span style="color:red">*</span></label>
                                <input type="number" name="cityId" placeholder="e.g. 1" min="1" required>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-item">
                                <label>Profile Picture <span style="color:red">*</span>
                                    <small style="color:#888;font-weight:normal;">(PNG or JPG)</small>
                                </label>
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
                                <label>Username <span style="color:red">*</span></label>
                                <input type="text" name="username" placeholder="Choose a username" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>Email Address <span style="color:red">*</span></label>
                                <input type="email" name="email" placeholder="company@email.com" required>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-item">
                                <label>Company Name <span style="color:red">*</span></label>
                                <input type="text" name="firstName" placeholder="Full legal company name" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>Contact Number <span style="color:red">*</span></label>
                                <input type="tel" name="contactNumber" placeholder="10-digit phone"
                                       pattern="[0-9]{10}" title="Enter a 10-digit phone number" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>Street Address <span style="color:red">*</span></label>
                                <input type="text" name="streetAddress" placeholder="Street address" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>State ID <span style="color:red">*</span></label>
                                <input type="number" name="stateId" placeholder="e.g. 1" min="1" required>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-item">
                                <label>City ID <span style="color:red">*</span></label>
                                <input type="number" name="cityId" placeholder="e.g. 1" min="1" required>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-item">
                                <label>Company Description</label>
                                <textarea name="specialCategory" rows="4"
                                          placeholder="Brief description of your company, services, specialties…"
                                          style="width:100%;padding:14px;border:1px solid #e0e0e0;border-radius:6px;
                                                 resize:vertical;font-family:inherit;font-size:14px;"></textarea>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-item">
                                <label>Company Logo <span style="color:red">*</span>
                                    <small style="color:#888;font-weight:normal;">(PNG or JPG)</small>
                                </label>
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

<script src="<c:url value='/assets/custom/login/register.js' />"></script>
