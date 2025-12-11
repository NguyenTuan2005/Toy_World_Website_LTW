<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Sự Kiện</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <link rel="stylesheet" href="css/event.css"/>
    <link rel="stylesheet" href="../css/root.css"/>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">

    <div class=" main-container">

        <ul class="nav nav-tabs mb-4" id="mainTabs" role="tablist" style="background: rgb(213, 27, 27);">
            <li class="nav-item ms-3" role="presentation">
                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#events" type="button">
                    <i class="fas fa-calendar-check me-2"></i>Events
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#promotions" type="button">
                    <i class="fas fa-percentage me-2"></i>Promotions
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#vouchers" type="button">
                    <i class="fas fa-ticket-alt me-2"></i>Vouchers
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#banners" type="button">
                    <i class="fas fa-image me-2"></i>Banners
                </button>
            </li>
        </ul>

        <div class="tab-content" id="mainTabContent">
            <!-- Events Tab -->
            <div class="tab-pane fade show active" id="events" role="tabpanel">
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="stats-card">
                            <h3>12</h3>
                            <p>Tổng Events</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <h3>8</h3>
                            <p>Đang Hoạt Động</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <h3>3</h3>
                            <p>Sắp Diễn Ra</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <h3>1</h3>
                            <p>Đã Kết Thúc</p>
                        </div>
                    </div>
                </div>

                <div class="action-bar">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" class="form-control" placeholder="Tìm kiếm sự kiện...">
                    </div>
                    <button class="btn btn-add" onclick="showModal('eventModal')">
                        <i class="fas fa-plus me-2"></i>Thêm Event Mới
                    </button>
                </div>

                <div class="table-container">
                    <table class="table data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên Sự Kiện</th>
                            <th>Loại</th>
                            <th>Thời Gian Bắt Đầu</th>
                            <th>Thời Gian Kết Thúc</th>
                            <th>Trạng Thái</th>
                            <th>Thao Tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><strong>#EV001</strong></td>
                            <td>Black Friday 2024</td>
                            <td><span class="badge bg-primary">Sale Event</span></td>
                            <td>20/11/2024</td>
                            <td>30/11/2024</td>
                            <td><span class="badge badge-active">Đang hoạt động</span></td>
                            <td>
                                <button class="btn btn-action btn-view"><i class="fas fa-eye"></i></button>
                                <button class="btn btn-action btn-edit" onclick="showModal('eventModal')"><i
                                        class="fas fa-edit"></i></button>
                                <button class="btn btn-action btn-delete"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>#EV002</strong></td>
                            <td>Tết Sale 2025</td>
                            <td><span class="badge bg-success">Festival</span></td>
                            <td>15/01/2025</td>
                            <td>25/01/2025</td>
                            <td><span class="badge badge-scheduled">Sắp diễn ra</span></td>
                            <td>
                                <button class="btn btn-action btn-view"><i class="fas fa-eye"></i></button>
                                <button class="btn btn-action btn-edit" onclick="showModal('eventModal')"><i
                                        class="fas fa-edit"></i></button>
                                <button class="btn btn-action btn-delete"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                    <!-- Basic Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination  justify-content-center">
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>

            <script>
                function showModal(modalId) {
                    const modalElement = document.getElementById(modalId);
                    if (!modalElement) {
                        console.warn(`Không tìm thấy modal với id: ${modalId}`);
                        return;
                    }

                    // Tạo đối tượng modal Bootstrap và hiển thị
                    const modal = new bootstrap.Modal(modalElement);
                    modal.show();
                }

            </script>

            <!-- Promotions Tab -->
            <div class="tab-pane fade" id="promotions" role="tabpanel">
                <div class="action-bar">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" class="form-control" placeholder="Tìm kiếm promotion...">
                    </div>
                    <button class="btn btn-add" onclick="showModal('promotionModal')">
                        <i class="fas fa-plus me-2"></i>Thêm Promotion
                    </button>
                </div>

                <div class="table-container">
                    <table class="table data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên Promotion</th>
                            <th>Phẩn Trăm Giảm</th>
                            <th>Thời Hạn</th>
                            <th>Trạng Thái</th>
                            <th>Thao Tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><strong>#PM001</strong></td>
                            <td>Giảm 50% Điện Thoại</td>
                            <td><span class="discount-tag">50%</span></td>
                            <td>30/11/2024</td>
                            <td><span class="badge badge-active">Đang hoạt động</span></td>
                            <td>
                                <button class="btn btn-action btn-view"><i class="fas fa-eye"></i></button>
                                <button class="btn btn-action btn-edit"><i class="fas fa-edit"></i></button>
                                <button class="btn btn-action btn-delete"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>#PM003</strong></td>
                            <td>Giảm 30% Laptop</td>
                            <td><span class="discount-tag">30%</span></td>
                            <td>30/11/2024</td>
                            <td><span class="badge badge-inactive">Đã hết hạn</span></td>
                            <td>
                                <button class="btn btn-action btn-view"><i class="fas fa-eye"></i></button>
                                <button class="btn btn-action btn-edit" onclick="showModal('promotionModal')"><i
                                        class="fas fa-edit"></i></button>
                                <button class="btn btn-action btn-delete"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <!-- Basic Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination  justify-content-center">
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>

            <!-- Vouchers Tab -->
            <div class="tab-pane fade" id="vouchers" role="tabpanel">
                <div class="action-bar">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" class="form-control" placeholder="Tìm kiếm voucher...">
                    </div>
                    <button class="btn btn-add" onclick="showModal('voucherModal')">
                        <i class="fas fa-plus me-2"></i>Thêm Voucher
                    </button>
                </div>

                <div class="table-container">
                    <table class="table data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên Voucher</th>
                            <th>Mã Voucher</th>
                            <th>Phẩn Trăm</th>
                            <th>Số Lượt</th>
                            <th>Đã Dùng</th>
                            <th>Hết Hạn</th>
                            <th>Trạng Thái</th>
                            <th>Thao Tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><strong>#VC001</strong></td>
                            <td>Chủ Nhật Vui Vẻ</td>
                            <td><code>SAVE100K</code></td>
                            <td>5%</td>
                            <td>10</td>
                            <td>2</td>
                            <td>31/12/2024</td>
                            <td><span class="badge badge-active">Còn hạn</span></td>
                            <td>
                                <button class="btn btn-action btn-view"><i class="fas fa-eye"></i></button>
                                <button class="btn btn-action btn-edit" onclick="showModal('voucherModal')"><i
                                        class="fas fa-edit"></i></button>
                                <button class="btn btn-action btn-delete"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>#VC001</strong></td>
                            <td>Miễn Phí Ship</td>
                            <td><code>FREESHIP</code></td>
                            <td>5%</td>
                            <td>10</td>
                            <td>2</td>
                            <td>31/12/2024</td>
                            <td><span class="badge badge-active">Còn hạn</span></td>
                            <td>
                                <button class="btn btn-action btn-view"><i class="fas fa-eye"></i></button>
                                <button class="btn btn-action btn-edit" onclick="showModal('voucherModal')"><i
                                        class="fas fa-edit"></i></button>
                                <button class="btn btn-action btn-delete"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <!-- Basic Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination  justify-content-center">
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>

                </div>
            </div>

            <!-- Banners Tab -->
            <div class="tab-pane fade" id="banners" role="tabpanel">
                <div class="action-bar">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" class="form-control" placeholder="Tìm kiếm banner...">
                    </div>
                    <button class="btn btn-add" onclick="showModal('bannerModal')">
                        <i class="fas fa-plus me-2"></i>Thêm Banner
                    </button>
                </div>

                <div class="table-container">
                    <table class="table data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên Banner</th>
                            <th>Ảnh</th>
                            <th>Sự kiện</th>
                            <th>Trạng Thái</th>
                            <th>Thao Tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><strong>#BN001</strong></td>
                            <td>Black Friday Hero Banner</td>
                            <td><img src="" alt=""></td>

                            <td>/events/black-friday</td>

                            <td><span class="badge badge-active">Hiển thị</span></td>
                            <td>
                                <button class="btn btn-action btn-view"><i class="fas fa-eye"></i></button>
                                <button class="btn btn-action btn-edit" onclick="showModal('bannerModal')"><i
                                        class="fas fa-edit"></i></button>
                                <button class="btn btn-action btn-delete"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>#BN001</strong></td>
                            <td>Black Friday Banner</td>
                            <td><img src="" alt=""></td>

                            <td>/events/black-friday</td>

                            <td><span class="badge badge-active">Hiển thị</span></td>
                            <td>
                                <button class="btn btn-action btn-view"><i class="fas fa-eye"></i></button>
                                <button class="btn btn-action btn-edit" onclick="showModal('bannerModal')"><i
                                        class="fas fa-edit"></i></button>
                                <button class="btn btn-action btn-delete"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>#BN001</strong></td>
                            <td>Black Friday Hero Banner</td>
                            <td><img src="" alt=""></td>

                            <td>/events/black-friday</td>

                            <td><span class="badge badge-active">Hiển thị</span></td>
                            <td>
                                <button class="btn btn-action btn-view"><i class="fas fa-eye"></i></button>
                                <button class="btn btn-action btn-edit" onclick="showModal('bannerModal')"><i
                                        class="fas fa-edit"></i></button>
                                <button class="btn btn-action btn-delete"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <!-- Basic Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination  justify-content-center">
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal Thêm/Sửa Event -->
    <div class="modal fade" id="eventModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-calendar-plus me-2"></i><span id="eventModalTitle">Thêm Event Mới</span>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="eventForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên Sự Kiện *</label>
                                <input type="text" class="form-control" name="eventName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Loại Sự Kiện *</label>
                                <select class="form-select" name="eventType" required>
                                    <option value="">Chọn loại</option>
                                    <option value="Sale Event">Sale Event</option>
                                    <option value="Festival">Festival</option>
                                    <option value="Flash Sale">Flash Sale</option>
                                    <option value="Special Event">Special Event</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ngày Bắt Đầu *</label>
                                <input type="date" class="form-control" name="startDate" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ngày Kết Thúc *</label>
                                <input type="date" class="form-control" name="endDate" required>
                            </div>
                            <div class="col-12 mb-3">
                                <label class="form-label">Mô Tả</label>
                                <textarea class="form-control" name="description" rows="3"></textarea>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Trạng Thái *</label>
                                <select class="form-select" name="status" required>
                                    <option value="active">Đang hoạt động</option>
                                    <option value="scheduled">Sắp diễn ra</option>
                                    <option value="inactive">Đã kết thúc</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary">Lưu</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thêm/Sửa Promotion -->
    <div class="modal fade" id="promotionModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-percentage me-2"></i><span id="promotionModalTitle">Thêm Promotion Mới</span>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="promotionForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên Promotion *</label>
                                <input type="text" class="form-control" name="promotionName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Phần Trăm Giảm</label>
                                <input type="text" class="form-control" name="discountValue" required
                                       placeholder="VD: 70%">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Hết Hạn *</label>
                                <input type="date" class="form-control" name="expiryDate" required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Trạng Thái *</label>
                                <select class="form-select" name="status" required>
                                    <option value="active">Đang hoạt động</option>
                                    <option value="inactive">Ngưng hoạt động</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" onclick="savePromotion()">Lưu</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thêm/Sửa Voucher -->
    <div class="modal fade" id="voucherModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-ticket-alt me-2"></i><span id="voucherModalTitle">Thêm Voucher Mới</span>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="voucherForm">
                        <div class="row">

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên Voucher * </label>
                                <input type="text" class="form-control" name="voucherCode" required
                                       placeholder="VD: 11 tháng 11 siêu sale" style="text-transform: uppercase;">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Mã Voucher *</label>
                                <input type="text" class="form-control" name="voucherCode" required
                                       placeholder="VD: SAVE100K" style="text-transform: uppercase;">
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Phẩn Trăm Giảm Giá</label>
                                <input type="text" class="form-control" name="voucherValue" required
                                       placeholder="VD: 50%">
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số Lượt Sử Dụng *</label>
                                <input type="text" class="form-control" name="usageLimit" required
                                       placeholder="VD: 1000 hoặc Unlimited">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ngày Hết Hạn *</label>
                                <input type="date" class="form-control" name="expiryDate" required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Trạng Thái *</label>
                                <select class="form-select" name="status" required>
                                    <option value="active">Còn hạn</option>
                                    <option value="inactive">Hết hạn</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" onclick="saveVoucher()">Lưu</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thêm/Sửa Banner -->
    <div class="modal fade" id="bannerModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-image me-2"></i><span
                            id="bannerModalTitle">Thêm Banner Mới</span></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="bannerForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên Banner *</label>
                                <input type="text" class="form-control" name="bannerName" required>
                            </div>


                            <!-- <div class="col-md-6 mb-3">
                                <label class="form-label">Link Đích *</label>
                                <input type="text" class="form-control" name="link" required placeholder="/events/black-friday">
                            </div> -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Chọn Sự Kiện</label>
                                <select class="form-select" name="event" required>
                                    <option value="active">Chủ Nhật Vui</option>
                                    <option value="inactive">11 Tháng 11</option>
                                </select>
                            </div>
                            <div class="col-12 mb-3">
                                <label class="form-label">Upload Hình Ảnh *</label>
                                <input type="file" class="form-control" name="bannerImage" accept="image/*">
                                <small class="text-muted">Định dạng: JPG, PNG, GIF. Kích thước tối đa: 5MB</small>
                            </div>


                            <div class="col-md-6 mb-3">
                                <label class="form-label">Trạng Thái *</label>
                                <select class="form-select" name="status" required>
                                    <option value="active">Hiển thị</option>
                                    <option value="inactive">Ẩn</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" onclick="saveBanner()">Lưu</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>


</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

