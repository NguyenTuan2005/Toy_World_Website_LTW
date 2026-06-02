<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Giới thiệu & Liên hệ</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp"/>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/header.css" />
    <link rel="stylesheet" href="css/root.css" />
</head>
<body>
<jsp:include page="/common/header.jsp" />

<main>
    <div class="container mt-5 mb-5">

        <div class="card shadow-sm">
            <div class="card-body text-center p-5">

                <c:choose>

                    <c:when test="${success}">

                        <div class="mb-4">
                            <i class="fas fa-circle-check text-success"
                               style="font-size: 80px;"></i>
                        </div>

                        <h2 class="text-success mb-3">
                            Lưu Public Key thành công
                        </h2>

                        <p class="text-muted">
                            Public Key của bạn đã được cập nhật vào hệ thống.
                        </p>

                        <a href="${pageContext.request.contextPath}/public-key"
                           class="btn btn-success mt-3">
                            <i class="fas fa-arrow-left me-2"></i>
                            Quay lại
                        </a>

                    </c:when>

                    <c:otherwise>

                        <div class="mb-4">
                            <i class="fas fa-circle-xmark text-danger"
                               style="font-size: 80px;"></i>
                        </div>

                        <h2 class="text-danger mb-3">
                            Lưu Public Key thất bại
                        </h2>

                        <p class="text-muted">
                            Đã xảy ra lỗi trong quá trình lưu Public Key.
                        </p>

                        <a href="${pageContext.request.contextPath}/public-key"
                           class="btn btn-danger mt-3">
                            <i class="fas fa-rotate-right me-2"></i>
                            Thử lại
                        </a>

                    </c:otherwise>

                </c:choose>

            </div>
        </div>

    </div>
</main>

<jsp:include page="/common/footer.jsp" />
</body>
</html>