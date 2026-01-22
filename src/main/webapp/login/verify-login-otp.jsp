<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xác thực mã otp</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp"/>

</head>
<body>
<jsp:include page="/common/header.jsp"/>
<div class="top-bar" role="navigation" aria-label="Breadcrumb and page header">
    <div class="container">
        <nav class="breadcrumb" aria-label="Breadcrumb" style="margin-left: -1px; ">
            <a href="${pageContext.request.contextPath}/home" aria-label="Trang Chủ">Trang Chủ</a>
            <svg class="crumb-sep" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M9 6l6 6-6 6" stroke="#8b8b8b" stroke-width="2" stroke-linecap="round"
                      stroke-linejoin="round"/>
            </svg>
            <a href="${pageContext.request.contextPath}/verify-login-otp" style="width: 235px; color:#444;">Xác thực mã otp</a>
        </nav>
    </div>
</div>

<div class="container my-5 d-flex justify-content-center align-items-center" style="min-height: 60vh;">
    <div class="card shadow" style="width: 100%; max-width: 450px;">
        <div class="card-body p-4">

            <button class="btn btn-sm mb-3" onclick="window.location.href='${pageContext.request.contextPath}/forgot-password'">
                <i class="bi bi-arrow-left"></i>
                Quay lại
            </button>

            <h2 class="card-title text-center mb-2" style="color: #041675;">Xác thực OTP</h2>
            <h3 class="text-center text-muted mb-4" style="font-size: 1rem;">Nhập mã xác thực đã được gửi đến email của
                bạn</h3>

            <c:choose>
            <c:when test="${not empty error}">
            <div id="alert" class="alert alert-danger text-center mb-4" role="alert">
                    ${error}
                </c:when>
                <c:otherwise>
                <div id="alert" class="alert alert-info text-center mb-4">
                    Mã OTP sẽ hết hạn trong: <strong id="countdownValue">${otpDelay != null ? otpDelay : 120}</strong>
                    giây
                    </c:otherwise>
                    </c:choose>
                </div>

                <form method="post" action="${pageContext.request.contextPath}/verify-login-otp">

                    <div class="mb-3">
                        <label for="otpCode" class="form-label">Mã OTP</label>
                        <input type="text" class="form-control" id="otpCode" name="otpCode"
                               placeholder="Nhập mã 6 số" maxlength="6" required autofocus>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Xác nhận</button>
                </form>

                <div class="hstack justify-content-center align-items-center mt-3">
                    <small class="text-muted">Không nhận được mã?
                    </small>
                    <form class="ms-1 mb-0" method="post" action="${pageContext.request.contextPath}/forgot-password">
                        <button type="submit" class="btn btn-link p-0 align-baseline">Gửi lại</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        let timeLeft = ${otpDelay != null ? otpDelay : 120};
        const countdownElement = document.getElementById('countdownValue');

        const timer = setInterval(function () {
            timeLeft--;
            countdownElement.textContent = timeLeft;

            if (timeLeft <= 0) {
                clearInterval(timer);
                countdownElement.textContent = '0';
                let alert = document.getElementById('alert');
                alert.classList.remove('alert-info');
                alert.classList.add('alert-danger');
                alert.textContent = 'Mã OTP đã hết hạn. Vui lòng yêu cầu mã mới.';
            }
        }, 1000);
    </script>

    <jsp:include page="/common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
