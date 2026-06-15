<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Công cụ</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp" />
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="top-bar" role="navigation" aria-label="Breadcrumb and page header">
    <div class="container">
        <nav class="breadcrumb" aria-label="Breadcrumb" style="margin-left: -1px; ">
            <a href="${pageContext.request.contextPath}/home" aria-label="Trang Chủ">Trang Chủ</a>
            <svg class="crumb-sep" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M9 6l6 6-6 6" stroke="#8b8b8b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <a href="${pageContext.request.contextPath}/sign-up" aria-label="Đăng ký" style="width: 235px; color:#444;">Công cụ</a>
        </nav>
    </div>
</div>

<div>
    <p>
        test
    </p>
</div>

<br>

<jsp:include page="/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/sign-up.js"></script>
</body>
</html>
