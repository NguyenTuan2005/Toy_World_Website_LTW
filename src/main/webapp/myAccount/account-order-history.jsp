<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <style>
        .order-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .order-card {
            background: #f8f9fa;
            border-radius: 14px;
            padding: 16px 18px;
            border: 1px solid #e5e7eb;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .order-footer {
            text-align: right;
            margin-top: 10px;
        }

        .order-products {
            border-top: 1px dashed #ddd;
            margin-top: 12px;
            padding-top: 12px;
        }

        .product-item {
            display: flex;
            gap: 12px;
            margin-bottom: 10px;
        }

        .product-item img {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid #ddd;
        }

        .product-info .name {
            font-weight: 600;
        }

        .qty-price {
            font-size: 14px;
            color: #666;
        }

        .text-blue{
            color: #007bff;
        }

    </style>
</head>
<body>
<jsp:include page="/common/header.jsp"/>


<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100">
    <%--    delete--%>
    <c:if test="${not empty sessionScope.MSG_SUCCESS}">
        <div id="successToast"
             class="toast align-items-center text-bg-success border-0"
             role="alert"
             aria-live="assertive"
             aria-atomic="true"
             data-bs-delay="3000"
             data-bs-autohide="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="bi bi-check-circle-fill me-2"></i>
                        ${sessionScope.MSG_SUCCESS}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast"></button>
            </div>
        </div>
        <c:remove var="MSG_SUCCESS" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.MSG_ERROR}">
        <div id="errorToast"
             class="toast align-items-center text-bg-danger border-0"
             role="alert"
             aria-live="assertive"
             aria-atomic="true"
             data-bs-delay="3000"
             data-bs-autohide="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="bi bi-x-circle-fill me-2"></i>
                        ${sessionScope.MSG_ERROR}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast"></button>
            </div>
        </div>
        <c:remove var="MSG_ERROR" scope="session"/>
    </c:if>

