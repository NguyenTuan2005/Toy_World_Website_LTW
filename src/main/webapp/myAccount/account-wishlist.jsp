<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Danh Sách Sản Phẩm Yêu Thích</title>
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
            <div class="sidebar position-sticky" style="top: 20px">
                <div class="sidebar-header">
                    <i class="fas fa-user-circle me-2"></i>
                    Tài Khoản Của Bạn
                </div>
                <ul class="sidebar-menu">
                    <li class="profile">
                        <button onclick="window.location.href='${pageContext.request.contextPath}/account/profile'" class="d-flex">
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
                        <button onclick="window.location.href='${pageContext.request.contextPath}/account/order-history'" class="d-flex">
                            <i class="bi bi-cart-fill me-2"></i>
                            Lịch sử mua hàng
                        </button>
                    </li>
                    <li>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/account/wishlist'" class="d-flex">
                            <i class="bi bi-heart-fill me-2"></i>
                            Danh sách yêu thích
                        </button>
                    </li>
                    <c:if test="${sessionScope.isAdmin}">
                        <li>
                            <button onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard'" class="d-flex">
                                <i class="bi bi-clipboard-data-fill me-2"></i>
                                Quản lí cửa hàng
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

        <!-- wishlist -->
        <div class="wrapper active col-lg-8 border-custom section" id="wishlist">

            <h3 style="margin-bottom: -15px;">
                Danh sách yêu thích
            </h3>

            <table class="wishlist-table">
                <thead>
                <tr>
                    <th>Ảnh</th>
                    <th>Tên Sản Phẩm</th>
                    <th class ="text-nowrap">Giá (VNĐ)</th>
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

                                <td class="text-nowrap">
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

    <!-- Remove Wishlist Modal -->
    <div class="modal fade" id="deleteWishListProductModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <form action="${pageContext.request.contextPath}/account/wishlist"
                      method="post">

                    <div class="modal-header">
                        <h5 class="modal-title">Xác nhận xóa</h5>
                        <button type="button" class="btn-close"
                                data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa sản phẩm này khỏi danh sách yêu thích không?
                    </div>

                    <!-- productId sẽ được gán bằng JS -->
                    <input type="hidden" name="productId" id="deleteWishlistProductId"/>

                    <div class="modal-footer">
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Hủy
                        </button>
                        <button type="submit"
                                class="btn btn-danger">
                            Xóa
                        </button>
                    </div>

                </form>

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

