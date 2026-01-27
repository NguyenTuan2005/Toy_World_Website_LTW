<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Đổi Mật Khẩu</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/my-account.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
</head>
<body>
<jsp:include page="/common/header.jsp"/>


<div class="dashboard-container">
    <h1 class="header-title">Tài Khoản Của Bạn</h1>

    <div class="row">
        <div class="col-lg-4 col-md-5">
            <div class="sidebar">
                <div class="sidebar-header">
                    <i class="fas fa-user-circle me-2"></i>
                    Tài Khoản Của Bạn
                </div>
                <ul class="sidebar-menu">
                    <li class="profile">
                        <button onclick="window.location.href='${pageContext.request.contextPath}/account/profile'"
                                class="d-flex">
                            <i class="bi bi-person-fill me-2"></i>
                            Tài khoản
                        </button>
                    </li>
                    <li>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/account/change-password'"
                                class="d-flex">
                            <i class="bi bi-shield-lock-fill me-2"></i>
                            Đổi mật khẩu
                        </button>
                    </li>
                    <li>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/account/order-history'"
                                class="d-flex">
                            <i class="bi bi-cart-fill me-2"></i>
                            Lịch sử mua hàng
                        </button>
                    </li>
                    <li>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/account/wishlist'"
                                class="d-flex">
                            <i class="bi bi-heart-fill me-2"></i>
                            Danh sách yêu thích
                        </button>
                    </li>
                    <c:if test="${sessionScope.isAdmin}">
                        <li>
                            <button onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard'"
                                    class="d-flex">
                                <i class="bi bi-clipboard-data-fill me-2"></i>
                                Quản lý cửa hàng
                            </button>
                        </li>
                    </c:if>
                    <li>
                        <button class="btn d-flex" data-bs-toggle="modal" data-bs-target="#logoutModal">
                            <i class="bi bi-door-open-fill me-2"></i>
                            Đăng xuất
                        </button>
                    </li>
                </ul>
            </div>
        </div>

        <!-- change password -->
        <div class="wrapper col-lg-8 col-md-7 section active">

            <h3 class="mb-4 text-center">Đổi mật khẩu</h3>

            <div class="password-card">

                <!-- THÔNG BÁO -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="bi bi-check-circle-fill me-2"></i>
                            ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/account/change-password"
                      method="post">

                    <div class="mb-3">
                        <label class="form-label">Mật khẩu hiện tại</label>
                        <input type="password"
                               name="currentPassword"
                               class="form-control"
                               required>
                    </div>


                    <div class="mb-3">
                        <label class="form-label">Mật khẩu mới</label>
                        <input type="password"
                               name="newPassword"
                               class="form-control"
                               required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Nhập lại mật khẩu mới</label>
                        <input type="password"
                               name="confirmPassword"
                               class="form-control"
                               required>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/account/profile" class="btn btn-light">
                            <i class="bi bi-arrow-left me-2"></i>Quay lại
                        </a>

                        <button type="submit" class="btn btn-danger">
                            <i class="bi bi-floppy2 me-2"></i>Lưu thay đổi
                        </button>
                    </div>

                </form>
            </div>

        </div>
    </div>

    <!-- Logout Modal -->
    <div class="modal fade" id="logoutModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận đăng xuất</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    Bạn có chắc chắn muốn đăng xuất không?
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" style="backgroundcolor: lightgray"
                            data-bs-dismiss="modal">Hủy
                    </button>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="btn btn-danger" style="backgroundcolor: #cf102d">Đăng xuất</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

