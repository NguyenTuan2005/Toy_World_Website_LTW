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
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">

                <div class="card shadow border-0">
                    <div class="card-body text-center p-5">

                        <div class="mb-4">
                            <i class="fas fa-times-circle text-danger"
                               style="font-size: 5rem;"></i>
                        </div>

                        <h3 class="fw-bold mb-3">
                            Đơn hàng không đủ điều kiện
                        </h3>

                        <p class="text-muted mb-4">
                            Hãy upload lại Public Key để tiếp tục mua hàng.
                            <strong>${username}</strong>. trong thời gian chưa tạo khóa mới bạn sẽ bị tạm khóa không cho mua hàng.
                        </p>



                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/"
                               class="btn btn-primary">
                                <i class="fas fa-home me-2"></i>
                                Về trang chủ
                            </a>

                            <a href="${pageContext.request.contextPath}/profile"
                               class="btn btn-outline-secondary ms-2">
                                <i class="fas fa-user me-2"></i>
                                Trang cá nhân
                            </a>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</main>

<jsp:include page="/common/footer.jsp" />
</body>
</html>