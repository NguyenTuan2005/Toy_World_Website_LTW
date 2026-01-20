<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setLocale value="vi_VN"/>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Chi Tiết Đơn Hàng</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/order-details.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container-fluid">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/admin/orders"
                       class="btn-back mx-4 py-2 px-4 text-decoration-none">
                        <i class="bi bi-arrow-left" style="font-size: 1.2rem"></i>
                    </a>

                    <div>
                        <div class="order-title">
                            Đơn hàng #${orderDetail.id}
                            <span class="badge ms-3
                                ${orderDetail.paymentStatus eq 'DA_THANH_TOAN'
                                    ? 'bg-success bg-opacity-25 text-success'
                                    : 'bg-danger bg-opacity-25 text-danger'}">

                                ${orderDetail.paymentStatus eq 'DA_THANH_TOAN'
                                        ? 'Đã thanh toán'
                                        : 'Chưa thanh toán'}
                            </span>

                            <span class="badge ms-3 bg-primary bg-opacity-25 text-primary
                                ${orderDetail.orderStatus == 'DA_HUY' ? 'bg-danger bg-opacity-25 text-danger' :
                                  orderDetail.orderStatus == 'CHUAN_BI_HANG' ? 'bg-primary bg-opacity-25 text-primary' :
                                  'bg-success bg-opacity-25 text-success'}">
                                <c:choose>
                                    <c:when test="${orderDetail.orderStatus == 'DA_GIAO'}">Đã giao</c:when>
                                    <c:when test="${orderDetail.orderStatus == 'DANG_GIAO'}">Đang giao</c:when>
                                    <c:when test="${orderDetail.orderStatus == 'DA_HUY'}">Đã hủy</c:when>
                                    <c:when test="${orderDetail.orderStatus == 'CHUAN_BI_HANG'}">Chuẩn bị hàng</c:when>
                                </c:choose>
                            </span>
                        </div>
                        <div class="order-date">${orderDate}</div>
                    </div>
                </div>
                <div class="d-flex justify-content-start gap-3 me-3">
                    <button class="edit-btn" onclick="window.location.href='${pageContext.request.contextPath}/admin/orders/edit/${orderDetail.id}'">
                        <i class="bi bi-pencil-fill me-2"></i>Chỉnh sửa
                    </button>
                    <button class="delete-btn"
                            data-bs-toggle="modal"
                            data-bs-target="#deleteOrderModal"
                            data-id="${orderDetail.id}">
                        <i class="bi bi-trash-fill me-2"></i>Xóa đơn hàng
                    </button>
                </div>

            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row">
            <!-- Left Column -->
            <div class="col-lg-8">
                <!-- Order Details -->
                <div class="card-section">
                    <div class="section-title">
                        <span>Chi tiết đơn hàng</span>
                    </div>

                    <div class="table-responsive">
                        <table class="table product-table">
                            <thead>
                            <tr>
                                <th>SẢN PHẨM</th>
                                <th>GIÁ (VNĐ)</th>
                                <th>SỐ LƯỢNG</th>
                                <th>TỔNG (VNĐ)</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${orderDetail.items}" var="item">
                                <tr>
                                    <td>
                                        <div class="product-info">
                                            <img src="${item.imgPath}" class="product-image"
                                                 alt="${item.productName}"/>
                                            <div class="product-details">
                                                <div class="product-name">
                                                        ${item.productName}
                                                </div>
                                                <div class="product-meta">
                                                    Mã sản phẩm: ${item.productId}
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td><span class="price-text">
                                        <fmt:formatNumber value="${item.price}" pattern="#,##0"/>
                                        </span>
                                    </td>
                                    <td><span class="price-text">${item.quantity}</span></td>
                                    <td><span class="price-text">
                                        <fmt:formatNumber value="${item.totalPrice}" pattern="#,##0"/>
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4">
                        <div class="summary-row">
                            <span class="summary-label">Tổng giá:</span>
                            <span class="summary-value">
                                <fmt:formatNumber value="${orderDetail.totalItemBasePrice}" type="currency"
                                                  currencyCode="VND"/>
                            </span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Giảm giá:</span>
                            <span class="summary-value">
                                <fmt:formatNumber value="${orderDetail.discountPrice}" type="currency"
                                                  currencyCode="VND"/>
                            </span>
                        </div>
                        <div class="summary-row total-row">
                            <span class="summary-label">Tổng cộng:</span>
                            <span class="summary-value">
                                <fmt:formatNumber value="${orderDetail.totalPrice}" type="currency" currencyCode="VND"/>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column -->
            <div class="col-lg-4 pe-2">
                <div class="card-section">
                    <div class="section-title">
                        <span>Thông tin khách hàng</span>

                    </div>

                    <div class="customer-info-row">
                        <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' fill='%23f1f5f9'/%3E%3Ccircle cx='16' cy='12' r='4' fill='%2394a3b8'/%3E%3Cpath d='M16 18c-5 0-7 2.5-7 4v1h14v-1c0-1.5-2-4-7-4z' fill='%2394a3b8'/%3E%3C/svg%3E"
                                class="customer-avatar"
                                alt="Default Avatar"
                                style="width: 50px; height: 50px; border-radius: 50%; border: 1px solid #e2e8f0;"
                        />
                        <div>
                            <div class="customer-name">${orderDetail.customerLastName} ${orderDetail.customerFirstName}</div>
                        </div>
                    </div>

                    <div class="contact-info">
                        <div class="contact-title">Thông tin liên hệ</div>
                        <div class="contact-item">
                            Email: ${orderDetail.customerEmail}
                        </div>
                        <div class="contact-item">Số điện thoại: ${orderDetail.customerPhone}</div>
                    </div>
                </div>

                <!-- Shipping Address -->
                <div class="card-section">
                    <div class="section-title">
                        <span>Địa chỉ giao hàng</span>

                    </div>

                    <p class="address-text">
                        ${orderDetail.address}<br/>
                        ${orderDetail.province}<br/>
                        Việt Nam
                    </p>
                </div>
            </div>
        </div>
    </div>


<%--   --%>
    <div class="modal fade" id="deleteOrderModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/orders/delete" method="post">
                    <input type="hidden" name="orderId" value="${orderDetail.id}"/>

                    <div class="modal-header">
                        <h5 class="modal-title text-danger">Xác nhận xóa đơn hàng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <p>
                            Bạn có chắc chắn muốn <strong>xóa đơn hàng #${orderDetail.id}</strong> không?
                        </p>
                        <p class="text-muted small">
                            Hành động này không thể hoàn tác.
                        </p>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Hủy
                        </button>
                        <button type="submit" class="btn btn-danger">
                            Xóa Đơn Hàng
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>


</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('deleteModal').addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const productId = button.getAttribute('data-id');
        document.getElementById('deleteProductId').value = productId;
    });
</script>

</body>
</html>
