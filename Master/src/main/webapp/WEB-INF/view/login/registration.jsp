<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

            <div id="message" style="display: none;"></div>

            <form id="registerForm" action="<c:url value='/register' />" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <select id="event-category-select" name="roleId" onchange="toggleAdditionalImagesField()" class="form-item" style="max-width:100%; background-color: #f7f7f7; border-color: #f0f0f0; padding: 0px 25px;" required>
                                <option value="" selected disabled>Select Role</option>
                                <option value="1">Workhand</option>
                                <option value="2">Company</option>
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
                            <input type="text" id="firstNameField" name="firstName" placeholder="First Name" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12" id="last_name">
                        <div class="form-item">
                            <input type="text" id="lastNameField" name="lastName" placeholder="Last name" required>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12" id="company-name" style="display: none;">
                        <div class="form-item">
                            <input name="specialCategory" id="companyNameField" type="text" placeholder="Company name">
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input name="email" type="email" placeholder="Email Address" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input type="tel" class="no-arrow" name="contactNumber" pattern="[0-9]{10}" placeholder="Phone number" required>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <input type="text" name="streetAddress" placeholder="Street Address" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input type="number" name="stateId" placeholder="State ID (e.g., 1)" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <input type="number" name="cityId" placeholder="City ID (e.g., 1)" required>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12" id="user_profile_pic">
                        <label for="image">Upload your profile photo</label>
                        <div class="form-item">
                            <input class="p-2" type="file" id="image" name="profilePhoto" accept="image/png, image/jpeg" required/>
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

<script src="<c:url value='/assets/custom/login/register.js' />"></script>
<script>
    function toggleAdditionalImagesField() {
        // Your logic here
    }
</script>
