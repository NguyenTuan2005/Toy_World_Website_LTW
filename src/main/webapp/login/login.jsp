<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/root.css"/>
    <link rel="stylesheet" href="css/header.css"/>
    <link rel="stylesheet" href="css/login.css"/>
</head>
<body>
<jsp:include page="/common/header.jsp"/>

<div class="top-bar" role="navigation" aria-label="Breadcrumb and page header">
    <div class="container">
        <nav class="breadcrumb" aria-label="Breadcrumb" style="margin-left: -1px; ">
            <a href="${pageContext.request.contextPath}/home" aria-label="Trang Chủ">Trang Chủ</a>
            <svg class="crumb-sep" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M9 6l6 6-6 6" stroke="#8b8b8b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <a href="${pageContext.request.contextPath}/login" aria-label="Đăng nhập" style="width: 235px; color:#444;">Đăng nhập</a>
        </nav>
    </div>
</div>

<main class="px-0">
    <section class="container-lg py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty resetSuccessMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            ${resetSuccessMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form id="loginForm" class="mb-3" method="post" action="${pageContext.request.contextPath}/login">
                    <h2 class="text-center mb-4 title" id="sign-in-title">Đăng nhập</h2>

                    <div class="mb-3">
                        <input id="loginEmail" class="form-control" type="email" name="email" value="${param.email}"
                               placeholder="Email" required>
                    </div>

                    <div class="mb-3">
                        <input id="loginPassword" class="form-control" type="password" name="password"
                               value="${param.password}" placeholder="Mật khẩu" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mb-3">Đăng nhập</button>

                    <div class="hstack justify-content-between">
                        <a href="${pageContext.request.contextPath}/forgot-password" class="text-secondary text-decoration-none">Quên mật
                            khẩu?</a>
                        <a href="${pageContext.request.contextPath}/sign-up"
                           class="text-secondary text-decoration-none">Đăng kí tài khoản</a>
                    </div>
                </form>

            </div>
        </div>
        </div>
    </section>
</main>
<jsp:include page="/common/footer.jsp"/>
<script src="js/index.js"></script>
<script src="js/login.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>