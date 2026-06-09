<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
    <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
        <div class="overlay-black">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="breadcrumb-title text-center mb-50">
                            <span class="sub-title">Harmony Events</span>
                            <h2 class="big-title"> <strong>Update</strong> Your Profile</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="contact-section" class="contact-section sec-ptb-100 clearfix">
    <div class="container">
        <div class="contact-form form-wrapper text-center">

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form action="<c:url value='/profile/update' />" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" value="${user.name}" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <label for="contactNumber">Contact Number</label>
                            <input type="tel" class="no-arrow" id="contactNumber" name="contactNumber" value="${user.contactNumber}" pattern="[0-9]{10}" required>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <label for="streetAddress">Street Address</label>
                            <input type="text" id="streetAddress" name="streetAddress" value="${user.streetAddress}" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <label for="stateId">State ID</label>
                            <input type="number" id="stateId" name="stateId" value="${user.stateId}" required>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="form-item">
                            <label for="cityId">City ID</label>
                            <input type="number" id="cityId" name="cityId" value="${user.cityId}" required>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="form-item">
                            <label for="profilePhoto">Update Profile Photo</label>
                            <input class="p-2" type="file" id="profilePhoto" name="profilePhoto" accept="image/png, image/jpeg" />
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <button type="submit" class="custom-btn">Update Profile</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
