<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Tài Khoản Của Bạn</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="css/my-account.css"/>
    <link rel="stylesheet" href="css/header.css"/>
    <link rel="stylesheet" href="css/root.css"/>

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
                        <button onclick="showSection('profile')" class="d-flex">
                            <i class="bi bi-person-fill me-2"></i>
                            Tài khoản
                        </button>
                    </li>
                    <li>
                        <button onclick="showSection('history')" class="d-flex">
                            <i class="bi bi-cart-fill me-2"></i>
                            Lịch sử mua hàng
                        </button>
                    </li>
                    <li>
                        <button onclick="showSection('wishlist')" class="d-flex">
                            <i class="bi bi-heart-fill me-2"></i>
                            Danh sách yêu thích
                        </button>
                    </li>
                    <li>
                        <button onclick="showSection('location')" class="d-flex">
                            <i class="bi bi-geo-alt-fill me-2"></i>
                            Địa chỉ giao hàng
                        </button>
                    </li>
                    <li>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard'" class="d-flex">
                            <i class="bi bi-clipboard-data-fill me-2"></i>
                            Quản lí cửa hàng
                        </button>
                    </li>
                    <li>
                        <button class="btn d-flex" data-bs-toggle="modal" data-bs-target="#logoutModal">
                            <i class="bi bi-door-open-fill me-2"></i>
                            Đăng xuất
                        </button>
                    </li>
                </ul>
            </div>
        </div>

        <!-- my account -->
        <div class="col-lg-8 col-md-7 section active " id="profile">
            <div class="content-card">
                <h3 class="content-title">
                    Thông Tin Tài Khoản
                </h3>

                <div class="info-row">
                    <div class="info-label">
                            <span class="icon-wrapper">
                                <i class="fas fa-user"></i>
                            </span>
                        Họ và tên
                    </div>
                    <div class="info-value">${sessionScope.currentUser.lastName} ${sessionScope.currentUser.firstName}</div>
                </div>

                <div class="info-row">
                    <div class="info-label">
                            <span class="icon-wrapper">
                                <i class="fas fa-phone"></i>
                            </span>
                        Điện thoại
                    </div>
                    <div class="info-value">${sessionScope.currentUser.phone}</div>
                </div>

                <div class="info-row">
                    <div class="info-label">
                            <span class="icon-wrapper">
                                <i class="fas fa-envelope"></i>
                            </span>
                        Email
                    </div>
                    <div class="info-value">${sessionScope.currentUser.email}</div>
                </div>
            </div>
        </div>

        <!-- address -->
        <div class="address-wrapper col-lg-8 border-custom section" id="location">
            <div class="address-header">
                <h3>Địa chỉ giao hàng</h3>
                <button class="btn-edit" id="btnEditAddress">
                    <i class="fas fa-pen"></i>Chỉnh Sửa
                </button>
            </div>

            <div class="address-card">
                <h4 id="displayName">Nguyễn Hữu Duy</h4>
                <p><i class="bi bi-geo-alt-fill me-2"></i> <span id="displayAddress">${sessionScope.currentUserLocation.address}</span></p>
                <p><i class="bi bi-telephone-fill me-2"></i> <span id="displayPhone">${sessionScope.currentUser.phone}</span></p>
                <p><i class="bi bi-envelope-fill me-2"></i> <span id="displayEmail">${sessionScope.currentUser.email}</span></p>
            </div>

            <div class="edit-address-form" id="editAddressForm">
                <h4>Chỉnh sửa địa chỉ giao hàng</h4>

                <label>Họ tên</label>
                <input type="text" id="inputName">

                <label>Địa chỉ</label>
                <input type="text" id="inputAddress">

                <label>Số điện thoại</label>
                <input type="text" id="inputPhone">

                <label>Email</label>
                <input type="email" id="inputEmail">

                <div class="form-actions">
                    <button id="btnSaveAddress" class="btn-save">Lưu</button>
                    <button id="btnCancelEdit" class="btn-cancel">Hủy</button>
                </div>
            </div>

        </div>

        <!-- order history -->
        <div class="container col-lg-8 border-custom section" id="history" style="padding: 20px;">
            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="mb-0">Lịch Sử Mua Hàng</h4>

                <div class="input-group" style="max-width: 300px;">
                        <span class="input-group-text bg-white">
                        <img src="https://cdn-icons-png.flaticon.com/512/54/54481.png" width="16">
                        </span>
                    <input type="text" class="form-control" id="searchInput"
                           placeholder="Tìm kiếm đơn hàng">
                </div>
            </div>
            <!-- Khi có đơn hàng -->
            <table id="orderTable">
                <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Hình sản phẩm</th>
                </tr>
                </thead>
                <tbody>
                <!-- Ví dụ mẫu -->
                <tr>
                    <td>DH001</td>
                    <td>08/11/2025</td>
                    <td>1,200,000đ</td>
                    <td>Đang giao</td>
                    <td>
                        <img class="product-img"
                             src="https://www.mykingdom.com.vn/cdn/shop/files/sieu-xe-sang-trong-honda-civic-fd2-type-r-hot-wheels-jbk53-fpy86_3.jpg?v=1759833234&width=1946"
                             alt="product">
                    </td>
                </tr>
                <tr>

                    <td>DH002</td>
                    <td>05/11/2025</td>
                    <td>350,000đ</td>
                    <td>Hoàn tất</td>
                    <td>
                        <img class="product-img"
                             src="https://www.mykingdom.com.vn/cdn/shop/files/sieu-xe-sang-trong-honda-civic-fd2-type-r-hot-wheels-jbk53-fpy86_3.jpg?v=1759833234&width=1946"
                             alt="product">
                    </td>
                </tr>
                </tbody>
            </table>

        </div>

        <!-- wish list items -->
        <div class="wishlist-wrapper col-lg-8 border-custom section" id="wishlist">

            <h3 style="margin-bottom: -15px;">
                Danh sách yêu thích
            </h3>

            <table class="wishlist-table">
                <thead>
                <tr>
                    <th>Ảnh</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Giá (VNĐ)</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty wishlist}">
                        <tr>
                            <td colspan="5" class="text-center">
                                Chưa có sản phẩm yêu thích
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="item" items="${wishlist}">
                            <tr>
                                <td>
                                    <img src="${item.imgPath}"
                                         class="product-img"
                                         alt="${item.name}">
                                </td>

                                <td>${item.name}</td>

                                <td>
                                    <fmt:formatNumber value="${item.price}"
                                                      type="currency"
                                                      currencySymbol="₫"/>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${item.quantity > 0}">
                                            <span class="text-success">Còn hàng</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-danger">Hết hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-link text-decoration-none" style="color: #007bff;"
                                                onclick="location.href='${pageContext.request.contextPath}/products/${item.productId}'">
                                            <i class="bi bi-eye-fill"></i>
                                        </button>

                                        <button class="btn btn-link text-danger"
                                                data-bs-toggle="modal"
                                                data-bs-target="#deleteWishListProductModal"
                                                data-id="${item.productId}">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>

            </table>

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
                    <button type="button" class="btn btn-secondary" style="backgroundcolor: lightgray" data-bs-dismiss="modal">Hủy</button>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="btn btn-danger"  style="backgroundcolor: #cf102d">Đăng xuất</a>
                </div>
            </div>
        </div>
    </div>


</div>

<jsp:include page="/common/footer.jsp"/>

<script src="js/index.js"></script>
<script src="js/my-account.js"></script>
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

