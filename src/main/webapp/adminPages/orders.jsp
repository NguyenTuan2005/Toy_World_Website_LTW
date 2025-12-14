<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Đơn Hàng</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý đơn hàng</h1>
                </div>

            </div>
        </div>
    </div>

    <div class="container mb-3">
        <%--     statistic   --%>
        <div class="row g-3 my-2">
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <div class="stats-number fs-2 fw-bold text-dark">56</div>
                            <div class="stats-label text-warning bold-title">
                                Đang giao
                            </div>
                        </div>
                        <i class="bi bi-calendar-check text-muted fs-3"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <div class="stats-number fs-2 fw-bold text-dark">
                                1,248
                            </div>
                            <div class="stats-label text-success bold-title">
                                Đã giao
                            </div>
                        </div>
                        <i class="bi bi-check-circle text-muted fs-3"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <div class="stats-number fs-2 fw-bold text-dark">124</div>
                            <div class="stats-label text-danger bold-title">
                                Hoàn trả
                            </div>
                        </div>
                        <i class="bi bi-arrow-counterclockwise text-muted fs-3"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <div class="stats-number fs-2 fw-bold text-dark">32</div>
                            <div class="stats-label text-danger bold-title">
                                Thất bại
                            </div>
                        </div>
                        <i class="bi bi-exclamation-circle text-muted fs-3"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="search-wrapper">
                        <i class="fas fa-search search-icon"></i>
                        <input
                                type="text"
                                class="search-input"
                                placeholder="Tìm theo mã đơn hàng..."
                        />
                    </div>
                </div>
                <div class="col-md-6 text-end mt-3 mt-md-0">
                    <i
                            class="fas fa-filter filter-icon"
                            style="color: #cf102d"
                    ></i>
                    <select class="status-select">
                        <option>Tất cả trạng thái</option>
                        <option>Đang Xử Lý</option>
                        <option>Đang Giao</option>
                        <option>Đã Giao</option>
                        <option>Đã Hủy</option>
                        <option>Đã Thanh Toán</option>
                        <option>Chưa Thanh Toán</option>
                    </select>
                </div>
            </div>
        </div>
        <%--        data table--%>
        <div class="table-container">
            <table class="table">
                <thead>
                <tr>
                    <th style="width: 40px">
                        <input
                                class="form-check-input"
                                type="checkbox"
                                id="selectAll"
                        />
                    </th>
                    <th>Mã Đơn</th>
                    <th>Ngày Đặt</th>
                    <th>Tên Khách Hàng</th>
                    <th>Số điện thoại</th>
                    <th>Email</th>
                    <th>Thanh Toán</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td style="width: 40px">
                        <input
                                class="form-check-input"
                                type="checkbox"
                                id="selectAll"
                        />
                    </td>

                    <td class="bold-title">#32543</td>
                    <td>23/9/2025</td>
                    <td class="author-name bold-title">Nguyễn Yến</td>
                    <td>0798222222</td>
                    <td>nguyenyen@gmail.com</td>
                    <td class="text-nowrap">
                        <span class="badge bg-success">Đã Thanh Toán</span>
                    </td>
                    <td class="text-nowrap">
                        <span class="badge bg-success">Đã Nhận</span>
                    </td>

                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none"
                                    onclick="location.href='${pageContext.request.contextPath}/admin/order/order-details'">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none"
                                    onclick="location.href='${pageContext.request.contextPath}/admin/order/order-details'">
                                <i class="fas fa-edit"></i>
                            </button>

                            <button class="btn btn-link text-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td style="width: 40px">
                        <input
                                class="form-check-input"
                                type="checkbox"
                                id="selectAll"
                        />
                    </td>

                    <td class="bold-title">#32543</td>
                    <td>23/9/2025</td>
                    <td class="author-name bold-title">Nguyễn Yến</td>
                    <td>0798222222</td>
                    <td>nguyenyen@gmail.com</td>
                    <td class="text-nowrap">
                        <span class="badge bg-success">Đã Thanh Toán</span>
                    </td>
                    <td class="text-nowrap">
                        <span class="badge bg-danger">Đã Hủy</span>
                    </td>

                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none"
                                    onclick="location.href='${pageContext.request.contextPath}/admin/order/order-details'">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none"
                                    onclick="location.href='${pageContext.request.contextPath}/admin/order/order-details'">
                                <i class="fas fa-edit"></i>
                            </button>

                            <button class="btn btn-link text-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>

            <hr class="mx-5"/>
            <div class="d-flex justify-content-between align-items-center m-3">
                <p class="mb-0">Hiển thị 4 trong 100 đơn hàng</p>
                <nav>
                    <ul class="pagination mb-0">
                        <li class="page-item disabled">
                            <a class="page-link">|&lt;</a>
                        </li>
                        <li class="page-item disabled">
                            <a class="page-link">&lt;</a>
                        </li>

                        <li class="page-item active">
                            <a class="page-link">1</a>
                        </li>
                        <li class="page-item"><a class="page-link">2</a></li>
                        <li class="page-item"><a class="page-link">3</a></li>
                        <li class="page-item"><a class="page-link">4</a></li>
                        <li class="page-item"><a class="page-link">5</a></li>
                        <li class="page-item"><a class="page-link">…</a></li>
                        <li class="page-item"><a class="page-link">10</a></li>

                        <li class="page-item">
                            <a class="page-link">&gt;</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link">&gt;|</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
