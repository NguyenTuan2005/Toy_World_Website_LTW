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
                            Chỉnh sửa Đơn hàng #${orderDetail.id}
                        </div>
                        <div class="order-date">${orderDate}</div>
                    </div>
                </div>
                <div class="d-flex justify-content-start gap-3 me-3">
                    <button class="edit-btn"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/orders'">
                        <i class="bi bi-x-lg me-2"></i>Hủy
                    </button>
                    <button type="submit" form="orderEditForm" class="delete-btn">
                        <i class="bi bi-floppy2 me-2"></i>Lưu thay đổi
                    </button>
                </div>

            </div>
        </div>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/admin/orders/edit/${orderDetail.id}"
          id="orderEditForm">

    <div class="container-fluid">
        <div class="row">

            <!-- Order Details -->
            <input type="hidden" name="orderId" value="${orderDetail.id}"/>
            <div class="col-lg-8">
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

                <div class="d-flex justify-content-between gap-3">

                <div class="card-section flex-fill">
                    <div class="section-title">
                        <span>Tình trạng đơn hàng</span>
                    </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Vận chuyển</label>
                            <select name="orderStatus" class="form-select">
                                <option value="CHUAN_BI_HANG"
                                ${orderDetail.orderStatus == 'CHUAN_BI_HANG' ? 'selected' : ''}>
                                    Chuẩn bị hàng
                                </option>
                                <option value="DANG_GIAO"
                                ${orderDetail.orderStatus == 'DANG_GIAO' ? 'selected' : ''}>
                                    Đang giao
                                </option>
                                <option value="DA_GIAO"
                                ${orderDetail.orderStatus == 'DA_GIAO' ? 'selected' : ''}>
                                    Đã giao
                                </option>
                                <option value="DA_HUY"
                                ${orderDetail.orderStatus == 'DA_HUY' ? 'selected' : ''}>
                                    Đã hủy
                                </option>
                            </select>
                        </div>

                        <!-- Payment Status -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Thanh toán</label>
                            <select name="paymentStatus" class="form-select">
                                <option value="CHUA_THANH_TOAN"
                                ${orderDetail.paymentStatus == 'CHUA_THANH_TOAN' ? 'selected' : ''}>
                                    Chưa thanh toán
                                </option>
                                <option value="DA_THANH_TOAN"
                                ${orderDetail.paymentStatus == 'THANH_CONG' ? 'selected' : ''}>
                                    Đã thanh toán
                                </option>
                                <option value="HOAN_TIEN"
                                ${orderDetail.paymentStatus == 'HOAN_TIEN' ? 'selected' : ''}>
                                    Hoàn tiền
                                </option>
                            </select>
                        </div>
                </div>

                <div class="card-section flex-fill">
                    <div class="section-title">
                        <span>Thời gian đặt đơn hàng</span>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Thời gian đặt hàng</label>
                        <input type="datetime-local"
                               name="createdAt"
                               class="form-control"
                               value="${orderDate}"/>
                    </div>
                </div>
                </div>
            </div>

            <!-- User Info -->
            <input type="hidden" name="customerId" value="${orderDetail.customerId}"/>
            <input type="hidden" name="locationId" value="${orderDetail.locationId}"/>

            <div class="col-lg-4 pe-2">
                <div class="card-section">
                    <div class="section-title">
                        <span>Thông tin khách hàng</span>
                    </div>

                    <div class="customer-info-row align-items-center">
                        <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3E%3Ccircle cx='24' cy='24' r='24' fill='%2393c5fd'/%3E%3Ctext x='50%25' y='50%25' dominant-baseline='middle' text-anchor='middle' font-size='20' fill='white' font-weight='600'%3EST%3C/text%3E%3C/svg%3E"
                             class="customer-avatar"
                             alt="avatar"/>

                        <div class="w-100">
                            <div class="row g-2">
                                <div class="col-6">
                                    <label class="form-label mb-1">Họ</label>
                                    <input type="text"
                                           class="form-control"
                                           name="customerLastName"
                                           value="${orderDetail.customerLastName}"
                                           required/>
                                </div>
                                <div class="col-6">
                                    <label class="form-label mb-1">Tên</label>
                                    <input type="text"
                                           class="form-control"
                                           name="customerFirstName"
                                           value="${orderDetail.customerFirstName}"
                                           required/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="contact-info mt-3">
                        <div class="contact-title">Thông tin liên hệ</div>

                        <div class="mb-2">
                            <label class="form-label">Email</label>
                            <input type="email"
                                   class="form-control"
                                   name="customerEmail"
                                   value="${orderDetail.customerEmail}"
                                   required/>
                        </div>

                        <div>
                            <label class="form-label">Số điện thoại</label>
                            <input type="text"
                                   class="form-control"
                                   name="customerPhone"
                                   value="${orderDetail.customerPhone}"
                                   required/>
                        </div>
                    </div>
                </div>


                <!-- Shipping Address -->
                <div class="card-section mt-3">
                    <div class="section-title">
                        <span>Địa chỉ giao hàng</span>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Địa chỉ</label>
                        <textarea class="form-control"
                                  name="address"
                                  rows="2"
                                  required>${orderDetail.address}</textarea>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Tỉnh / Thành phố</label>
                        <input type="text"
                               class="form-control"
                               name="province"
                               value="${orderDetail.province}"
                               required/>
                    </div>

                    <div class="text-muted">Việt Nam</div>
                </div>
            </div>

        </div>
        </div>
    </div>

    </form>
</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
