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
    <link rel="stylesheet" href="css/header.css"/>
    <link rel="stylesheet" href="js/login.js"/>
</head>
<body>
<jsp:include page="/common/header.jsp"/>
<main class="px-0">
    <section class="container-lg py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">

                <!-- Form Đăng nhập -->
                <h2 class="text-center text-uppercase mb-4" style="color: #001c77">Đăng nhập</h2>

                <form id="loginForm" class="mb-3" method="post" action="${pageContext.request.contextPath}/login">
                    <div class="mb-3">
                        <input id="loginEmail" class="form-control" type="email" name="email" value="${param.email}" placeholder="Email" required>
                        <p class="text-danger small error-message mt-1" id="loginEmailError">${error}</p>
                    </div>

                    <div class="mb-3">
                        <input  id="loginPassword" class="form-control" type="password" name="password" value="${param.password}" placeholder="Mật khẩu" required>
                        <p class="text-danger small error-message mt-1" id="loginPasswordError">${error}</p>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mb-3">Đăng nhập</button>

                    <div class="hstack justify-content-between">
                        <a href="#" onclick="forgotPassword()" class="text-secondary text-decoration-none">Quên mật
                            khẩu?</a>
                        <a href="sign-up.html" class="text-secondary text-decoration-none">Đăng kí tài khoản</a>
                    </div>
                </form>


                <!-- Form Quên mật khẩu -->
                <div id="forgotPasswordForm" style="display: none;">
                    <h2 class="text-center text-uppercase mb-4" style="color: #001c77">Quên mật khẩu</h2>

                    <p class="text-muted text-center mb-4">Nhập email của bạn để nhận mã đặt lại mật khẩu</p>

                    <form id="forgotPasswordFormElement" class="mb-3" novalidate>
                        <div class="mb-3">
                            <input type="email" id="forgotEmail" class="form-control" placeholder="Email" required>
                            <p class="text-danger small error-message mt-1" id="forgotEmailError"></p>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 mb-3">Gửi liên kết</button>

                        <div class="text-center">
                            <a href="#" onclick="backToLogin()" class="text-secondary text-decoration-none">Quay lại
                                đăng nhập</a>
                        </div>
                    </form>
                </div>

                <div id="resetPasswordForm" style="display: none;">
                    <h2 class="text-center text-uppercase mb-4" style="color: #001c77">Đặt lại mật khẩu</h2>

                    <p class="text-muted text-center mb-4">Nhập mã xác thực đã được gửi đến email và thiết lập mật khẩu
                        mới</p>

                    <form id="resetPasswordFormElement" class="mb-3" novalidate>
                        <div class="mb-3">
                            <input type="text" id="resetCode" class="form-control" placeholder="Mã xác thực" required>
                            <p class="text-danger small error-message mt-1" id="resetCodeError"></p>
                        </div>

                        <div class="mb-3">
                            <input type="password" id="newPassword" class="form-control" placeholder="Mật khẩu mới"
                                   required>
                            <p class="text-danger small error-message mt-1" id="newPasswordError"></p>
                        </div>

                        <div class="mb-3">
                            <input type="password" id="confirmPassword" class="form-control"
                                   placeholder="Xác nhận mật khẩu" required>
                            <p class="text-danger small error-message mt-1" id="confirmPasswordError"></p>
                        </div>

                        <button type="submit" onclick="backToLogin()" class="btn btn-primary w-100 mb-3">Đặt lại mật
                            khẩu
                        </button>

                        <div class="text-center">
                            <a href="#" onclick="backToLogin()" class="text-secondary text-decoration-none">Quay lại
                                đăng nhập</a>
                        </div>
                    </form>
                </div>

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