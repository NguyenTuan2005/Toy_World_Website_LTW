<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Chi Tiết Đơn Hàng</title>

    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    />
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"
    />
    <link rel="stylesheet" href="css/order-details.css"/>
    <link rel="stylesheet" href="../css/root.css"/>

    <link rel="stylesheet" href="css/index.css"/>
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container-fluid">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <a
                            href="orders.jsp"
                            class="btn-back mx-4 py-2 px-4 text-decoration-none"
                    >
                        <i class="bi bi-arrow-left" style="font-size: 1.2rem"></i>
                    </a>

                    <div>
                        <div class="order-title">
                            Đơn hàng #32543
                            <span class="status-badge badge-yellow">Đang Giao</span>
                            <span class="status-badge badge-green">Đã Thanh Toán</span>
                        </div>
                        <div class="order-date">23 Tháng 9, 2025, 8:48 (UTC)</div>
                    </div>
                </div>
                <button class="delete-btn">Xóa đơn hàng</button>
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
                        <a href="#" class="edit-link">Chỉnh sửa</a>
                    </div>

                    <div class="table-responsive">
                        <table class="table product-table">
                            <thead>
                            <tr>
                                <th style="width: 30px">
                                    <input class="form-check-input" type="checkbox"/>
                                </th>
                                <th>SẢN PHẨM</th>
                                <th>GIÁ</th>
                                <th>SỐ LƯỢNG</th>
                                <th>TỔNG</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <input class="form-check-input" type="checkbox"/>
                                </td>
                                <td>
                                    <div class="product-info">
                                        <img
                                                src="https://www.mykingdom.com.vn/cdn/shop/products/179795_1.jpg?v=1742374683&width=600"
                                                class="product-image"
                                                alt="Con Quay B-193 Booster Ultimate Valkyrie.Lg.V-9 BEYBLADE 6 179795"
                                        />
                                        <div class="product-details">
                                            <div class="product-name">
                                                Con Quay B-193 Booster Ultimate
                                                Valkyrie.Lg.V-9 BEYBLADE 6 179795
                                            </div>
                                            <div class="product-meta">
                                                Mã sản phẩm: 02754
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="price-text">759.300 đ</span></td>
                                <td><span class="price-text">1</span></td>
                                <td><span class="price-text">759.300 đ</span></td>
                            </tr>

                            <tr>
                                <td>
                                    <input class="form-check-input" type="checkbox"/>
                                </td>
                                <td>
                                    <div class="product-info">
                                        <img
                                                src="https://www.mykingdom.com.vn/cdn/shop/files/do-choi-lap-rap-xe-ferrari-sf-24-f1-lego-technic-42207_0.jpg?v=1740971660&width=990"
                                                class="product-image"
                                                alt="Đồ Chơi Lắp Ráp Xe Ferrari SF-24 F1 LEGO TECHNIC"
                                        />
                                        <div class="product-details">
                                            <div class="product-name">
                                                Đồ Chơi Lắp Ráp Xe Ferrari SF-24 F1 LEGO
                                                TECHNIC 42207
                                            </div>
                                            <div class="product-meta">
                                                Mã sản phẩm: 42207
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="price-text">500.000 đ</span></td>
                                <td><span class="price-text">1</span></td>
                                <td><span class="price-text">500.000 đ</span></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4">
                        <div class="summary-row">
                            <span class="summary-label">Tổng giá:</span>
                            <span class="summary-value">1.259.300 đ</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Giảm giá:</span>
                            <span class="summary-value">500.000 đ</span>
                        </div>
                        <div class="summary-row total-row">
                            <span class="summary-label">Tổng cộng:</span>
                            <span class="summary-value">759.300 đ</span>
                        </div>
                    </div>
                </div>

                <!-- Shipping Activity -->
                <div class="card-section">
                    <div class="section-title">
                        <span>Hoạt động giao hàng</span>
                    </div>

                    <div class="timeline">
                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <div>
                                    <div class="timeline-title">
                                        Đơn hàng đã được đặt (Mã: #32543)
                                    </div>
                                    <div class="timeline-description">
                                        Đơn hàng của bạn đã được đặt thành công
                                    </div>
                                </div>
                                <div class="timeline-time">Thứ Ba 11:29 AM</div>
                            </div>
                        </div>

                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <div>
                                    <div class="timeline-title">Nhận hàng</div>
                                    <div class="timeline-description">
                                        Lịch nhận hàng đã được sắp xếp với bên vận chuyển
                                    </div>
                                </div>
                                <div class="timeline-time">Thứ Tư 11:29 AM</div>
                            </div>
                        </div>

                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <div>
                                    <div class="timeline-title">Đã gửi đi</div>
                                    <div class="timeline-description">
                                        Hàng đã được bên vận chuyển nhận
                                    </div>
                                </div>
                                <div class="timeline-time">Thứ Năm 11:29 AM</div>
                            </div>
                        </div>

                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <div>
                                    <div class="timeline-title">Hàng đã đến kho</div>
                                    <div class="timeline-description">
                                        Hàng đã đến kho Tân Phú Trung tại Tp.HCM
                                    </div>
                                </div>
                                <div class="timeline-time">Thứ Bảy 15:20 AM</div>
                            </div>
                        </div>

                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <div>
                                    <div class="timeline-title">Đang giao hàng</div>
                                    <div class="timeline-description">
                                        Hàng đã rời kho Tân Phú Trung tại Tp.HCM
                                    </div>
                                </div>
                                <div class="timeline-time">Hôm nay 14:12 PM</div>
                            </div>
                        </div>

                        <div class="timeline-item">
                            <div class="timeline-dot inactive"></div>
                            <div class="timeline-content">
                                <div>
                                    <div class="timeline-title">Giao hàng</div>
                                    <div class="timeline-description">
                                        Dự kiến giao hàng vào ngày mai
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column -->
            <div class="col-lg-4">
                <div class="card-section">
                    <div class="section-title">
                        <span>Thông tin khách hàng</span>
                        <a href="#" class="edit-link">Chỉnh sửa</a>
                    </div>

                    <div class="customer-info-row">
                        <img
                                src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3E%3Ccircle cx='24' cy='24' r='24' fill='%2393c5fd'/%3E%3Ctext x='50%25' y='50%25' dominant-baseline='middle' text-anchor='middle' font-size='20' fill='white' font-weight='600'%3EST%3C/text%3E%3C/svg%3E"
                                class="customer-avatar"
                                alt="Shamus Tuttle"
                        />
                        <div>
                            <div class="customer-name">Nguyễn Anh Tùng</div>
                            <div class="customer-id">Mã khách hàng: #58909</div>
                        </div>
                    </div>

                    <div class="orders-count">
                        <i class="bi bi-cart4"></i>
                        <div class="orders-text">1 đơn hàng</div>
                    </div>

                    <div class="contact-info">
                        <div class="contact-title">Thông tin liên hệ</div>
                        <div class="contact-item">
                            Email: nguyenanhtung@gmail.com
                        </div>
                        <div class="contact-item">Số điện thoại: 0798222222</div>
                    </div>
                </div>

                <!-- Shipping Address -->
                <div class="card-section">
                    <div class="section-title">
                        <span>Địa chỉ giao hàng</span>
                        <a href="#" class="edit-link">Chỉnh sửa</a>
                    </div>

                    <p class="address-text">
                        1 Lê Duẩn<br/>
                        Tp. Ho Chi Minh<br/>
                        Viet Nam
                    </p>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
