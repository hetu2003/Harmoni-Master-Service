<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 1. Alerts / Messages --%>
<c:if test="${not empty messages}">
    <c:forEach var="message" items="${messages}">
        <script>
            alert('${message}');
        </script>
    </c:forEach>
</c:if>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"> <strong>Register</strong> Page</h2>
                        </div>
                        <div class="breadcrumb-list">
                            <ul>
                                <li class="breadcrumb-item"><a href="<c:url value='/login' />" class="breadcrumb-link">Login</a></li>
                                <li class="breadcrumb-item active"> <a href="#" aria-current="page">Register</a></li>
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
        <div class="section-title mb-50">
            <small class="sub-title">Account Register</small>
            <h5 class="big-title">HAVE AN ACCOUNT ? <strong><a href="<c:url value='/login' />">Login </strong></a> Now</h5>
        </div>

        <div class="contact-form form-wrapper text-center">
            <form action="<c:url value='/register' />" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <select id="event-category-select" name="role" onchange="toggleAdditionalImagesField()" class="form-item" style="max-width:100%; background-color: #f7f7f7; border-color: #f0f0f0; padding: 0px 25px;">
                                <option value="" selected disabled>Select Role</option>
                                <option value="workhand">Workhand</option>
                                <option value="vendor">Company</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input type="text" name="username" placeholder="Username" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12" id="first_name">
                        <div class="form-item">
                            <input type="text" id="firstNameField" name="first_name" placeholder="First Name">
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12" id="last_name">
                        <div class="form-item">
                            <input type="text" id="lastNameField" name="last_name" placeholder="Last name">
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12" id="company-name" style="display: none;">
                        <div class="form-item">
                            <input name="company_name" id="companyNameField" type="text" placeholder="Company name">
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input type="password" name="password" placeholder="Password" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input type="password" name="confirm_password" placeholder="Confirm Password" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input name="email" type="email" placeholder="Email Address" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input type="tel" class="no-arrow" name="contact_number" pattern="[0-9]{10}" placeholder="Phone number" required>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <input type="text" name="street_address" placeholder="Street Address" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <select name="state" id="state" class="form-item" style="max-width:100%; background-color: #f7f7f7; border-color: #f0f0f0; padding: 0px 25px;" required>
                                <option value="" disabled selected>Choose State</option>
                                <c:forEach var="state" items="${States}">
                                    <option value="${state.id}">${state.state_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <select name="city" id="city" class="form-item" style="max-width:100%; background-color: #f7f7f7; border-color: #f0f0f0; padding: 0px 25px;" required>
                                <option value="" selected disabled>Choose City</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12" id="special-skill">
                        <div class="form-item">
                            <select name="workhand_category" id="workhand_category" class="form-item" style="max-width:100%; background-color: #f7f7f7; border-color: #f0f0f0; padding: 0px 25px;">
                                <option value="" disabled selected>Choose Your Special Category</option>
                                <c:forEach var="cat" items="${Workhand_category}">
                                    <option value="${cat.id}">${cat.workhand_category_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12" id="user_profile_pic">
                        <label for="image">Upload your profile photo</label>
                        <div class="form-item">
                            <input class="p-2" type="file" id="image" name="profile_image" accept="image/png, image/jpeg" />
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12" id="Discriotion-field" style="display: none;">
                        <div class="form-item">
                            <textarea name="discription" id="descriptionField" placeholder="Description About Company"></textarea>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12" id="additional-images-field" style="display: none;">
                        <label for="additional-images">Upload Your Company Logo</label>
                        <div class="form-item">
                            <input class="p-2" type="file" id="additional-images" name="company_logo" accept="image/png, image/jpeg" />
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <button type="submit" class="custom-btn">Register</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>

<script src="<c:url value='/login/js/register.js' />"></script>
<script src="<c:url value='/ckeditor/ckeditor/ckeditor.js' />"></script>
<script>
    if(typeof CKEDITOR !== 'undefined'){
        CKEDITOR.replace('descriptionField');
    }
</script>