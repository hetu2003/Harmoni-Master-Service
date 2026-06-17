<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">

        <title>Harmoni - Home</title>
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
	</head>

	<body>

		<!-- backtotop - start -->
		<div id="thetop" class="thetop"></div>
		<div class='backtotop'>
			<a href="#thetop" class='scroll'>
				<i class="fas fa-angle-double-up"></i>
			</a>
		</div>
		<!-- backtotop - end -->

		<!-- preloader - start -->
		<div id="preloader"></div>
		<!-- preloader - end -->

		<!-- header-section - start
		================================================== -->
				<header id="header-section" class="header-section default-header-section auto-hide-header clearfix">

			<!-- header-top - start -->
			<div class="header-top">
				<div class="container">
					<div class="row">
						<div class="col-lg-6">
							<div class="basic-contact">
								<ul>
									<c:choose>
										<c:when test="${not empty user}">
											<li><a href="mailto:${user.email}"><i class="fas fa-envelope"></i> ${user.email}</a></li>
										</c:when>
										<c:otherwise>
											<li><a href="mailto:info@harmoni.com"><i class="fas fa-envelope"></i> info@harmoni.com</a></li>
											<li><a href="#!"><i class="fas fa-phone"></i> +91 98765 43210</a></li>
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
			<!-- header-top - end -->

			<!-- header-bottom - start -->
			<div class="header-bottom">
				<div class="container">
					<div class="row">

						<!-- site-logo-wrapper - start -->
						<div class="col-lg-3">
							<div class="site-logo-wrapper">
								<a href="<c:url value='/home' />" class="logo">
									<img src="<c:url value='/assets/images/0.site-logo.png' />" alt="logo">
								</a>
							</div>
						</div>
						<!-- site-logo-wrapper - end -->

						<!-- mainmenu-wrapper - start -->
						<div class="col-lg-7">
							<div class="mainmenu-wrapper">
								<div class="menu-item-list ul-li clearfix">
									<ul>
										<li class="active"><a href="<c:url value='/home' />">home</a></li>
										<li><a href="<c:url value='/about' />">about</a></li>
										<li><a href="<c:url value='/event' />">events</a></li>
										<li><a href="<c:url value='/company' />">company</a></li>
										<li><a href="<c:url value='/contact' />">contact</a></li>
										<c:if test="${not empty user}">
											<c:choose>
												<c:when test="${user.roleId == 2}">
													<li><a href="<c:url value='/vendor/my-events' />">my events</a></li>
												</c:when>
												<c:when test="${user.roleId == 1}">
													<li><a href="<c:url value='/history' />">history</a></li>
												</c:when>
												<c:when test="${user.roleId == 3}">
													<li><a href="<c:url value='/admin/dashboard' />">admin</a></li>
												</c:when>
											</c:choose>
										</c:if>
									</ul>
								</div>
							</div>
						</div>
						<!-- mainmenu-wrapper - end -->

						<!-- user-search - start -->
						<div class="col-lg-2">
							<div class="user-search-btn-group ul-li clearfix">
								<ul>
									<li>
										<c:choose>
											<c:when test="${not empty user.profilePath}">
												<a href="<c:url value='/profile' />">
													<img src="${pageContext.request.contextPath}${user.profilePath}" class="rounded-circle" style="height: 43px; width: 43px; object-fit: cover;">
												</a>
											</c:when>
											<c:otherwise>
												<a href="<c:url value='/login' />"><i class="fas fa-user"></i></a>
											</c:otherwise>
										</c:choose>
									</li>
									<li>
										<button type="button" class="toggle-overlay search-btn">
											<i class="fas fa-search"></i>
										</button>
										<div class="search-body">
											<div class="search-form">
												<form action="<c:url value='/event' />" method="get">
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
						<!-- user-search - end -->

					</div>
				</div>
			</div>
			<!-- header-bottom - end -->
		</header>
		<!-- header-section - end
		================================================== -->

		<!-- slide-section - start
		================================================== -->
		<section id="slide-section" class="slide-section clearfix">
			<div id="main-carousel1" class="main-carousel1 owl-carousel owl-theme">

				<div class="item" style="background-image: url(assets/images/slider/slider-bg1.jpg);">
					<div class="overlay-black">
						<div class="container">
							<div class="slider-item-content">

								<span class="medium-text">one stop</span>
								<h1 class="big-text">Event Planner</h1>
								<small class="small-text">every event should be perfect</small>

								<div class="link-groups">
									<a href="<c:url value='/about' />" class="about-btn custom-btn">about us</a>
									<a href="<c:url value='/register' />" class="start-btn">get started!</a>
								</div>

							</div>
						</div>
					</div>
				</div>
				<div class="item" style="background-image: url(assets/images/slider/slider-bg2.jpg);">
					<div class="overlay-black">
						<div class="container">
							<div class="slider-item-content">

								<span class="medium-text">one stop</span>
								<h1 class="big-text">Event Planner</h1>
								<small class="small-text">every event should be perfect</small>

								<div class="link-groups">
									<a href="<c:url value='/about' />" class="about-btn custom-btn">about us</a>
									<a href="<c:url value='/register' />" class="start-btn">get started!</a>
								</div>

							</div>
						</div>
					</div>
				</div>
				<div class="item" style="background-image: url(assets/images/slider/slider-bg3.jpg);">
					<div class="overlay-black">
						<div class="container">
							<div class="slider-item-content">

								<span class="medium-text">one stop</span>
								<h1 class="big-text">Event Planner</h1>
								<small class="small-text">every event should be perfect</small>

								<div class="link-groups">
									<a href="<c:url value='/about' />" class="about-btn custom-btn">about us</a>
									<a href="<c:url value='/register' />" class="start-btn">get started!</a>
								</div>

							</div>
						</div>
					</div>
				</div>

			</div>
		</section>
		<!-- slide-section - end
		================================================== -->





		<!-- upcomming-event-section - start
		================================================== -->
		<section id="upcomming-event-section" class="upcomming-event-section sec-ptb-100 clearfix">
			<div class="container">

				<!-- section-title - start -->
				<div class="section-title text-center mb-50">
					<small class="sub-title">upcoming events</small>
					<h2 class="big-title">Latest <strong>Upcoming Events</strong></h2>
				</div>
				<!-- section-title - end -->

				<!-- upcomming-event-carousel - start -->
				<c:choose>
					<c:when test="${empty upcomingEvents}">
						<div class="text-center" style="padding:40px 0;">
							<i class="fas fa-calendar-times fa-3x mb-3 d-block" style="color:rgba(255,255,255,0.3);"></i>
							<p style="color:rgba(255,255,255,0.6);">No upcoming events at the moment. Check back soon!</p>
						</div>
					</c:when>
					<c:otherwise>
						<div id="upcomming-event-carousel" class="upcomming-event-carousel owl-carousel owl-theme">
							<c:forEach var="ev" items="${upcomingEvents}">
								<div class="item">
									<div class="event-item">

										<div class="countdown-timer">
											<ul class="countdown-list" data-countdown="${ev.startDateForCountdown}"></ul>
										</div>

										<div class="event-image">
											<c:choose>
												<c:when test="${not empty ev.imagePath}">
													<img src="<c:url value='/${ev.imagePath}' />" alt="${ev.eventName}">
												</c:when>
												<c:otherwise>
													<img src="assets/images/upcomming-events/event-1.jpg" alt="${ev.eventName}">
												</c:otherwise>
											</c:choose>
											<div class="post-date">
												<span class="date">${ev.startDay}</span>
												<small class="month">${ev.startMonth}</small>
											</div>
										</div>

										<div class="event-content">
											<div class="event-title mb-30">
												<h3 class="title">${ev.eventName}</h3>
												<span class="ticket-price yellow-color">
													<i class="fas fa-users"></i> ${ev.totalWorkhand} positions
												</span>
											</div>
											<div class="event-post-meta ul-li-block mb-30">
												<ul>
													<li>
														<span class="icon"><i class="far fa-clock"></i></span>
														${ev.formattedDatetime}
													</li>
													<li>
														<span class="icon"><i class="fas fa-map-marker-alt"></i></span>
														${ev.streetAddress}
													</li>
												</ul>
											</div>
											<a href="<c:url value='/event-details/${ev.eventId}' />" class="custom-btn">
												view details
											</a>
										</div>

									</div>
								</div>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>
				<!-- upcomming-event-carousel - end -->

			</div>
		</section>
		<!-- upcomming-event-section - end
		================================================== -->





		<!-- about-section - start
		================================================== -->
		<section id="about-section" class="about-section sec-ptb-100 clearfix">
			<div class="container">
				<div class="row">

					<!-- section-title - start -->
					<div class="col-lg-4 col-md-12 col-sm-12">
						<div class="section-title text-left mb-30">
							<span class="line-style"></span>
							<small class="sub-title">we are harmoni</small>
							<h2 class="big-title"><strong>No.1</strong> Events Management</h2>
							<p class="black-color mb-50">
								Harmoni is your all-in-one event workforce platform. We connect event companies with skilled workhands, making it effortless to plan, staff, and execute events of any scale — from intimate gatherings to large corporate conferences.
							</p>
							<a href="<c:url value='/about' />" class="custom-btn">
								about harmoni
							</a>
						</div>
					</div>
					<!-- section-title - end -->

					<!-- about-item-wrapper - start -->
					<div class="col-lg-8 col-md-12 col-sm-12">
						<div class="about-item-wrapper ul-li">
							<ul>

								<li>
									<a href="#!" class="about-item">
										<span class="icon">
											<i class="flaticon-handshake"></i>
										</span>
										<strong class="title">
											Friendly Team
										</strong>
										<small class="sub-title">
											More than 200 teams
										</small>
									</a>
								</li>
								<li>
									<a href="#!" class="about-item">
										<span class="icon">
											<i class="flaticon-two-balloons"></i>
										</span>
										<strong class="title">
											Perfect Venues
										</strong>
										<small class="sub-title">
											The right venue for every event
										</small>
									</a>
								</li>
								<li>
									<a href="#!" class="about-item">
										<span class="icon">
											<i class="flaticon-cheers"></i>
										</span>
										<strong class="title">
											Smart Matching
										</strong>
										<small class="sub-title">
											Right talent for every event
										</small>
									</a>
								</li>

								<li>
									<a href="#!" class="about-item">
										<span class="icon">
											<i class="flaticon-clown-hat"></i>
										</span>
										<strong class="title">
											Unforgettable Times
										</strong>
										<small class="sub-title">
											We make your event perfect
										</small>
									</a>
								</li>
								<li>
									<a href="#!" class="about-item">
										<span class="icon">
											<i class="flaticon-speech-bubble"></i>
										</span>
										<strong class="title">
											24/7 Hours Support
										</strong>
										<small class="sub-title">
											Anytime anywhere
										</small>
									</a>
								</li>
								<li>
									<a href="#!" class="about-item">
										<span class="icon">
											<i class="flaticon-light-bulb"></i>
										</span>
										<strong class="title">
											Brilliant Ideas
										</strong>
										<small class="sub-title">
											Creative solutions every time
										</small>
									</a>
								</li>

							</ul>
						</div>
					</div>
					<!-- about-item-wrapper - end -->

				</div>
			</div>
		</section>
		<!-- about-section - end
		================================================== -->















		<!-- event-section - start
		================================================== -->
		<section id="event-section" class="event-section sec-ptb-100 bg-gray-light clearfix">
			<div class="container">

				<div class="mb-50">
					<div class="row">

						<!-- section-title - start -->
						<div class="col-lg-3 col-md-12 col-sm-12">
							<div class="section-title text-left">
								<span class="line-style"></span>
								<small class="sub-title">harmoni events</small>
								<h2 class="big-title"><strong>event</strong> listing</h2>
							</div>
						</div>
						<!-- section-title - end -->

						<div class="col-lg-8 col-md-12 col-sm-12 d-flex align-items-center justify-content-end">
							<a href="<c:url value='/event' />" class="custom-btn">View All Events</a>
						</div>

					</div>
				</div>

				<!-- tab-content - start -->
				<c:choose>
					<c:when test="${empty upcomingEvents}">
						<div class="text-center" style="padding:60px 0;">
							<i class="fas fa-calendar-times fa-3x mb-3 d-block text-muted"></i>
							<p class="text-muted mb-3">No upcoming events yet. Stay tuned!</p>
							<a href="<c:url value='/event' />" class="custom-btn">Browse Events</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="row">
							<c:forEach var="ev" items="${upcomingEvents}">
								<div class="col-lg-4 col-md-6 col-sm-12 mb-4">
									<div class="card h-100 shadow-sm" style="border-radius:12px; overflow:hidden; border:none;">
										<div style="position:relative;">
											<c:choose>
												<c:when test="${not empty ev.imagePath}">
													<img src="<c:url value='/${ev.imagePath}' />" style="height:200px; object-fit:cover; width:100%;" alt="${ev.eventName}">
												</c:when>
												<c:otherwise>
													<img src="assets/images/event/event-1.jpg" style="height:200px; object-fit:cover; width:100%;" alt="${ev.eventName}">
												</c:otherwise>
											</c:choose>
											<div style="position:absolute; top:12px; left:12px; background:#f0a500; color:#fff; padding:5px 12px; border-radius:6px; font-size:0.78rem; font-weight:700; letter-spacing:0.5px;">
												${ev.startDay} ${ev.startMonth}
											</div>
										</div>
										<div class="card-body d-flex flex-column" style="padding:20px;">
											<h6 class="font-weight-bold mb-2" style="font-size:1rem; color:#1c1c2e;">${ev.eventName}</h6>
											<p class="text-muted small mb-1"><i class="fas fa-users mr-2" style="color:#f0a500;"></i>${ev.totalWorkhand} positions open</p>
											<p class="text-muted small mb-1"><i class="far fa-clock mr-2" style="color:#f0a500;"></i>${ev.formattedDatetime}</p>
											<p class="text-muted small mb-3"><i class="fas fa-map-marker-alt mr-2" style="color:#f0a500;"></i>${ev.streetAddress}</p>
											<div class="mt-auto">
												<a href="<c:url value='/event-details/${ev.eventId}' />" class="custom-btn" style="padding:8px 18px; font-size:0.85rem;">View Details</a>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>
				<!-- tab-content - end -->

			</div>
		</section>
		<!-- event-section - end
		================================================== -->





		<!-- event-gallery-section - start
		================================================== -->
		<section id="event-gallery-section" class="event-gallery-section sec-ptb-100 clearfix">

			<!-- section-title - start -->
			<div class="section-title text-center mb-50">
				<small class="sub-title">harmoni gallery</small>
				<h2 class="big-title">Beautiful & <strong>Unforgettable Times</strong></h2>
			</div>
			<!-- section-title - end -->

			<div class="button-group filters-button-group mb-30">
				<button class="button is-checked" data-filter="*">
					<i class="fas fa-star"></i>
					<strong>all</strong> gallery
				</button>
				<button class="button" data-filter=".video-gallery">
					<i class="fas fa-play-circle"></i>
					<strong>video</strong> gallery
				</button>
				<button class="button" data-filter=".photo-gallery">
					<i class="far fa-image"></i>
					<strong>photo</strong> gallery
				</button>
			</div>

			<div class="grid zoom-gallery clearfix mb-80" data-isotope="{ &quot;masonry&quot;: { &quot;columnWidth&quot;: 0 } }">
				<div class="grid-item grid-item--height2 photo-gallery " data-category="photo-gallery">
					<a class="popup-link" href="assets/images/gallery/1.image.jpg">
						<img src="assets/images/gallery/1.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Grand Wedding Celebration</h3>
						<span>Wedding &amp; Occasions</span>
					</div>
				</div>
				<div class="grid-item grid-item--width2 video-gallery " data-category="video-gallery">
					<a class="popup-youtube" href="https://youtu.be/-haiaZ011OM">
						<img src="assets/images/gallery/2.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Corporate Business Summit</h3>
						<span>Corporate &amp; Social</span>
					</div>
				</div>
				<div class="grid-item photo-gallery " data-category="photo-gallery">
					<a class="popup-link" href="assets/images/gallery/3.image.jpg">
						<img src="assets/images/gallery/3.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Team Building Outdoor Event</h3>
						<span>Corporate &amp; Social</span>
					</div>
				</div>

				<div class="grid-item photo-gallery " data-category="photo-gallery">
					<a class="popup-link" href="assets/images/gallery/4.image.jpg">
						<img src="assets/images/gallery/4.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Grand Wedding Celebration</h3>
						<span>Wedding &amp; Occasions</span>
					</div>
				</div>
				<div class="grid-item grid-item--width2 video-gallery " data-category="video-gallery">
					<a class="popup-youtube" href="https://youtu.be/-haiaZ011OM">
						<img src="assets/images/gallery/5.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Annual Gala Night</h3>
						<span>Corporate &amp; Social</span>
					</div>
				</div>

				<div class="grid-item grid-item--width2 photo-gallery " data-category="photo-gallery">
					<a class="popup-link" href="assets/images/gallery/6.image.jpg">
						<img src="assets/images/gallery/6.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Outdoor Music Festival</h3>
						<span>Wedding &amp; Occasions</span>
					</div>
				</div>
				<div class="grid-item video-gallery " data-category="video-gallery">
					<a class="popup-youtube" href="https://youtu.be/-haiaZ011OM">
						<img src="assets/images/gallery/7.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Annual Gala Night</h3>
						<span>Corporate &amp; Social</span>
					</div>
				</div>
				<div class="grid-item photo-gallery " data-category="photo-gallery">
					<a class="popup-link" href="assets/images/gallery/8.image.jpg">
						<img src="assets/images/gallery/8.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Team Building Outdoor Event</h3>
						<span>Corporate &amp; Social</span>
					</div>
				</div>
			</div>

			<div class="text-center">
				<a href="<c:url value='/event' />" class="custom-btn">browse all events</a>
			</div>


		</section>
		<!-- event-gallery-section - end
		================================================== -->





		<!-- event-expertise-section - start
		================================================== -->
		<section id="event-expertise-section" class="event-expertise-section bg-gray-light sec-ptb-100 clearfix">
			<div class="container">

				<!-- section-title - start -->
				<div class="section-title text-center mb-50">
					<small class="sub-title">our services</small>
					<h2 class="big-title">harmoni <strong>Expertise</strong></h2>
				</div>
				<!-- section-title - end -->

				<!-- event-expertise-carousel - start -->
				<div id="event-expertise-carousel" class="event-expertise-carousel owl-carousel owl-theme">

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img1.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">Wedding Party</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img2.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">birthday Party</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img3.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">business meeting</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img1.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">Wedding Party</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img2.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">birthday Party</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img3.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">business meeting</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img1.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">Wedding Party</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img2.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">birthday Party</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img3.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">business meeting</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img1.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">Wedding Party</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img2.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">birthday Party</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

					<!-- expertise-item - start -->
					<div class="item">
						<span class="expertise-title">harmoni party events</span>
						<div class="expertise-item">
							<div class="image image-wrapper">
								<img src="assets/images/experties/img3.jpg" alt="Image_not_found">
								<a href="#!" class="plus-effect"></a>
							</div>
							<div class="content">
								<h3 class="title">business meeting</h3>
								</div>
						</div>
					</div>
					<!-- expertise-item - end -->

				</div>
				<!-- event-expertise-carousel - end -->

			</div>
		</section>
		<!-- event-expertise-section - end
		================================================== -->




















		<!-- news-update-section - start
		================================================== -->
		<section id="news-update-section" class="news-update-section sec-ptb-100 clearfix">
			<div class="container">
				<div class="row">

					<!-- faq-accordion - start -->
					<div class="col-lg-6 col-md-12 col-sm-12">
						<!-- section-title - start -->
						<div class="section-title mb-30">
							<span class="line-style"></span>
							<small class="sub-title">frequently asked questions</small>
							<h2 class="big-title">common <strong>questions</strong></h2>
						</div>
						<!-- section-title - end -->
						<div id="faq-accordion" class="faq-accordion">

							<div class="card">
								<div class="card-header" id="headingone">
									<button class="btn collapsed" data-toggle="collapse" data-target="#collapseone" aria-expanded="false" aria-controls="collapseone">
										<span>01.</span> What is Harmoni and who is it for?
									</button>
								</div>
								<div id="collapseone" class="collapse" aria-labelledby="headingone" data-parent="#faq-accordion">
									<div class="card-body">
										Harmoni is an event workforce platform that connects event companies with skilled professionals called Workhands. It is built for two types of users — Companies that organise events and need reliable staff, and Workhands who want to find paid event opportunities that match their skills.
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-header" id="headingtwo">
									<button class="btn" data-toggle="collapse" data-target="#collapsetwo" aria-expanded="true" aria-controls="collapsetwo">
										<span>02.</span> How does a Workhand apply for an event?
									</button>
								</div>
								<div id="collapsetwo" class="collapse show" aria-labelledby="headingtwo" data-parent="#faq-accordion">
									<div class="card-body">
										After registering as a Workhand, browse the Events page to find openings that suit your skills. Click on any event to view the roles, pay rate, and schedule, then submit your application with one click. The company will review your profile and notify you of their decision.
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-header" id="headingthree">
									<button class="btn collapsed" data-toggle="collapse" data-target="#collapsethree" aria-expanded="false" aria-controls="collapsethree">
										<span>03.</span> How do companies review and approve applicants?
									</button>
								</div>
								<div id="collapsethree" class="collapse" aria-labelledby="headingthree" data-parent="#faq-accordion">
									<div class="card-body">
										Once a company publishes an event, applications from Workhands appear in the Applications tab of that event. Companies can review each applicant's profile, accept or reject them, and once an applicant is approved the platform handles the next steps including payment coordination.
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-header" id="headingfour">
									<button class="btn collapsed" data-toggle="collapse" data-target="#collapsefour" aria-expanded="false" aria-controls="collapsefour">
										<span>04.</span> Can I track my earnings and event history?
									</button>
								</div>
								<div id="collapsefour" class="collapse" aria-labelledby="headingfour" data-parent="#faq-accordion">
									<div class="card-body">
										Yes. Every Workhand has a dedicated History section in their profile that shows all past registrations, application statuses, payment records, and ratings received from companies. Everything you need to track your work is in one place.
									</div>
								</div>
							</div>

						</div>
					</div>
					<!-- faq-accordion - end -->

					<!-- get-started-wrapper - start -->
					<div class="col-lg-6 col-md-12 col-sm-12">
						<div class="section-title mb-30">
							<span class="line-style"></span>
							<small class="sub-title">join harmoni</small>
							<h2 class="big-title">get <strong>started</strong></h2>
						</div>

						<c:choose>
							<%-- Logged-in users: show role-relevant quick links --%>
							<c:when test="${not empty user}">

								<c:choose>
									<c:when test="${user.roleId == 2}">
										<!-- Company logged in -->
										<div style="border:1px solid #e8e8e8; border-radius:10px; padding:28px 26px; margin-bottom:20px; display:flex; align-items:flex-start; gap:20px;">
											<div style="flex-shrink:0; width:52px; height:52px; background:linear-gradient(135deg,#1c1c2e,#2d2d44); border-radius:10px; display:flex; align-items:center; justify-content:center;">
												<i class="fas fa-calendar-plus" style="color:#f0a500; font-size:1.3rem;"></i>
											</div>
											<div>
												<h5 style="font-weight:700; margin-bottom:6px;">Post a New Event</h5>
												<p style="color:#666; font-size:0.9rem; margin-bottom:14px;">Create an event, define workhand roles and requirements, and start receiving applications from skilled professionals.</p>
												<a href="<c:url value='/vendor/event/add' />" class="custom-btn" style="padding:8px 20px; font-size:0.85rem;">Add Event</a>
											</div>
										</div>
										<div style="border:1px solid #e8e8e8; border-radius:10px; padding:28px 26px; display:flex; align-items:flex-start; gap:20px;">
											<div style="flex-shrink:0; width:52px; height:52px; background:linear-gradient(135deg,#f0a500,#d4920a); border-radius:10px; display:flex; align-items:center; justify-content:center;">
												<i class="fas fa-list-alt" style="color:#fff; font-size:1.3rem;"></i>
											</div>
											<div>
												<h5 style="font-weight:700; margin-bottom:6px;">Manage My Events</h5>
												<p style="color:#666; font-size:0.9rem; margin-bottom:14px;">View all your posted events, review workhand applications, approve candidates, and track payments in one place.</p>
												<a href="<c:url value='/vendor/my-events' />" class="custom-btn" style="padding:8px 20px; font-size:0.85rem;">My Events</a>
											</div>
										</div>
									</c:when>
									<c:when test="${user.roleId == 1}">
										<!-- Workhand logged in -->
										<div style="border:1px solid #e8e8e8; border-radius:10px; padding:28px 26px; margin-bottom:20px; display:flex; align-items:flex-start; gap:20px;">
											<div style="flex-shrink:0; width:52px; height:52px; background:linear-gradient(135deg,#1c1c2e,#2d2d44); border-radius:10px; display:flex; align-items:center; justify-content:center;">
												<i class="fas fa-search" style="color:#f0a500; font-size:1.3rem;"></i>
											</div>
											<div>
												<h5 style="font-weight:700; margin-bottom:6px;">Browse Open Events</h5>
												<p style="color:#666; font-size:0.9rem; margin-bottom:14px;">Explore upcoming events looking for workhands. Filter by location and category, and apply to roles that match your skills.</p>
												<a href="<c:url value='/event' />" class="custom-btn" style="padding:8px 20px; font-size:0.85rem;">Browse Events</a>
											</div>
										</div>
										<div style="border:1px solid #e8e8e8; border-radius:10px; padding:28px 26px; display:flex; align-items:flex-start; gap:20px;">
											<div style="flex-shrink:0; width:52px; height:52px; background:linear-gradient(135deg,#f0a500,#d4920a); border-radius:10px; display:flex; align-items:center; justify-content:center;">
												<i class="fas fa-history" style="color:#fff; font-size:1.3rem;"></i>
											</div>
											<div>
												<h5 style="font-weight:700; margin-bottom:6px;">My Event History</h5>
												<p style="color:#666; font-size:0.9rem; margin-bottom:14px;">Track all your applications, check approval statuses, view payment records, and see ratings from past events.</p>
												<a href="<c:url value='/history' />" class="custom-btn" style="padding:8px 20px; font-size:0.85rem;">View History</a>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<!-- Admin logged in -->
										<div style="border:1px solid #e8e8e8; border-radius:10px; padding:28px 26px; display:flex; align-items:flex-start; gap:20px;">
											<div style="flex-shrink:0; width:52px; height:52px; background:linear-gradient(135deg,#1c1c2e,#2d2d44); border-radius:10px; display:flex; align-items:center; justify-content:center;">
												<i class="fas fa-tachometer-alt" style="color:#f0a500; font-size:1.3rem;"></i>
											</div>
											<div>
												<h5 style="font-weight:700; margin-bottom:6px;">Admin Dashboard</h5>
												<p style="color:#666; font-size:0.9rem; margin-bottom:14px;">Manage users, events, and platform activity from the admin control panel.</p>
												<a href="<c:url value='/admin/dashboard' />" class="custom-btn" style="padding:8px 20px; font-size:0.85rem;">Go to Dashboard</a>
											</div>
										</div>
									</c:otherwise>
								</c:choose>

							</c:when>
							<%-- Guest: show registration cards --%>
							<c:otherwise>

								<!-- Company card -->
								<div style="border:1px solid #e8e8e8; border-radius:10px; padding:28px 26px; margin-bottom:20px; display:flex; align-items:flex-start; gap:20px;">
									<div style="flex-shrink:0; width:52px; height:52px; background:linear-gradient(135deg,#1c1c2e,#2d2d44); border-radius:10px; display:flex; align-items:center; justify-content:center;">
										<i class="fas fa-building" style="color:#f0a500; font-size:1.3rem;"></i>
									</div>
									<div>
										<h5 style="font-weight:700; margin-bottom:6px;">I'm a Company</h5>
										<p style="color:#666; font-size:0.9rem; margin-bottom:14px;">Post events, set workhand requirements, review applications, and manage your entire event workforce — all in one place.</p>
										<a href="<c:url value='/register' />" class="custom-btn" style="padding:8px 20px; font-size:0.85rem;">Register as Company</a>
									</div>
								</div>

								<!-- Workhand card -->
								<div style="border:1px solid #e8e8e8; border-radius:10px; padding:28px 26px; display:flex; align-items:flex-start; gap:20px;">
									<div style="flex-shrink:0; width:52px; height:52px; background:linear-gradient(135deg,#f0a500,#d4920a); border-radius:10px; display:flex; align-items:center; justify-content:center;">
										<i class="fas fa-user-tie" style="color:#fff; font-size:1.3rem;"></i>
									</div>
									<div>
										<h5 style="font-weight:700; margin-bottom:6px;">I'm a Workhand</h5>
										<p style="color:#666; font-size:0.9rem; margin-bottom:14px;">Browse open events near you, apply for roles that match your skills, and get paid — no middleman, no hassle.</p>
										<a href="<c:url value='/register' />" class="custom-btn" style="padding:8px 20px; font-size:0.85rem;">Register as Workhand</a>
									</div>
								</div>

							</c:otherwise>
						</c:choose>

					</div>
					<!-- get-started-wrapper - end -->

				</div>
			</div>
		</section>
		<!-- news-update-section - end
		================================================== -->

		<!-- footer-section2 - start
		================================================== -->
		<footer id="footer-section" class="footer-section footer-section2 clearfix">

			<!-- footer-top - start -->
			<div class="footer-top sec-ptb-100 clearfix">
				<div class="container">
					<div class="row">

						<!-- about-wrapper - start -->
						<div class="col-lg-4 col-md-6 col-sm-12">
							<div class="about-wrapper">

								<!-- site-logo-wrapper - start -->
								<div class="site-logo-wrapper mb-30">
									<a href="<c:url value='/home' />" class="logo">
									    <img src="<c:url value='/assets/images/1.site-logo.png' />" alt="logo">
									</a>
								</div>
								<!-- site-logo-wrapper - end -->

								<p class="mb-30">
									Harmoni is your all-in-one event workforce platform — connecting companies with skilled workhands across India.
								</p>

								<!-- basic-info - start -->
								<div class="basic-info ul-li-block mb-50">
									<ul>
										<li>
											<i class="fas fa-map-marker-alt"></i>
											Ahmedabad, Gujarat, India
										</li>
										<li>
											<i class="fas fa-envelope"></i>
											info@harmoni.com
										</li>
										<li>
											<i class="fas fa-phone"></i>
											<a href="#!">+91 98765 43210</a>
										</li>
									</ul>
								</div>
								<!-- basic-info - end -->

								<!-- social-links - start -->
								<div class="social-links ul-li">
									<h3 class="social-title">network</h3>
									<ul>
										<li>
											<a href="#!"><i class="fab fa-facebook-f"></i></a>
										</li>
										<li>
											<a href="#!"><i class="fab fa-twitter"></i></a>
										</li>
										<li>
											<a href="#!"><i class="fab fa-twitch"></i></a>
										</li>
										<li>
											<a href="#!"><i class="fab fa-google-plus-g"></i></a>
										</li>
										<li>
											<a href="#!"><i class="fab fa-instagram"></i></a>
										</li>
									</ul>
								</div>
								<!-- social-links - end -->

							</div>
						</div>
						<!-- about-wrapper - end -->

						<!-- usefullinks-wrapper - start -->
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
						<!-- usefullinks-wrapper - end -->

						<!-- instagram-wrapper - start -->
						<div class="col-lg-4 col-md-6 col-sm-12">
							<div class="instagram-wrapper ul-li">
								<h3 class="footer-item-title">
									harmoni <strong>instagram</strong>
								</h3>
								<ul>
									<li class="image-wrapper">
										<img src="assets/images/footer/instagram/img1.png" alt="Image_not_found">
										<a href="#!"><i class="fab fa-instagram"></i></a>
									</li>
									<li class="image-wrapper">
										<img src="assets/images/footer/instagram/img2.png" alt="Image_not_found">
										<a href="#!"><i class="fab fa-instagram"></i></a>
									</li>
									<li class="image-wrapper">
										<img src="assets/images/footer/instagram/img3.png" alt="Image_not_found">
										<a href="#!"><i class="fab fa-instagram"></i></a>
									</li>
									<li class="image-wrapper">
										<img src="assets/images/footer/instagram/img4.png" alt="Image_not_found">
										<a href="#!"><i class="fab fa-instagram"></i></a>
									</li>
									<li class="image-wrapper">
										<img src="assets/images/footer/instagram/img5.png" alt="Image_not_found">
										<a href="#!"><i class="fab fa-instagram"></i></a>
									</li>
									<li class="image-wrapper">
										<img src="assets/images/footer/instagram/img6.png" alt="Image_not_found">
										<a href="#!"><i class="fab fa-instagram"></i></a>
									</li>
								</ul>
								<h4 class="followus-link">
									Follow Our Instagram <a href="#!">#Harmoni</a>
								</h4>
							</div>
						</div>
						<!-- instagram-wrapper - end -->

					</div>
				</div>
			</div>
			<!-- footer-top - end -->

			<div class="footer-bottom">
				<div class="container">
					<div class="row">

						<!-- copyright-text - start -->
						<div class="col-lg-7 col-md-12 col-sm-12">
							<div class="copyright-text">
								<p class="m-0">&copy;2025 Harmoni. All rights reserved.</p>
							</div>
						</div>
						<!-- copyright-text - end -->

						<!-- footer-menu - start -->
						<div class="col-lg-5 col-md-12 col-sm-12">
							<div class="footer-menu">
								<ul>
									<li><a href="<c:url value='/contact' />">Contact us</a></li>
									<li><a href="<c:url value='/about' />">About us</a></li>
									<li><a href="#!">Site map</a></li>
									<li><a href="#!">Privacy policy</a></li>
								</ul>
							</div>
						</div>
						<!-- footer-menu - end -->

					</div>
				</div>
			</div>

		</footer>
		<!-- footer-section2 - end
		================================================== -->

		<script src="<c:url value='/assets/js/jquery-3.3.1.min.js' />"></script>
        <script src="<c:url value='/assets/js/popper.min.js' />"></script>
        <script src="<c:url value='/assets/js/bootstrap.min.js' />"></script>

        <script src="<c:url value='/assets/js/slick.min.js' />"></script>
        <script src="<c:url value='/assets/js/owl.carousel.min.js' />"></script>

        <script src="<c:url value='/assets/js/gmap3.min.js' />"></script>
        <script src="http://maps.google.com/maps/api/js?key=AIzaSyC61_QVqt9LAhwFdlQmsNwi5aUJy9B2SyA"></script>

        <script src="<c:url value='/assets/js/atc.min.js' />"></script>

        <script src="<c:url value='/assets/js/jquery.magnific-popup.min.js' />"></script>
        <script src="<c:url value='/assets/js/isotope.pkgd.min.js' />"></script>
        <script src="<c:url value='/assets/js/jarallax.min.js' />"></script>
        <script src="<c:url value='/assets/js/jquery.mCustomScrollbar.concat.min.js' />"></script>

        <script src="<c:url value='/assets/js/imagesloaded.pkgd.min.js' />"></script>

        <script src="<c:url value='/assets/js/jquery.countdown.js' />"></script>

        <script src="<c:url value='/assets/js/custom.js' />"></script>

        <script> const contextPath = "${pageContext.request.contextPath}"; </script>
	</body>
</html>





