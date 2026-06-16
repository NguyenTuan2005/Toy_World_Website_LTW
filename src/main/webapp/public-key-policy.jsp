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





                        <div class="mb-4">
                            <i class="fas fa-times-circle text-danger"
                                style="font-size: 80px;"></i>
                        </div>

                        <div class="card shadow-sm border-0">
                            <div class="card-body p-4">

                                <h2 class="text-success mb-3">
                                    Chính sách tạo Public Key.
                                    Từ chối tạo khóa
                                </h2>

                                <p class="text-muted">
                                    Để đảm bảo tính toàn vẹn và an toàn của hệ thống chữ ký số,
                                    mỗi tài khoản chỉ được phép sử dụng một Public Key đang hoạt động tại một thời điểm.
                                </p>

                                <ul class="mt-3">
                                    <li>
                                        Nếu tài khoản chưa có Public Key đang hoạt động,
                                        hệ thống sẽ cho phép tạo mới cặp khóa (Public Key và Private Key).
                                    </li>

                                    <li>
                                        Nếu tài khoản đã có Public Key đang hoạt động và chưa khai báo mất khóa,
                                        hệ thống sẽ từ chối việc tạo khóa mới.
                                    </li>

                                    <li>
                                        Trong trường hợp mất Private Key hoặc nghi ngờ khóa bị lộ,
                                        người dùng phải thực hiện chức năng <strong>Báo mất khóa</strong>
                                        trước khi yêu cầu tạo khóa mới.
                                    </li>

                                    <li>
                                        Khi khóa cũ được đánh dấu là mất hoặc bị vô hiệu hóa,
                                        người dùng có thể tạo một cặp khóa mới.
                                    </li>

                                    <li>
                                        Người dùng có trách nhiệm lưu trữ Private Key ở nơi an toàn.
                                        Hệ thống không lưu trữ và không thể khôi phục Private Key đã cấp.
                                    </li>
                                </ul>

                                <div class="alert alert-warning mt-4">
                                    <strong>Lưu ý:</strong>
                                    Nếu bạn đang có Public Key hợp lệ trên hệ thống,
                                    chức năng tạo khóa mới sẽ bị khóa cho đến khi khóa hiện tại
                                    được báo mất hoặc bị vô hiệu hóa.
                                </div>

                            </div>
                        </div>

                        <a href="javascript:history.back();"
                           class="btn btn-danger mt-3">
                            <i class="fas fa-arrow-left me-2"></i>
                            Quay lại
                        </a>



            </div>
        </div>

    </div>
</main>

<jsp:include page="/common/footer.jsp" />
</body>
</html>