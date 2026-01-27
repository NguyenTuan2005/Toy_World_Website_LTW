<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Tài Khoản Của Bạn</title>
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

        <!-- my profile -->
        <div class="wrapper col-lg-8 col-md-7 section active" id="profile">

            <div class="d-flex align-items-center">
                <div class="avatar me-3">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' fill='%23f1f5f9'/%3E%3Ccircle cx='16' cy='12' r='4' fill='%2394a3b8'/%3E%3Cpath d='M16 18c-5 0-7 2.5-7 4v1h14v-1c0-1.5-2-4-7-4z' fill='%2394a3b8'/%3E%3C/svg%3E"
                         class="customer-avatar"
                         alt="Default Avatar"
                         style="width: 50px; height: 50px; border-radius: 50%; border: 1px solid #e2e8f0;">
                </div>

                <div>
                    <h4 class="mb-1">
                        ${sessionScope.currentUser.lastName}
                        ${sessionScope.currentUser.firstName}
                    </h4>
                    <span class="text-muted">Thông tin cá nhân</span>
                </div>

                <!-- Đẩy sang phải -->
                <button class="edit-btn ms-auto"
                        onclick="window.location.href='${pageContext.request.contextPath}/account/profile/edit'">
                    <i class="bi bi-pencil-fill me-2"></i>Chỉnh sửa
                </button>
            </div>

            <hr>

            <div class="row profile-info">
                <div class="col-md-6">
                    <div class="info-item">
                        <i class="bi bi-person"></i>
                        <div>
                            <span>Họ và tên</span>
                            <p>
                                ${sessionScope.currentUser.lastName}
                                ${sessionScope.currentUser.firstName}
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="info-item">
                        <i class="bi bi-telephone"></i>
                        <div>
                            <span>Số điện thoại</span>
                            <p>${sessionScope.currentUser.phone}</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="info-item">
                        <i class="bi bi-envelope"></i>
                        <div>
                            <span>Email</span>
                            <p>${sessionScope.currentUser.email}</p>
                        </div>
                    </div>
                </div>

                <!-- ĐỊA CHỈ -->
                <div class="col-md-6">
                    <div class="info-item">
                        <i class="bi bi-geo-alt"></i>
                        <div>
                            <span>Địa chỉ</span>
                            <p>
                                ${sessionScope.currentUserLocation.address},
                                ${sessionScope.currentUserLocation.province}
                            </p>
                        </div>
                    </div>
                </div>
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
<script>
    document.addEventListener("show.bs.modal", function (event) {
        const modal = document.getElementById("deleteWishListProductModal");
        if (!modal) return;

        const button = event.relatedTarget;
        if (!button) return;

        const productId = button.getAttribute("data-id");
        modal.querySelector("#deleteWishlistProductId").value = productId;
    });
</script>

</body>
</html>

