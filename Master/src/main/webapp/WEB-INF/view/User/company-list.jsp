<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- page banner -->
<section style="background: linear-gradient(135deg, #1c1c2e 0%, #2d2d44 100%); padding: 60px 0;">
    <div class="container">
        <div class="section-title text-center mb-0">
            <small class="sub-title">event organizers</small>
            <h2 class="big-title white-color mt-2">Browse <strong>Companies</strong></h2>
            <p class="white-color mb-0 mt-2">${totalCount} companies registered on Harmoni</p>
        </div>
    </div>
</section>

<!-- search bar -->
<div style="background: #f8f9fa; border-bottom: 1px solid #dee2e6; padding: 14px 0;">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <form action="<c:url value='/company' />" method="GET" class="d-flex">
                    <input type="text" class="form-control mr-2" name="search" value="${search}" placeholder="Search company by name...">
                    <button class="btn btn-dark px-4" type="submit"><i class="fas fa-search mr-1"></i>Search</button>
                    <c:if test="${not empty search}">
                        <a href="<c:url value='/company' />" class="btn btn-outline-secondary ml-2"><i class="fas fa-times"></i></a>
                    </c:if>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- company grid -->
<section style="padding: 60px 0;">
    <div class="container">
        <c:choose>
            <c:when test="${empty companies}">
                <div class="text-center" style="padding: 80px 0;">
                    <i class="fas fa-building fa-4x mb-3 d-block" style="color: #ddd;"></i>
                    <h5>No companies found</h5>
                    <c:if test="${not empty search}">
                        <a href="<c:url value='/company' />" class="btn btn-outline-secondary btn-sm mt-2">View all companies</a>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach var="co" items="${companies}">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div style="border-radius:10px; box-shadow:0 3px 18px rgba(0,0,0,0.1); overflow:hidden; background:#fff; transition:transform .2s; height:100%;">

                                <!-- top color bar -->
                                <div style="height:8px; background: linear-gradient(90deg, #667eea, #764ba2);"></div>

                                <div style="padding:24px;">
                                    <div class="d-flex align-items-center mb-3">
                                        <c:choose>
                                            <c:when test="${not empty co.profilePath}">
                                                <img src="${pageContext.request.contextPath}/${co.profilePath}" class="rounded-circle" style="width:60px; height:60px; object-fit:cover; flex-shrink:0;" alt="${co.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <div style="width:60px; height:60px; border-radius:50%; background:#e9ecef; display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                                    <i class="fas fa-building" style="font-size:1.5rem; color:#6c757d;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="ml-3">
                                            <h5 class="font-weight-bold mb-0">${co.name}</h5>
                                            <small style="color:#888;"><i class="fas fa-map-marker-alt mr-1"></i>${co.city.cityName}, ${co.state.stateName}</small>
                                        </div>
                                    </div>

                                    <c:if test="${not empty co.companyDescription}">
                                        <p style="font-size:0.875rem; color:#666; margin-bottom:12px;">
                                            <c:choose>
                                                <c:when test="${co.companyDescription.length() > 120}">${co.companyDescription.substring(0, 120)}...</c:when>
                                                <c:otherwise>${co.companyDescription}</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </c:if>

                                    <p style="font-size:0.82rem; color:#888; margin-bottom:16px;">
                                        <c:if test="${not empty co.contactNumber}"><i class="fas fa-phone mr-1"></i>${co.contactNumber}&nbsp;&nbsp;</c:if>
                                        <c:if test="${not empty co.email}"><i class="fas fa-envelope mr-1"></i>${co.email}</c:if>
                                    </p>

                                    <a href="${pageContext.request.contextPath}/company/${co.userId}" class="custom-btn d-block text-center" style="padding:10px; font-size:0.85rem;">
                                        <i class="fas fa-eye mr-1"></i>View Profile &amp; Events
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>