</div>

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
                        <button onclick="window.location.href='${pageContext.request.contextPath}/account/profile'"
                                class="d-flex">
                            <i class="bi bi-person-fill me-2"></i>
                            Tài khoản
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

        <!-- orders -->
        <div class="wishlist-wrapper col-lg-8 col-md-7 section active" id="order-history">
            <div class="profile-card">
                <div class="d-flex justify-content-between align-items-center">
                    <h3 class="mb-3">
                        Lịch sử đơn hàng
                    </h3>

                    <form action="${pageContext.request.contextPath}/account/order-history"
                          method="get"
                          class="mb-3">

                        <div class="d-flex gap-2 align-items-center">
                            <div class="input-group shadow-sm rounded-pill overflow-hidden flex-grow-1">

                                <span class="input-group-text bg-primary text-white border-0">
                                    <i class="bi bi-search"></i>
                                </span>

                                <input type="text"
                                       name="keyword"
                                       value="${fn:escapeXml(param.keyword)}"
                                       class="form-control border-0"
                                       placeholder="Tìm theo mã đơn "
                                       style="width: 250px;">
                            </div>
                        </div>
                    </form>
                </div>


                <c:choose>
                    <c:when test="${empty orders}">
                        <div class="text-center text-muted py-5">
                            <i class="bi bi-box-seam fs-1"></i>
                            <p class="mt-3">Không có đơn hàng nào!</p>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="order-list">

                            <c:forEach var="order" items="${orders}">
                                <div class="order-card">

                                    <!-- HEADER -->
                                    <div class="order-header">
                                        <div>
                                            <strong>Đơn #${order.id}</strong>
                                            <div class="text-muted small">
                                                    ${order.createdAt}
                                            </div>
                                        </div>

                                        <div class="d-flex gap-2">
                                            <c:choose>
                                                <c:when test="${order.orderStatus == 'CHUAN_BI_HANG'}">
                                                    <span class="badge bg-primary-subtle text-blue">Chuẩn bị hàng</span>
                                                </c:when>

                                                <c:when test="${order.orderStatus == 'DANG_GIAO'}">
                                                    <span class="badge bg-success-subtle text-success">Đang giao</span>
                                                </c:when>

                                                <c:when test="${order.orderStatus == 'DA_GIAO'}">
                                                    <span class="badge bg-success-subtle text-success">Đã Giao</span>
                                                </c:when>

                                                <c:when test="${order.orderStatus == 'DA_HUY'}">
                                                    <span class="badge bg-danger-subtle text-danger">Đã hủy</span>
                                                </c:when>
                                            </c:choose>


                                            <c:choose>
                                                <c:when test="${order.paymentStatus == 'CHUA_THANH_TOAN'}">
                                                    <span class="badge bg-danger-subtle text-danger">Chưa thanh toán</span>
                                                </c:when>

                                                <c:when test="${order.paymentStatus == 'DA_THANH_TOAN'}">
                                                    <span class="badge bg-success-subtle text-success">Đã thanh toán</span>
                                                </c:when>

                                                <c:when test="${order.paymentStatus == 'HOAN_TIEN'}">
                                                    <span class="badge bg-dark-subtle text-dark">Hoàn tiền</span>
                                                </c:when>
                                            </c:choose>

                                        </div>
                                    </div>

                                    <!-- PRODUCTS -->
                                    <div class="order-products">
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="product-item">
                                                <img src="${item.imgPath}"
                                                     alt="${item.productName}">
                                                <div class="product-info">
                                                    <div class="name">${item.productName}</div>
                                                    <div class="qty-price">
                                                        SL: ${item.quantity} ×
                                                        <fmt:formatNumber value="${item.price}"
                                                                          type="currency"
                                                                          currencySymbol="₫"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <!-- FOOTER -->
                                    <div class="order-footer d-flex justify-content-between align-items-center">
                                        <span>
                                            Tổng tiền:
                                            <strong>
                                                <fmt:formatNumber value="${order.totalPrice}"
                                                                  type="currency"
                                                                  currencySymbol="₫"/>
                                            </strong>
                                        </span>

                                        <c:if test="${order.orderStatus == 'CHUAN_BI_HANG'}">
                                            <button class="btn btn-outline-danger btn-sm"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#cancelOrderModal"
                                                    data-order-id="${order.id}">
                                                <strong>Hủy đơn</strong>
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </c:otherwise>
                </c:choose>

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

    <!-- cancel Modal -->
    <div class="modal fade" id="cancelOrderModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <form action="${pageContext.request.contextPath}/account/order-history/cancel"
                      method="post">

                    <div class="modal-header">
                        <h5 class="modal-title">Xác nhận hủy đơn hàng</h5>
                        <button type="button" class="btn-close"
                                data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn <strong>hủy đơn hàng này</strong> không?</p>
                        <p class="text-muted mb-0">
                            Hành động này không thể hoàn tác.
                        </p>
                    </div>

                    <input type="hidden" name="orderId" id="cancelOrderId"/>

                    <div class="modal-footer">
                        <button type="button"
                                class="btn btn-light"
                                data-bs-dismiss="modal">
                            Không
                        </button>
                        <button type="submit"
                                class="btn btn-danger">
                            Xác nhận hủy
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
        const modal = document.getElementById("cancelOrderModal");
        if (!modal) return;

        const button = event.relatedTarget;
        if (!button) return;

        const orderId = button.getAttribute("data-order-id");
        modal.querySelector("#cancelOrderId").value = orderId;
    });

    document.addEventListener("DOMContentLoaded", function () {
        const successToastEl = document.getElementById("successToast");
        if (successToastEl) {
            new bootstrap.Toast(successToastEl).show();
        }

        const errorToastEl = document.getElementById("errorToast");
        if (errorToastEl) {
            new bootstrap.Toast(errorToastEl).show();
        }
    });
</script>


</body>
</html>

