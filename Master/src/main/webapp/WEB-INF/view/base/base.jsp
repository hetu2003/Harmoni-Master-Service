<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>Harmoni - ${title}</title>
    <link rel="shortcut icon" href="<c:url value='/assets/images/favicon.png' />">

    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/bootstrap.min.css' />">

    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/fontawesome-all.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/flaticon.css' />">

    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/slick.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/slick-theme.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/animate.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/owl.carousel.min.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/owl.theme.default.min.css' />">

    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/magnific-popup.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/jquery.mCustomScrollbar.min.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/calendar.css' />">

    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/colors/style-switcher.css' />">
    <link id="color_theme" rel="stylesheet" type="text/css" href="<c:url value='/assets/css/colors/default.css' />">

    <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/style.css' />">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">

    <%-- Context path for JS files that construct asset URLs --%>
    <script>var CTX_PATH = '${pageContext.request.contextPath}';</script>
</head>

<body class="default-header-p" id="body">
    <div id="thetop" class="thetop"></div>
    <div class='backtotop'>
        <a href="#thetop" class='scroll'><i class="fas fa-angle-double-up"></i></a>
    </div>

    <header id="header-section" class="header-section default-header-section auto-hide-header clearfix">
        <div class="header-top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="basic-contact">
                            <ul>
                                <c:choose>
                                    <c:when test="${not empty user}">
                                        <li>
                                            <a href="mailto:${user.email}">
                                                <i class="fas fa-envelope"></i> ${user.email}
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <a href="mailto:info@harmoni.com">
                                                <i class="fas fa-envelope"></i> info@harmoni.com
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#!"> <i class="fas fa-phone"></i> 100-2222-9999 </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="register-login-group">
                            <ul>
                                <li>
                                    <c:choose>
                                        <c:when test="${not empty user}">
                                            <a href="<c:url value='/profile' />"><i class="fas fa-user"></i> ${user.username}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="<c:url value='/register' />"><i class="fas fa-user"></i> Register</a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                <li>
                                    <c:choose>
                                        <c:when test="${not empty user}">
                                            <a href="<c:url value='/logout' />"><i class="fas fa-sign-out-alt"></i> Logout</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="<c:url value='/login' />"><i class="fas fa-lock"></i> Login</a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <div class="header-bottom">
        <div class="container">
            <div class="row align-items-center"> <div class="col-lg-3">
                    <div class="site-logo-wrapper">
                        <a href="<c:url value='/home' />" class="logo">
                            <img src="<c:url value='/assets/images/0.site-logo.png' />" alt="logo_not_found">
                        </a>
                    </div>
                </div>

                <div class="col-lg-7">
                    <div class="mainmenu-wrapper">
                        <div class="menu-item-list ul-li clearfix">
                            <ul id="main-nav-list">
                                <li><a href="<c:url value='/home' />">home</a></li>
                                <li><a href="<c:url value='/about' />">about</a></li>
                                <li><a href="<c:url value='/event' />">events</a></li>
                                <li><a href="<c:url value='/company' />">Company</a></li>
                                <li><a href="<c:url value='/contact' />">Contact</a></li>
                                <c:choose>
                                    <c:when test="${user.roleId == 1}">
                                        <li><a href="<c:url value='/history' />">History</a></li>
                                    </c:when>
                                    <c:when test="${user.roleId == 2}">
                                        <li><a href="<c:url value='/vendor/my-events' />">My Events</a></li>
                                    </c:when>
                                    <c:when test="${user.roleId == 3}">
                                        <li><a href="<c:url value='/admin/dashboard' />">Admin</a></li>
                                    </c:when>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-lg-2">
                    <div class="user-search-btn-group ul-li clearfix">
                        <ul>
                            <li>
                                <c:choose>
                                    <c:when test="${not empty user.profilePath}">
                                        <a href="#">
                                            <img src="${pageContext.request.contextPath}${user.profilePath}"
                                                 class="rounded-circle"
                                                 style="height: 43px; width: 43px; object-fit: cover;"> </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="#!">
                                            <i class="fas fa-user"></i>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                            <li>
                                <button type="button" class="toggle-overlay search-btn">
                                    <i class="fas fa-search"></i>
                                </button>
                                <div class="search-body">
                                    <div class="search-form">
                                        <form action="<c:url value='/event/search' />" method="post">
                                            <input class="search-input" type="search" name="keyword" placeholder="Search Here">
                                            <div class="outer-close toggle-overlay">
                                                <button type="button" class="search-close">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
      </div>
    </header>

    <jsp:include page="/WEB-INF/view/${viewName}.jsp" />

    <footer id="footer-section" class="footer-section footer-section2 clearfix">
        <div class="footer-top sec-ptb-100 clearfix">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="about-wrapper">
                            <div class="site-logo-wrapper mb-30">
                                <a href="<c:url value='/home' />"><img src="<c:url value='/assets/images/1.site-logo.png' />" alt="logo"></a>
                            </div>
                            <p>Harmoni events management system.</p>
                            <div class="basic-info ul-li-block mb-50">
                                <ul>
                                    <li><i class="fas fa-map-marker-alt"></i> 100 highland ave, california, united state</li>
                                    <li><i class="fas fa-envelope"></i> hamoni@gmail.com</li>
                                    <li><i class="fas fa-phone"></i> 100 800 1234 5555</li>
                                </ul>
                            </div>
                            <div class="social-links ul-li">
							    <h3 class="social-title">network</h3>
								<ul>
								    <li> <a href="#!"><i class="fab fa-facebook-f"></i></a> </li>
									<li> <a href="#!"><i class="fab fa-twitter"></i></a> </li>
									<li> <a href="#!"><i class="fab fa-twitch"></i></a> </li>
									<li> <a href=""><i class="fab fa-google-plus-g"></i></a> </li>
									<li> <a href=""><i class="fab fa-instagram"></i></a> </li>
								</ul>
                        	</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-12">
                        <div class="usefullinks-wrapper ul-li-block">
                            <h3 class="footer-item-title">
                                useful <strong>links</strong>
                            </h3>
                            <ul>
                                <li><a href="<c:url value='/faq' />">FAQ</a></li>
                                <li><a href="<c:url value='/event' />">Events Schedule</a></li>
                                <li><a href="<c:url value='/company' />">Companies</a></li>
                                <li><a href="<c:url value='/closed-event' />">Recently Closed Event</a></li>

                                <c:choose>
                                    <c:when test="${not empty user}">
                                        <c:choose>
                                            <c:when test="${user.roleId == 1}">
                                                <li><a href="<c:url value='/history' />">My History</a></li>
                                            </c:when>
                                            <c:when test="${user.roleId == 2}">
                                                <li><a href="<c:url value='/vendor/my-events' />">My Events</a></li>
                                            </c:when>
                                            <c:when test="${user.roleId == 3}">
                                                <li><a href="<c:url value='/admin/dashboard' />">Admin Panel</a></li>
                                            </c:when>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="<c:url value='/register' />">Register</a></li>
                                        <li><a href="<c:url value='/login' />">Login</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-12">
                        <div class="instagram-wrapper ul-li">
                            <h3 class="footer-item-title">
                                harmoni <strong>instagram</strong>
                            </h3>
                            <ul>
                                <li class="image-wrapper">
                                    <img src="<c:url value='/assets/images/footer/instagram/img1.png' />" alt="Image_not_found">
                                    <a href=""><i class="fab fa-instagram"></i></a>
                                </li>
                                <li class="image-wrapper">
                                    <img src="<c:url value='/assets/images/footer/instagram/img2.png' />" alt="Image_not_found">
                                    <a href=""><i class="fab fa-instagram"></i></a>
                                </li>
                                <li class="image-wrapper">
                                    <img src="<c:url value='/assets/images/footer/instagram/img3.png' />" alt="Image_not_found">
                                    <a href=""><i class="fab fa-instagram"></i></a>
                                </li>
                                <li class="image-wrapper">
                                    <img src="<c:url value='/assets/images/footer/instagram/img4.png' />" alt="Image_not_found">
                                    <a href=""><i class="fab fa-instagram"></i></a>
                                </li>
                                <li class="image-wrapper">
                                    <img src="<c:url value='/assets/images/footer/instagram/img5.png' />" alt="Image_not_found">
                                    <a href=""><i class="fab fa-instagram"></i></a>
                                </li>
                                <li class="image-wrapper">
                                    <img src="<c:url value='/assets/images/footer/instagram/img6.png' />" alt="Image_not_found">
                                    <a href=""><i class="fab fa-instagram"></i></a>
                                </li>
                            </ul>
                            <h4 class="followus-link">
                                Follow Our Instagram <a href="#!">#Harmoni</a>
                            </h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="container">
                <div class="row align-items-center d-flex justify-content-between">
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="copyright-text">
                            <p class="m-0">©2018 <a href="#!" class="site-link">Harmoni.com</a></p>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <div class="footer-menu text-right">
                            <ul style="display: flex; list-style: none; margin: 0; padding: 0; justify-content: flex-end;">
                                <li style="margin-left: 20px;"><a href="<c:url value='/contact' />">Contact us</a></li>
                                <li style="margin-left: 20px;"><a href="<c:url value='/about' />">About us</a></li>
                                <li style="margin-left: 20px;"><a href="<c:url value='/home' />">Site map</a></li>
                                <li style="margin-left: 20px;"><a href="<c:url value='/privacy-policy' />">Privacy policy</a></li>
                            </ul>
                        </div>
                    </div>
                    </div>
            </div>
        </div>
    </footer>


    <script src="<c:url value='/assets/js/jquery-3.3.1.min.js' />"></script>
    <script src="<c:url value='/assets/js/popper.min.js' />"></script>
    <script src="<c:url value='/assets/js/bootstrap.min.js' />"></script>

    <script src="<c:url value='/assets/js/slick.min.js' />"></script>
    <script src="<c:url value='/assets/js/owl.carousel.min.js' />"></script>

    <script src="<c:url value='/assets/js/atc.min.js' />"></script>

    <script src="<c:url value='/assets/js/jquery.magnific-popup.min.js' />"></script>
    <script src="<c:url value='/assets/js/isotope.pkgd.min.js' />"></script>
    <script src="<c:url value='/assets/js/jarallax.min.js' />"></script>
    <script src="<c:url value='/assets/js/jquery.mCustomScrollbar.concat.min.js' />"></script>

    <script src="<c:url value='/assets/js/imagesloaded.pkgd.min.js' />"></script>

    <script src="<c:url value='/assets/js/jquery.countdown.js' />"></script>

    <script src="<c:url value='/assets/js/style-switcher.js' />"></script>

    <script src="<c:url value='/assets/js/custom.js' />"></script>

    <!-- Restored the original paths for the login-specific scripts -->
    <script src="<c:url value='/login/js/vendor.min.js' />"></script>
    <script src="<c:url value='/login/js/plugins.min.js' />"></script>
    <script src="<c:url value='/login/js/main.min.js' />"></script>
    <!-- Note: main.js and addEvent.js were not found in the directory structure, you may need to verify their locations -->
    <!-- <script src="<c:url value='/login/js/main.js' />"></script> -->
    <!-- <script src="<c:url value='/login/js/addEvent.js' />"></script> -->

    <script>
    (function() {
        var ctx = '${pageContext.request.contextPath}';
        var rel = window.location.pathname.replace(ctx, '').replace(/\/$/, '') || '/';
        document.querySelectorAll('#main-nav-list > li > a').forEach(function(a) {
            var link = (a.getAttribute('href') || '').replace(ctx, '').replace(/\/$/, '');
            var match = (rel === link) ||
                        (link.length > 1 && (rel.startsWith(link + '/') || rel.startsWith(link + '-')));
            // /vendor/event/* should not highlight public "events" tab
            if (link === '/event' && rel.indexOf('/vendor') !== -1) match = false;
            // /payment-history → highlight History tab
            if (link === '/history' && rel.indexOf('/payment') !== -1) match = true;
            if (match) a.parentElement.classList.add('active');
        });
    })();
    </script>

</body>
</html>