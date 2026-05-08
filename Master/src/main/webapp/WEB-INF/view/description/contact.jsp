<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section id="breadcrumb-section" class="breadcrumb-section clearfix">
   <div class="jarallax" style="background-image: url('<c:url value='/assets/images/breadcrumb/0.breadcrumb-bg.jpg' />');">
      <div class="overlay-black">
         <div class="container">
            <div class="row justify-content-center">
               <div class="col-lg-6 col-md-12 col-sm-12">
                  <div class="breadcrumb-title text-center mb-50">
                     <span class="sub-title">contact us now</span>
                     <h2 class="big-title">keep <strong>in touch</strong></h2>
                  </div>
                  <div class="breadcrumb-list">
                     <ul>
                        <li class="breadcrumb-item"><a href="<c:url value='/home' />" class="breadcrumb-link">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">contact us</li>
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
         <small class="sub-title">contact us</small>
         <h2 class="big-title">Keep in touch <strong>with harmoni</strong></h2>
      </div>

      <div class="contact-form form-wrapper text-center">
         <form action="<c:url value='/contact-submit' />" method="post">
            <%-- Spring Security CSRF Token --%>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="row">
               <div class="col-lg-6 col-md-6 col-sm-12">
                  <div class="form-item">
                     <input type="text" name="name" placeholder="Your Name" required>
                  </div>
               </div>
               <div class="col-lg-6 col-md-6 col-sm-12">
                  <div class="form-item">
                     <input type="email" name="email" placeholder="Email Address" required>
                  </div>
               </div>
               <div class="col-lg-6 col-md-6 col-sm-12">
                  <div class="form-item">
                     <input type="text" name="country" placeholder="Your Country" required>
                  </div>
               </div>
               <div class="col-lg-6 col-md-6 col-sm-12">
                  <div class="form-item">
                     <input type="tel" name="phone" placeholder="Phone Number" required>
                  </div>
               </div>
               <div class="col-lg-12 col-md-12 col-sm-12">
                  <textarea name="message" placeholder="Your Message" required></textarea>
                  <button type="submit" class="custom-btn">send mail</button>
               </div>
            </div>
         </form>
      </div>
   </div>
</section>