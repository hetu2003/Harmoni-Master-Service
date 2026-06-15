<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"><strong>Company</strong> Profile</h2>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="<c:url value='/home' />" class="breadcrumb-link">Home</a></li>
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
            <small class="sub-title">Company Account</small>
            <h2 class="big-title">Edit Your Company Profile</h2>
        </div>

        <div class="contact-form form-wrapper">

            <div id="message" style="display:none;"></div>

            <div class="text-center mb-30">
                <div style="display:inline-block;position:relative;">
                    <c:choose>
                        <c:when test="${not empty user.profilePath}">
                            <img id="logoPreview"
                                 src="${pageContext.request.contextPath}${user.profilePath}"
                                 alt="Company Logo"
                                 style="width:140px;height:140px;object-fit:cover;border-radius:10px;
                                        border:4px solid #ff8a00;display:block;">
                        </c:when>
                        <c:otherwise>
                            <div id="logoPlaceholder"
                                 style="width:140px;height:140px;border-radius:10px;border:3px dashed #ccc;
                                        display:flex;align-items:center;justify-content:center;
                                        background:#f9f9f9;color:#bbb;font-size:13px;margin:0 auto;">
                                No Logo
                            </div>
                            <img id="logoPreview" src="" alt=""
                                 style="display:none;width:140px;height:140px;
                                        object-fit:cover;border-radius:10px;border:4px solid #ff8a00;">
                        </c:otherwise>
                    </c:choose>
                    <label for="profilePhoto"
                           style="position:absolute;bottom:0;right:0;background:#ff8a00;color:#fff;
                                  border-radius:50%;width:32px;height:32px;display:flex;align-items:center;
                                  justify-content:center;cursor:pointer;font-size:16px;"
                           title="Change logo">&#9998;</label>
                </div>
                <p style="color:#888;font-size:13px;margin-top:8px;">Company Logo</p>
            </div>

            <form id="profileUpdateForm" enctype="multipart/form-data">
                <div class="row">

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input type="text" id="name" name="name" value="${user.name}" placeholder="Company Name *" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input type="tel" id="contactNumber" name="contactNumber"
                                   value="${user.contactNumber}" pattern="[0-9]{10}"
                                   title="10-digit phone number" placeholder="Contact Number *" required>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <input type="text" id="streetAddress" name="streetAddress"
                                   value="${user.streetAddress}" placeholder="Street Address *" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <select id="stateId" name="stateId" required
                                    onchange="loadCities(this,'cityId')"
                                    style="width:100%; height:50px; padding:0 20px; border:1px solid #e0e0e0; border-radius:4px; font-family:inherit; font-size:14px; color:#555;">
                                <option value="" disabled selected>Select State *</option>
                                <c:forEach var="state" items="${states}">
                                    <option value="${state.id}" <c:if test="${state.id == user.stateId}">selected</c:if>>${state.stateName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <select id="cityId" name="cityId" required style="width:100%; height:50px; padding:0 20px; border:1px solid #e0e0e0; border-radius:4px; font-family:inherit; font-size:14px; color:#555;">
                                <option value="" disabled selected>Select City *</option>
                                <c:forEach var="city" items="${cities}">
                                    <option value="${city.id}" <c:if test="${city.id == user.cityId}">selected</c:if>>${city.cityName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <textarea id="companyDescription" name="companyDescription" rows="5"
                                      placeholder="Company Description"
                                      style="width:100%;padding:14px;border:1px solid #e0e0e0;
                                             border-radius:6px;resize:vertical;font-family:inherit;
                                             font-size:14px;">${user.companyDescription}</textarea>
                        </div>
                    </div>

                    <input type="file" id="profilePhoto" name="profilePhoto"
                           accept="image/png,image/jpeg" style="display:none;"
                           onchange="previewProfileImg(this,'logoPreview')">

                    <div class="col-lg-12 col-md-12 col-sm-12 d-flex justify-content-between align-items-center mt-20"
                         style="flex-wrap:wrap;gap:12px;">
                        <a href="<c:url value='/change-password' />" class="custom-btn">CHANGE PASSWORD</a>
                        <button type="submit" id="updateBtn" class="custom-btn">SAVE CHANGES</button>
                    </div>

                </div>
            </form>
        </div>
    </div>
</section>

<style>.mt-20{margin-top:20px;}.mb-30{margin-bottom:30px;}.mb-40{margin-bottom:40px;}</style>
<script src="<c:url value='/assets/custom/profile/profile.js' />"></script>