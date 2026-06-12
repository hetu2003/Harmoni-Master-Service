<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .error-main {
        min-height: 60vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 80px 20px;
    }
    .error-box {
        text-align: center;
        max-width: 520px;
    }
    .error-box .big-number {
        font-size: 8rem;
        font-weight: 900;
        line-height: 1;
        background: linear-gradient(135deg, #667eea, #764ba2);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }
    .error-box h3 {
        font-size: 1.6rem;
        font-weight: 700;
        color: #333;
        margin: 16px 0 12px;
    }
    .error-box p {
        color: #777;
        font-size: 1rem;
        margin-bottom: 30px;
    }
</style>

<div class="error-main">
    <div class="error-box">
        <div class="big-number">
            <c:choose>
                <c:when test="${errorCode != 0}">${errorCode}</c:when>
                <c:otherwise>404</c:otherwise>
            </c:choose>
        </div>
        <h3>
            <c:choose>
                <c:when test="${errorCode == 403}">Access Denied</c:when>
                <c:when test="${errorCode == 500}">Server Error</c:when>
                <c:otherwise>Page Not Found</c:otherwise>
            </c:choose>
        </h3>
        <p>
            <c:choose>
                <c:when test="${errorCode == 403}">You don&rsquo;t have permission to view this page.</c:when>
                <c:when test="${errorCode == 500}">Something went wrong on our end. Please try again later.</c:when>
                <c:otherwise>Oops! The page you&rsquo;re looking for doesn&rsquo;t exist or has been moved.<br>Let&rsquo;s get you back on track.</c:otherwise>
            </c:choose>
        </p>
        <div>
            <a href="<c:url value='/home' />" class="custom-btn mr-2">
                <i class="fas fa-home mr-1"></i>Go Home
            </a>
            <a href="<c:url value='/event' />" class="custom-btn" style="background: transparent; color: #764ba2; border: 2px solid #764ba2;">
                <i class="fas fa-calendar-alt mr-1"></i>Browse Events
            </a>
        </div>
    </div>
</div>
