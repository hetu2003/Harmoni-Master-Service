<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">

        <title>Harmoni - Home 1</title>
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
											<li><a href="#!"><i class="fas fa-phone"></i> 100-2222-9999</a></li>
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
									<img src="<c:url value='/assets/images/1.site-logo.png' />" alt="logo">
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
										<li><a href="<c:url value='/faq' />">FAQ</a></li>
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
													<img src="<c:url value='/${user.profilePath}' />" class="rounded-circle" style="height: 43px; width: 43px; object-fit: cover;">
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
								<small class="small-text">every event sould be perfect</small>

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
								<small class="small-text">every event sould be perfect</small>

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
								<small class="small-text">every event sould be perfect</small>

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
					<small class="sub-title">upcomming events</small>
					<h2 class="big-title">Latest <strong>Awesome Events</strong></h2>
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
								Lorem ipsum dollor site amet the best  consectuer adipiscing elites sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat insignia the consectuer adipiscing elit.
							</p>
							<a href="<c:url value='/about' />" class="custom-btn">
								about harmonei
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
											perfact venues
										</strong>
										<small class="sub-title">
											perfact venues
										</small>
									</a>
								</li>
								<li>
									<a href="#!" class="about-item">
										<span class="icon">
											<i class="flaticon-cheers"></i>
										</span>
										<strong class="title">
											Unique Scenario
										</strong>
										<small class="sub-title">
											We thinking out of the box
										</small>
									</a>
								</li>

								<li>
									<a href="#!" class="about-item">
										<span class="icon">
											<i class="flaticon-clown-hat"></i>
										</span>
										<strong class="title">
											Unforgettable Time
										</strong>
										<small class="sub-title">
											We make you perfect event
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
											Briliant Idea
										</strong>
										<small class="sub-title">
											We have million idea
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





		<!-- conference-section - start
		================================================== -->
		<section id="conference-section" class="conference-section clearfix">
			<div class="jarallax" style="background-image: url(assets/images/conference/pexels-photo-262669.jpg);">
				<div class="overlay-black sec-ptb-100">

					<div class="mb-50">
						<div class="container">
							<div class="row">

								<!-- section-title - start -->
								<div class="col-lg-6 col-md-12 col-sm-12">
									<div class="section-title text-left">
										<span class="line-style"></span>
										<small class="sub-title">harmoni venues</small>
										<h2 class="big-title">Conference <strong>Rooms & Hotels</strong></h2>
									</div>
								</div>
								<!-- section-title - end -->

								<!-- conference-location - start -->
								<div class="col-lg-6 col-md-12 col-sm-12">
									<div class="conference-location ul-li clearfix">
										<ul>

											<!-- country-select - start -->
											<li class="country-select">
												<form action="#!">
													<label for="country">Country :</label>
													<select class="custom-select" id="country">
														<option selected>Netherland</option>
														<option value="1">USA</option>
														<option value="2">england</option>
														<option value="3">germany</option>
													</select>
												</form>
											</li>
											<!-- country-select - end -->

											<!-- city-select - start -->
											<li class="city-select">
												<form action="#!">
													<label for="city">city :</label>
													<select class="custom-select" id="city">
														<option selected>Amsterdam</option>
														<option value="1">washington</option>
														<option value="2">london</option>
														<option value="3">berlin</option>
													</select>
												</form>
											</li>
											<!-- city-select - end -->

										</ul>
									</div>
								</div>
								<!-- conference-location - end -->

							</div>
						</div>
					</div>

					<!-- conference-content-wrapper - start -->
					<div class="tab-wrapper">

						<!-- tab-menu - start -->
						<div class="container">
							<div class="row justify-content-lg-start">
								<div class="col-lg-6 col-md-12 col-sm-12">
									<div class="tab-menu">
										<ul class="nav tab-nav mb-50">

											<li class="nav-item">
												<a class="nav-link active" id="nav-one-tab" data-toggle="tab" href="#nav-one" aria-expanded="true">
													<span class="image">
														<img src="assets/images/conference/RCJAKPP_00016_coddddnversion.jpg" alt="Image_not_found">
													</span>
													<span class="title">
														<strong class="yellow-color">5 <i class="fas fa-star"></i> Chocolato </strong>
														Hotel
													</span>
													<small class="sub-title">Party Room 2.500 seats</small>
													<small class="price yellow-color">Price from $52/night</small>
												</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" id="nav-two-tab" data-toggle="tab" href="#nav-two" aria-expanded="false">
													<span class="image">
														<img src="assets/images/conference/fresh-conference-room-microphones-decoration-ideas-collection-gallery-to-conference-room-microphones-home-ideas.jpg" alt="Image_not_found">
													</span>
													<span class="title">
														<strong class="yellow-color">4 <i class="fas fa-star"></i> Vanila </strong>
														Hotel
													</span>
													<small class="sub-title">Party Room 2.500 seats</small>
													<small class="price yellow-color">Price from $52/night</small>
												</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" id="nav-three-tab" data-toggle="tab" href="#nav-three" aria-expanded="false">
													<span class="image">
														<img src="assets/images/conference/RCTORON_00047ss.jpg" alt="Image_not_found">
													</span>
													<span class="title">
														<strong class="yellow-color">3 <i class="fas fa-star"></i> Pear </strong>
														Hotel
													</span>
													<small class="sub-title">Party Room 2.500 seats</small>
													<small class="price yellow-color">Price from $52/night</small>
												</a>
											</li>

											<li class="nav-item">
												<a class="nav-link" id="nav-four-tab" data-toggle="tab" href="#nav-four" aria-expanded="false">
													<span class="image">
														<img src="assets/images/conference/clayton-hotel-leopardstown-meeting-room-1.jpg" alt="Image_not_found">
													</span>
													<span class="title">
														<strong class="yellow-color">5 <i class="fas fa-star"></i> Chocolato </strong>
														Hotel
													</span>
													<small class="sub-title">Party Room 2.500 seats</small>
													<small class="price yellow-color">Price from $52/night</small>
												</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" id="nav-five-tab" data-toggle="tab" href="#nav-five" aria-expanded="false">
													<span class="image">
														<img src="assets/images/conference/conference-room-with-projection-facilities-3d-model-max.jpg" alt="Image_not_found">
													</span>
													<span class="title">
														<strong class="yellow-color">4 <i class="fas fa-star"></i> Vanila </strong>
														Hotel
													</span>
													<small class="sub-title">Party Room 2.500 seats</small>
													<small class="price yellow-color">Price from $52/night</small>
												</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" id="nav-six-tab" data-toggle="tab" href="#nav-six" aria-expanded="false">
													<span class="image">
														<img src="assets/images/conference/midlands-park-hotel-meeting-rooms.jpg" alt="Image_not_found">
													</span>
													<span class="title">
														<strong class="yellow-color">3 <i class="fas fa-star"></i> pear </strong>
														Hotel
													</span>
													<small class="sub-title">Party Room 2.500 seats</small>
													<small class="price yellow-color">Price from $52/night</small>
												</a>
											</li>

										</ul>
										<div class="more-btn">
											<a href="#!">
												<strong class="yellow-color">VIEW ALL</strong> HOTEL & RESORT
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- tab-menu - end -->

						<!-- tab-content - start -->
						<div class="tab-content">
							<!-- tab-pane - start -->
							<div class="tab-pane fade active show" id="nav-one" role="tabpanel" aria-labelledby="nav-one-tab" aria-expanded="true">
								<div class="image">
									<img src="assets/images/conference/RCJAKPP_00016_coddddnversion.jpg" alt="Image_not_found">
									<a href="#!" class="custom-btn">
										booking now
									</a>
									<div class="badge-item">
										<div class="content">
											<i class="fas fa-star"></i>
											<strong>5.0</strong>
											<small>featured hotel</small>
										</div>
									</div>
								</div>
							</div>
							<!-- tab-pane - end -->

							<!-- tab-pane - start -->
							<div class="tab-pane fade" id="nav-two" role="tabpanel" aria-labelledby="nav-two-tab" aria-expanded="false">
								<div class="image">
									<img src="assets/images/conference/fresh-conference-room-microphones-decoration-ideas-collection-gallery-to-conference-room-microphones-home-ideas.jpg" alt="Image_not_found">
									<a href="#!" class="custom-btn">
										booking now
									</a>
									<div class="badge-item">
										<div class="content">
											<i class="fas fa-star"></i>
											<strong>5.0</strong>
											<small>featured hotel</small>
										</div>
									</div>
								</div>
							</div>
							<!-- tab-pane - end -->

							<!-- tab-pane - start -->
							<div class="tab-pane fade" id="nav-three" role="tabpanel" aria-labelledby="nav-three-tab" aria-expanded="false">
								<div class="image">
									<img src="assets/images/conference/RCTORON_00047ss.jpg" alt="Image_not_found">
									<a href="#!" class="custom-btn">
										booking now
									</a>
									<div class="badge-item">
										<div class="content">
											<i class="fas fa-star"></i>
											<strong>5.0</strong>
											<small>featured hotel</small>
										</div>
									</div>
								</div>
							</div>
							<!-- tab-pane - end -->

							<!-- tab-pane - start -->
							<div class="tab-pane fade" id="nav-four" role="tabpanel" aria-labelledby="nav-four-tab" aria-expanded="false">
								<div class="image">
									<img src="assets/images/conference/clayton-hotel-leopardstown-meeting-room-1.jpg" alt="Image_not_found">
									<a href="#!" class="custom-btn">
										booking now
									</a>
									<div class="badge-item">
										<div class="content">
											<i class="fas fa-star"></i>
											<strong>5.0</strong>
											<small>featured hotel</small>
										</div>
									</div>
								</div>
							</div>
							<!-- tab-pane - end -->

							<!-- tab-pane - start -->
							<div class="tab-pane fade" id="nav-five" role="tabpanel" aria-labelledby="nav-five-tab" aria-expanded="false">
								<div class="image">
									<img src="assets/images/conference/conference-room-with-projection-facilities-3d-model-max.jpg" alt="Image_not_found">
									<a href="#!" class="custom-btn">
										booking now
									</a>
									<div class="badge-item">
										<div class="content">
											<i class="fas fa-star"></i>
											<strong>5.0</strong>
											<small>featured hotel</small>
										</div>
									</div>
								</div>
							</div>
							<!-- tab-pane - end -->

							<!-- tab-pane - start -->
							<div class="tab-pane fade" id="nav-six" role="tabpanel" aria-labelledby="nav-six-tab" aria-expanded="false">
								<div class="image">
									<img src="assets/images/conference/midlands-park-hotel-meeting-rooms.jpg" alt="Image_not_found">
									<a href="#!" class="custom-btn">
										booking now
									</a>
									<div class="badge-item">
										<div class="content">
											<i class="fas fa-star"></i>
											<strong>5.0</strong>
											<small>featured hotel</small>
										</div>
									</div>
								</div>
							</div>
							<!-- tab-pane - end -->

						</div>
						<!-- tab-content - end -->

					</div>
					<!-- conference-content-wrapper - end -->

				</div>
			</div>
		</section>
		<!-- conference-section - end
		================================================== -->





		<!-- special-offer-section - start
		================================================== -->
		<section id="special-offer-section" class="special-offer-section clearfix" style="background-image: url(assets/images/special-offer-bg.png);">
			<div class="container">
				<div class="row">

					<!-- special-offer-content - start -->
					<div class="col-lg-9 col-md-12 col-sm-12">
						<div class="special-offer-content">
							<h2><strong>30%</strong> Off in June~July for <span>Birthday Events</span></h2>
							<p class="m-0">
								Contact us now and we will make your event unique & unforgettable
							</p>
						</div>
					</div>
					<!-- special-offer-content - end -->

					<!-- event-makeing-btn - start -->
					<div class="col-lg-3 col-md-12 col-sm-12">
						<div class="event-makeing-btn">
							<a href="#!">make an event now</a>
						</div>
					</div>
					<!-- event-makeing-btn - end -->

				</div>
			</div>
		</section>
		<!-- special-offer-section - end
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
							<a href="<c:url value='/events' />" class="custom-btn">View All Events</a>
						</div>

					</div>
				</div>

				<!-- tab-content - start -->
				<c:choose>
					<c:when test="${empty upcomingEvents}">
						<div class="text-center" style="padding:60px 0;">
							<i class="fas fa-calendar-times fa-3x mb-3 d-block text-muted"></i>
							<p class="text-muted mb-3">No upcoming events yet. Stay tuned!</p>
							<a href="<c:url value='/events' />" class="custom-btn">Browse Events</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="row">
							<c:forEach var="ev" items="${upcomingEvents}">
								<div class="col-lg-6 col-md-12 col-sm-12">
									<div class="event-item clearfix">

										<div class="event-image">
											<div class="post-date">
												<span class="date">${ev.startDay}</span>
												<small class="month">${ev.startMonth}</small>
											</div>
											<c:choose>
												<c:when test="${not empty ev.imagePath}">
													<img src="<c:url value='/${ev.imagePath}' />" alt="${ev.eventName}" style="height:200px;object-fit:cover;width:100%;">
												</c:when>
												<c:otherwise>
													<img src="assets/images/event/event-1.jpg" alt="${ev.eventName}">
												</c:otherwise>
											</c:choose>
										</div>

										<div class="event-content">
											<div class="event-title mb-15">
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
											<a href="<c:url value='/event-details/${ev.eventId}' />" class="tickets-details-btn">
												view details
											</a>
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
						<h3>John Doe Wedding day</h3>
						<span>Wedding Party, 24 June 2016</span>
					</div>
				</div>
				<div class="grid-item grid-item--width2 video-gallery " data-category="video-gallery">
					<a class="popup-youtube" href="https://youtu.be/-haiaZ011OM">
						<img src="assets/images/gallery/2.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Business Conference in Dubai</h3>
						<span>Food Festival, 24 June 2016</span>
					</div>
				</div>
				<div class="grid-item photo-gallery " data-category="photo-gallery">
					<a class="popup-link" href="assets/images/gallery/3.image.jpg">
						<img src="assets/images/gallery/3.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Envato Author Fun Hiking</h3>
						<span>Food Festival, 24 June 2016</span>
					</div>
				</div>

				<div class="grid-item photo-gallery " data-category="photo-gallery">
					<a class="popup-link" href="assets/images/gallery/4.image.jpg">
						<img src="assets/images/gallery/4.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>John Doe Wedding day</h3>
						<span>Wedding Party, 24 June 2016</span>
					</div>
				</div>
				<div class="grid-item grid-item--width2 video-gallery " data-category="video-gallery">
					<a class="popup-youtube" href="https://youtu.be/-haiaZ011OM">
						<img src="assets/images/gallery/5.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>New Year Celebration</h3>
						<span>Food Festival, 24 June 2016</span>
					</div>
				</div>

				<div class="grid-item grid-item--width2 photo-gallery " data-category="photo-gallery">
					<a class="popup-link" href="assets/images/gallery/6.image.jpg">
						<img src="assets/images/gallery/6.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>John Doe Wedding day</h3>
						<span>Wedding Party, 24 June 2016</span>
					</div>
				</div>
				<div class="grid-item video-gallery " data-category="video-gallery">
					<a class="popup-youtube" href="https://youtu.be/-haiaZ011OM">
						<img src="assets/images/gallery/7.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>New Year Celebration</h3>
						<span>Food Festival, 24 June 2016</span>
					</div>
				</div>
				<div class="grid-item photo-gallery " data-category="photo-gallery">
					<a class="popup-link" href="assets/images/gallery/8.image.jpg">
						<img src="assets/images/gallery/8.image.jpg" alt="Image_not_found">
					</a>
					<div class="item-content">
						<h3>Envato Author Fun Hiking</h3>
						<span>Food Festival, 24 June 2016</span>
					</div>
				</div>
			</div>

			<div class="text-center">
				<a href="#!" class="custom-btn">view all gallery</a>
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
					<h2 class="big-title">harmony <strong>Expertise</strong></h2>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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
								<p>Start from <strong>$1.200-$2.000</strong></p>
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





		<!-- speaker-section - start
		================================================== -->
		<section id="speaker-section" class="speaker-section clearfix">
			<div class="jarallax" style="background-image: url(assets/images/speaker/Black-White-Dubai-Wallpaper.jpg);">
				<div class="overlay-white">
					<div class="container">

						<!-- speaker-carousel - start -->
						<div class="speaker-carousel">
							<div class="slider-for">

								<div class="item">
									<div class="row">

										<!-- speaker-image - start -->
										<div class="col-lg-6 col-md-12 col-sm-12">
											<div class="speaker-image image-wrapper text-center">
												<img src="assets/images/speaker/speakes1.png" alt="Image_not_found">
												<span class="speaker-name"><strong>Jenni</strong> Berthas</span>
											</div>
										</div>
										<!-- speaker-image - end -->

										<!-- speaker-content - start -->
										<div class="col-lg-6 col-md-12 col-sm-12">
											<div class="speaker-content">

												<!-- section-title - start -->
												<div class="section-title text-left mb-50">
													<span class="line-style"></span>
													<small class="sub-title">harmoni staffs</small>
													<h2 class="big-title">Professional <strong>Speakers</strong></h2>
												</div>
												<!-- section-title - end -->

												<div class="speaker-info">
													<div class="speaker-title mb-30">
														<span class="speaker-name"><strong>Jenni</strong> Berthas</span>
														<span class="work-experienc yellow-color"><strong>15 Years</strong> experienced</span>
													</div>
													<p class="black-color mb-30">
														Lorem ipsum dollor site amet the best  consectuer adipiscing elites sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam...
													</p>
													<div class="speaker-social-network ul-li">
														<h3 class="title title-medium mb-15">
															<strong>Social</strong> Network
														</h3>
														<ul>
															<li><a href="#!"><i class="fab fa-facebook-f"></i></a></li>
															<li><a href="#!"><i class="fab fa-twitter"></i></a></li>
															<li><a href="#!"><i class="fab fa-twitch"></i></a></li>
															<li><a href="#!"><i class="fab fa-google-plus-g"></i></a></li>
															<li><a href="#!"><i class="fab fa-instagram"></i></a></li>
														</ul>
													</div>
												</div>

											</div>
										</div>
										<!-- speaker-content - end -->

									</div>
								</div>

								<div class="item">
									<div class="row">

										<!-- speaker-image - start -->
										<div class="col-lg-6 col-md-12 col-sm-12">
											<div class="speaker-image image-wrapper text-center">
												<img src="assets/images/speaker/speakes1.png" alt="Image_not_found">
												<span class="speaker-name"><strong>Jonathan</strong> Doe</span>
											</div>
										</div>
										<!-- speaker-image - end -->

										<!-- speaker-content - start -->
										<div class="col-lg-6 col-md-12 col-sm-12">
											<div class="speaker-content">

												<!-- section-title - start -->
												<div class="section-title text-left mb-50">
													<span class="line-style"></span>
													<small class="sub-title">harmoni staffs</small>
													<h2 class="big-title">Professional <strong>Speakers</strong></h2>
												</div>
												<!-- section-title - end -->

												<div class="speaker-info">
													<div class="speaker-title mb-30">
														<span class="speaker-name"><strong>Jonathan</strong> Doe</span>
														<span class="work-experienc yellow-color"><strong>15 Years</strong> experienced</span>
													</div>
													<p class="black-color mb-30">
														Lorem ipsum dollor site amet the best  consectuer adipiscing elites sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam...
													</p>
													<div class="speaker-social-network ul-li">
														<h3 class="title title-medium mb-15">
															<strong>Social</strong> Network
														</h3>
														<ul>
															<li><a href="#!"><i class="fab fa-facebook-f"></i></a></li>
															<li><a href="#!"><i class="fab fa-twitter"></i></a></li>
															<li><a href="#!"><i class="fab fa-twitch"></i></a></li>
															<li><a href="#!"><i class="fab fa-google-plus-g"></i></a></li>
															<li><a href="#!"><i class="fab fa-instagram"></i></a></li>
														</ul>
													</div>
												</div>

											</div>
										</div>
										<!-- speaker-content - end -->

									</div>
								</div>

								<div class="item">
									<div class="row">

										<!-- speaker-image - start -->
										<div class="col-lg-6 col-md-12 col-sm-12">
											<div class="speaker-image image-wrapper text-center">
												<img src="assets/images/speaker/speakes1.png" alt="Image_not_found">
												<span class="speaker-name"><strong>Denies</strong> Suarez</span>
											</div>
										</div>
										<!-- speaker-image - end -->

										<!-- speaker-content - start -->
										<div class="col-lg-6 col-md-12 col-sm-12">
											<div class="speaker-content">

												<!-- section-title - start -->
												<div class="section-title text-left mb-50">
													<span class="line-style"></span>
													<small class="sub-title">harmoni staffs</small>
													<h2 class="big-title">Professional <strong>Speakers</strong></h2>
												</div>
												<!-- section-title - end -->

												<div class="speaker-info">
													<div class="speaker-title mb-30">
														<span class="speaker-name"><strong>Denies</strong> Suarez</span>
														<span class="work-experienc yellow-color"><strong>15 Years</strong> experienced</span>
													</div>
													<p class="black-color mb-30">
														Lorem ipsum dollor site amet the best  consectuer adipiscing elites sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam...
													</p>
													<div class="speaker-social-network ul-li">
														<h3 class="title title-medium mb-15">
															<strong>Social</strong> Network
														</h3>
														<ul>
															<li><a href="#!"><i class="fab fa-facebook-f"></i></a></li>
															<li><a href="#!"><i class="fab fa-twitter"></i></a></li>
															<li><a href="#!"><i class="fab fa-twitch"></i></a></li>
															<li><a href="#!"><i class="fab fa-google-plus-g"></i></a></li>
															<li><a href="#!"><i class="fab fa-instagram"></i></a></li>
														</ul>
													</div>
												</div>

											</div>
										</div>
										<!-- speaker-content - end -->

									</div>
								</div>

								<div class="item">
									<div class="row">

										<!-- speaker-image - start -->
										<div class="col-lg-6 col-md-12 col-sm-12">
											<div class="speaker-image image-wrapper text-center">
												<img src="assets/images/speaker/speakes1.png" alt="Image_not_found">
												<span class="speaker-name"><strong>Jonathan</strong> Doe</span>
											</div>
										</div>
										<!-- speaker-image - end -->

										<!-- speaker-content - start -->
										<div class="col-lg-6 col-md-12 col-sm-12">
											<div class="speaker-content">

												<!-- section-title - start -->
												<div class="section-title text-left mb-50">
													<span class="line-style"></span>
													<small class="sub-title">harmoni staffs</small>
													<h2 class="big-title">Professional <strong>Speakers</strong></h2>
												</div>
												<!-- section-title - end -->

												<div class="speaker-info">
													<div class="speaker-title mb-30">
														<span class="speaker-name"><strong>Jonathan</strong> Doe</span>
														<span class="work-experienc yellow-color"><strong>15 Years</strong> experienced</span>
													</div>
													<p class="black-color mb-30">
														Lorem ipsum dollor site amet the best  consectuer adipiscing elites sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam...
													</p>
													<div class="speaker-social-network ul-li">
														<h3 class="title title-medium mb-15">
															<strong>Social</strong> Network
														</h3>
														<ul>
															<li><a href="#!"><i class="fab fa-facebook-f"></i></a></li>
															<li><a href="#!"><i class="fab fa-twitter"></i></a></li>
															<li><a href="#!"><i class="fab fa-twitch"></i></a></li>
															<li><a href="#!"><i class="fab fa-google-plus-g"></i></a></li>
															<li><a href="#!"><i class="fab fa-instagram"></i></a></li>
														</ul>
													</div>
												</div>

											</div>
										</div>
										<!-- speaker-content - end -->

									</div>
								</div>

							</div>

							<div class="slider-nav">
								<div class="item">
									<div class="item-content">
										<span class="speaker-thumbnail">
											<img src="assets/images/speaker/speakes-thumbnail.png" alt="Image_not_found">
										</span>
										<h3 class="speaker-name">Jenni Berthas</h3>
										<span class="sub-title">Harmoni Speaker</span>
									</div>
								</div>

								<div class="item">
									<div class="item-content">
										<span class="speaker-thumbnail">
											<img src="assets/images/speaker/speakes-thumbnail.png" alt="Image_not_found">
										</span>
										<h3 class="speaker-name">Jonathan Doe</h3>
										<span class="sub-title">Harmoni Speaker</span>
									</div>
								</div>

								<div class="item">
									<div class="item-content">
										<span class="speaker-thumbnail">
											<img src="assets/images/speaker/speakes-thumbnail.png" alt="Image_not_found">
										</span>
										<h3 class="speaker-name">Denies Suarez</h3>
										<span class="sub-title">Harmoni Speaker</span>
									</div>
								</div>

								<div class="item">
									<div class="item-content">
										<span class="speaker-thumbnail">
											<img src="assets/images/speaker/speakes-thumbnail.png" alt="Image_not_found">
										</span>
										<h3 class="speaker-name">Jonathan Doe</h3>
										<span class="sub-title">Harmoni Speaker</span>
									</div>
								</div>

							</div>
						</div>
						<!-- speaker-carousel - end -->

					</div>
				</div>
			</div>
		</section>
		<!-- speaker-section - end
		================================================== -->





		<!-- advertisement-section - start
		================================================== -->
		<section id="advertisement-section" class="advertisement-section clearfix" style="background-image: url(assets/images/special-offer-bg.png);">
			<div class="container">
				<div class="advertisement-content text-center">

					<h2 class="title-large white-color">Are you ready to make <strong>your Own Special Events?</strong></h2>
					<p class="mb-31">“Get started now, Harmoni event management PSD template.”</p>
					<a href="#!" class="purchase-btn">purchase now!</a>

				</div>
			</div>
		</section>
		<!-- advertisement-section - end
		================================================== -->





		<!-- partners-clients-section - start
		================================================== -->
		<section id="partners-clients-section" class="partners-clients-section bg-gray-light sec-ptb-100 clearfix">
			<div class="container">

				<!-- section-title - start -->
				<div class="section-title text-center mb-50">
					<small class="sub-title">we are harmoni</small>
					<h2 class="big-title">We have <strong>Best Partners & Clients</strong></h2>
					<p class="m-0 black-color">
						Lorem ipsum dollor site amet the best  consectuer adipiscing elites sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat insignia the consectuer adipiscing elit.
					</p>
				</div>
				<!-- section-title - end -->

				<div class="row">

					<!-- partners-wrapper - start -->
					<div class="col-lg-6 col-md-12 col-sm-12">
						<div class="partners-wrapper">
							<span class="carousel-title">
								harmoni <strong>sponsors</strong>
							</span>
							<div id="partners-carousel" class="partners-carousel owl-carousel owl-theme">

								<div class="item">
									<ul>

										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>

									</ul>
								</div>

								<div class="item">
									<ul>

										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>

									</ul>
								</div>

								<div class="item">
									<ul>

										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>
										<li>
											<a href="#!">
												<img src="assets/images/partners/image1.png" alt="Image_not_found">
											</a>
										</li>

									</ul>
								</div>

							</div>
						</div>
					</div>
					<!-- partners-wrapper - end -->

					<!-- clients-testimonial - start -->
					<div class="col-lg-6 col-md-12 col-sm-12">
						<div class="clients-testimonial" style="background-image: url(assets/images/1.testimonial-bg.jpg);">
							<div class="overlay-black">

								<div class="section-title text-center mb-50">
									<small class="sub-title">testimonial</small>
									<h2 class="big-title">client <strong>says</strong></h2>
								</div>

								<div id="clients-testimonial-carousel" class="clients-testimonial-carousel owl-carousel owl-theme">
									<div class="item text-center">
										<p class="mb-30">
											“Bring people together, or turn your passion into a business. Harmoni gives you everything you need to host your best event yet. lorem ipsum diamet adispiscing dispend.”
										</p>
										<div class="client-info">
											<h3 class="client-name">Jenni Hernandes</h3>
											<span class="client-sub-title">Graphic Designer</span>
										</div>
									</div>

									<div class="item text-center">
										<p class="mb-30">
											“Bring people together, or turn your passion into a business. Harmoni gives you everything you need to host your best event yet. lorem ipsum diamet adispiscing dispend.”
										</p>
										<div class="client-info">
											<h3 class="client-name">Jenni Hernandes</h3>
											<span class="client-sub-title">Graphic Designer</span>
										</div>
									</div>

									<div class="item text-center">
										<p class="mb-30">
											“Bring people together, or turn your passion into a business. Harmoni gives you everything you need to host your best event yet. lorem ipsum diamet adispiscing dispend.”
										</p>
										<div class="client-info">
											<h3 class="client-name">Jenni Hernandes</h3>
											<span class="client-sub-title">Graphic Designer</span>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
					<!-- clients-testimonial - end -->

				</div>

			</div>
		</section>
		<!-- partners-clients-section - end
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
							<small class="sub-title">find your answer</small>
							<h2 class="big-title">ask & <strong>questions</strong></h2>
						</div>
						<!-- section-title - end -->
						<div id="faq-accordion" class="faq-accordion">

							<div class="card">
								<div class="card-header" id="headingone">
									<button class="btn collapsed" data-toggle="collapse" data-target="#collapseone" aria-expanded="true" aria-controls="collapseone">
										<span>01.</span> How to join Harmoni Event Management?
									</button>
								</div>

								<div id="collapseone" class="collapse" aria-labelledby="headingone" data-parent="#faq-accordion">
									<div class="card-body">
										<h3>answer</h3>
										Bring people together, or turn your passion into a business. Harmoni gives you everything you need to host your best event yet. lorem ipsum diamet.
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-header" id="headingtwo">
									<button class="btn" data-toggle="collapse" data-target="#collapsetwo" aria-expanded="false" aria-controls="collapsetwo">
										<span>02.</span> How to make my own event?
									</button>
								</div>
								<div id="collapsetwo" class="collapse show" aria-labelledby="headingtwo" data-parent="#faq-accordion">
									<div class="card-body">
										<h3>answer</h3>
										Bring people together, or turn your passion into a business. Harmoni gives you everything you need to host your best event yet. lorem ipsum diamet.
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-header" id="headingthree">
									<button class="btn collapsed" data-toggle="collapse" data-target="#collapsethree" aria-expanded="false" aria-controls="collapsethree">
										<span>03.</span> About the price to make new event?
									</button>
								</div>
								<div id="collapsethree" class="collapse" aria-labelledby="headingthree" data-parent="#faq-accordion">
									<div class="card-body">
										<h3>answer</h3>
										Bring people together, or turn your passion into a business. Harmoni gives you everything you need to host your best event yet. lorem ipsum diamet.
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-header" id="headingfour">
									<button class="btn collapsed" data-toggle="collapse" data-target="#collapsefour" aria-expanded="false" aria-controls="collapsefour">
										<span>04.</span> About the price to make new event?
									</button>
								</div>
								<div id="collapsefour" class="collapse" aria-labelledby="headingfour" data-parent="#faq-accordion">
									<div class="card-body">
										<h3>answer</h3>
										Bring people together, or turn your passion into a business. Harmoni gives you everything you need to host your best event yet. lorem ipsum diamet.
									</div>
								</div>
							</div>

						</div>
					</div>
					<!-- faq-accordion - end -->

					<!-- latest-blog-wrapper - start -->
					<div class="col-lg-6 col-md-12 col-sm-12">
						<div class="latest-blog-wrapper">

							<!-- section-title - start -->
							<div class="section-title mb-30">
								<span class="line-style"></span>
								<small class="sub-title">our blog</small>
								<h2 class="big-title">latest <strong>news</strong></h2>
							</div>
							<!-- section-title - end -->

							<!-- latest-blog - start -->
							<div class="latest-blog clearfix">
								<div class="blog-image">
									<img src="assets/images/blog/1.latest-blog.jpg" alt="Image_not_found">
									<a href="#!" class="plus-effect"></a>
								</div>
								<div class="blog-content">
									<div class="blog-title mb-30">
										<h3>Barcelona Friday Food Truck Festival 26 Mei 2019</h3>
										<span>26 June 2018</span>
									</div>
									<p class="m-0">
										Harmoni gives you everything you need to host your best event yet. lorem ipsum diamet.
									</p>
								</div>
							</div>
							<!-- latest-blog - end -->

							<!-- latest-blog - start -->
							<div class="latest-blog clearfix">
								<div class="blog-image">
									<img src="assets/images/blog/1.latest-blog.jpg" alt="Image_not_found">
									<a href="#!" class="plus-effect"></a>
								</div>
								<div class="blog-content">
									<div class="blog-title mb-30">
										<h3>Barcelona Friday Food Truck Festival 26 Mei 2019</h3>
										<span>26 June 2018</span>
									</div>
									<p class="m-0">
										Harmoni gives you everything you need to host your best event yet. lorem ipsum diamet.
									</p>
								</div>
							</div>
							<!-- latest-blog - end -->

						</div>
					</div>
					<!-- latest-blog-wrapper - end -->

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
									Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.
								</p>

								<!-- basic-info - start -->
								<div class="basic-info ul-li-block mb-50">
									<ul>
										<li>
											<i class="fas fa-map-marker-alt"></i>
											100 highland ave, california, united state
										</li>
										<li>
											<i class="fas fa-envelope"></i>
											<a href="#!">contact@pantero.com</a>
										</li>
										<li>
											<i class="fas fa-phone"></i>
											<a href="#!">100 800 1234 5555</a>
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
									<li><a href="<c:url value='/about' />">About Harmoni</a></li>
									<li><a href="#!">Disclaimer</a></li>
									<li><a href="<c:url value='/contact' />">Contact us</a></li>
									<li><a href="<c:url value='/event' />">Events Schedule</a></li>
									<li><a href="#!">Sponsors</a></li>
									<li><a href="#!">Venues</a></li>
									<li><a href="<c:url value='/event' />">Tickets</a></li>
									<li><a href="#!">Pricing Plans</a></li>
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
								<p class="m-0">©2018 <a href="#!" class="site-link">Harmoni.com</a> all right reserved, made with <i class="fas fa-heart"></i> by <a href="#!" class="author-link"><strong>jThemes Studio</strong></a></p>
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
