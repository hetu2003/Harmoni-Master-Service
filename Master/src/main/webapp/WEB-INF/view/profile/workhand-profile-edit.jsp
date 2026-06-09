<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"><strong>Edit</strong> Your Profile</h2>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="<c:url value='/dashboard' />" class="breadcrumb-link">Dashboard</a></li>
                                <li class="breadcrumb-item active"><a href="#" aria-current="page">Edit Profile</a></li>
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
            <small class="sub-title">My Account</small>
            <h2 class="big-title">Edit Your Profile</h2>
        </div>

        <div class="contact-form form-wrapper">

            <div id="message" style="display:none;"></div>

            <!-- Current Profile Picture -->
            <div class="text-center mb-30">
                <div style="display:inline-block;position:relative;">
                    <c:choose>
                        <c:when test="${not empty user.profilePath}">
                            <img id="profilePreview" src="${user.profilePath}" alt="Profile Picture"
                                 style="width:110px;height:110px;object-fit:cover;border-radius:50%;
                                        border:3px solid #ff8a00;">
                        </c:when>
                        <c:otherwise>
                            <div id="profilePlaceholder"
                                 style="width:110px;height:110px;border-radius:50%;border:3px dashed #ccc;
                                        display:flex;align-items:center;justify-content:center;
                                        background:#f9f9f9;color:#bbb;font-size:13px;margin:0 auto;">
                                No Photo
                            </div>
                            <img id="profilePreview" src="" alt="" style="display:none;width:110px;height:110px;
                                 object-fit:cover;border-radius:50%;border:3px solid #ff8a00;">
                        </c:otherwise>
                    </c:choose>
                    <label for="profilePhoto"
                           style="position:absolute;bottom:0;right:0;background:#ff8a00;color:#fff;
                                  border-radius:50%;width:30px;height:30px;display:flex;align-items:center;
                                  justify-content:center;cursor:pointer;font-size:15px;"
                           title="Change photo">&#9998;</label>
                </div>
                <p style="color:#888;font-size:13px;margin-top:8px;">Profile Picture</p>
            </div>

            <form id="profileUpdateForm" enctype="multipart/form-data">
                <div class="row">

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <label for="name">Full Name <span style="color:red">*</span></label>
                            <input type="text" id="name" name="name" value="${user.name}" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <label for="contactNumber">Contact Number <span style="color:red">*</span></label>
                            <input type="tel" id="contactNumber" name="contactNumber"
                                   value="${user.contactNumber}" pattern="[0-9]{10}"
                                   title="10-digit phone number" required>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <label for="streetAddress">Street Address <span style="color:red">*</span></label>
                            <input type="text" id="streetAddress" name="streetAddress"
                                   value="${user.streetAddress}" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <label for="stateId">State ID <span style="color:red">*</span></label>
                            <input type="number" id="stateId" name="stateId"
                                   value="${user.stateId}" min="1" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <label for="cityId">City ID <span style="color:red">*</span></label>
                            <input type="number" id="cityId" name="cityId"
                                   value="${user.cityId}" min="1" required>
                        </div>
                    </div>

                    <!-- Hidden file input triggered by edit icon above -->
                    <input type="file" id="profilePhoto" name="profilePhoto"
                           accept="image/png,image/jpeg" style="display:none;"
                           onchange="previewProfileImg(this,'profilePreview')">

                    <div class="col-lg-12 col-md-12 col-sm-12 d-flex justify-content-between align-items-center mt-20"
                         style="flex-wrap:wrap;gap:12px;">
                        <a href="<c:url value='/change-password' />" class="custom-btn"
                           style="background:#555;">CHANGE PASSWORD</a>
                        <button type="submit" id="updateBtn" class="custom-btn">SAVE CHANGES</button>
                    </div>

                </div>
            </form>
        </div>
    </div>
</section>

<style>.mt-20{margin-top:20px;}.mb-30{margin-bottom:30px;}.mb-40{margin-bottom:40px;}</style>
<script src="<c:url value='/assets/custom/profile/profile.js' />"></script>
