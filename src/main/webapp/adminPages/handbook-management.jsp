
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN" />
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Bài Viết</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
</head>
<style>
    .stats-card {
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        transition: transform 0.2s;
    }

    .stats-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.12);
    }

    .stats-icon {
        width: 48px;
        height: 48px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        margin-bottom: 1rem;
    }

    .stats-card.primary .stats-icon {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }

    .stats-card.success .stats-icon {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
    }

    .stats-card.warning .stats-icon {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
    }

    .stats-card.info .stats-icon {
        background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        color: white;
    }

    .stats-value {
        font-size: 2rem;
        font-weight: 700;
        color: #2c3e50;
        margin: 0;
    }

    .stats-label {
        color: #6c757d;
        font-size: 0.875rem;
        margin: 0;
    }

    .content-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        margin-bottom: 2rem;
    }

    .card-header-custom {
        padding: 1.5rem;
        border-bottom: 1px solid #e9ecef;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .card-title {
        font-size: 1.25rem;
        font-weight: 600;
        color: #2c3e50;
        margin: 0;
    }

    .search-box {
        position: relative;
        width: 300px;
    }

    .search-box input {
        padding-left: 2.5rem;
        border-radius: 8px;
        border: 1px solid #dee2e6;
    }
</style>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>



<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý người dùng</h1>
                </div>
            </div>
        </div>
    </div>
    <hr>

    <div class="container mb-3">


        <div class="container-fluid">
            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card primary">
                        <div class="stats-icon">
                            <i class="bi bi-file-earmark-text"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_handbooks}" type="number" /></h3>
                        <p class="stats-label">Tổng bài viết</p>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card info">
                        <div class="stats-icon">
                            <i class="bi bi-lock-fill"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_hidden_handbooks}" type="number" /></h3>
                        <p class="stats-label">Tổng bài viết đã ẩn </p>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card warning">
                        <div class="stats-icon">
                            <i class="bi bi-journal-text"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_new_handbooks_on_month}" type="number" /></h3>
                        <p class="stats-label">Mới tháng này</p>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card info">
                        <div class="stats-icon">
                            <i class="bi bi-check-circle-fill text-success"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_posted_on_month}" type="number" /></h3>
                        <p class="stats-label">Đã đăng trong tháng</p>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card info">
                        <div class="stats-icon">
                            <i class="bi bi-eye-slash-fill text-secondary"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_hidden_on_month}" type="number" /></h3>
                        <p class="stats-label">Đã ẩn trong tháng</p>
                    </div>
                </div>
            </div>
        </div>



        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6 hstack align-items-center">
                    <div class="search-wrapper flex-grow-1">
                        <i class="fas fa-search search-icon"></i>
                        <form class="mb-0" id="searchForm"  action="${pageContext.request.contextPath}/admin/users" method="post">
                            <input
                                    type="text"
                                    id="searchInput"
                                    name="keyword"
                                    class="search-input"
                                    placeholder="Nhập ID / Email / Phone / Tên"
                            >
                        </form>

                    </div>
                    <script>
                        document.getElementById("searchInput")
                            .addEventListener("keydown", function (e) {
                                if (e.key === "Enter") {
                                    e.preventDefault(); // tránh reload không mong muốn
                                    document.getElementById("searchForm").submit();
                                }
                            });
                    </script>

                </div>
                <div class="col-md-6 d-flex align-items-center justify-content-end">
                    <c:if test="${find_user != null || manage_user == null}">
                        <nav>
                            <ul class="pagination mb-0 me-2">
                                <li class="page-item"><a  class="page-link" href="${pageContext.request.contextPath}/admin/users?page=1">Load lại bảng</a></li>
                            </ul>
                        </nav>
                    </c:if>
                    <div class="text-end mt-md-0">
                        <button class="btn-add fw-medium px-4 py-2 text-decoration-none" data-bs-toggle="modal" data-bs-target="#userModal">
                            <i class="fas fa-plus"></i> Thêm người dùng
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-container">
            <h1>James update</h1>
        </div>
    </div>

    <!-- Modal thêm/sửa người dùng -->
    <div class="modal fade" id="userModal" tabindex="-1" aria-labelledby="userModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form method="post" action="${pageContext.request.contextPath}/admin/new-users">
                    <div class="modal-header">
                        <h5 class="modal-title" id="userModalLabel">Thêm người dùng mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                    ${error}
                            </div>
                        </c:if>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="firstName" class="form-label">Họ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="firstName" name="firstName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="lastName" class="form-label">Tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="lastName" name="lastName" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="gender" class="form-label">Giới tính</label>
                                <select class="form-select" id="gender" name="gender">
                                    <option value="">Chọn giới tính</option>
                                    <option value="Male">Nam</option>
                                    <option value="Female">Nữ</option>
                                    <option value="Other">Khác</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label">Điện thoại</label>
                                <input type="tel" class="form-control" id="phone" name="phone">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>

                        <div id="userModalPassword" class="mb-3">
                            <label for="password" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <div class="mb-3">
                            <label for="province" class="form-label">Tỉnh/TP</label>
                            <select class="form-select" id="province" name="province">
                                <option value="">Chọn địa điểm</option>

                                <!-- Thành phố trực thuộc TW -->
                                <option value="Hà Nội">Hà Nội</option>
                                <option value="TP. Hồ Chí Minh">TP. Hồ Chí Minh</option>
                                <option value="Đà Nẵng">Đà Nẵng</option>
                                <option value="Hải Phòng">Hải Phòng</option>
                                <option value="Cần Thơ">Cần Thơ</option>

                                <!-- Các tỉnh -->
                                <option value="An Giang">An Giang</option>
                                <option value="Bà Rịa - Vũng Tàu">Bà Rịa - Vũng Tàu</option>
                                <option value="Bắc Giang">Bắc Giang</option>
                                <option value="Bắc Kạn">Bắc Kạn</option>
                                <option value="Bạc Liêu">Bạc Liêu</option>
                                <option value="Bắc Ninh">Bắc Ninh</option>
                                <option value="Bến Tre">Bến Tre</option>
                                <option value="Bình Dương">Bình Dương</option>
                                <option value="Bình Định">Bình Định</option>
                                <option value="Bình Phước">Bình Phước</option>
                                <option value="Bình Thuận">Bình Thuận</option>
                                <option value="Cà Mau">Cà Mau</option>
                                <option value="Cao Bằng">Cao Bằng</option>
                                <option value="Đắk Lắk">Đắk Lắk</option>
                                <option value="Đắk Nông">Đắk Nông</option>
                                <option value="Điện Biên">Điện Biên</option>
                                <option value="Gia Lai">Gia Lai</option>
                                <option value="Hà Giang">Hà Giang</option>
                                <option value="Hà Nam">Hà Nam</option>
                                <option value="Hà Tĩnh">Hà Tĩnh</option>
                                <option value="Hải Dương">Hải Dương</option>
                                <option value="Hậu Giang">Hậu Giang</option>
                                <option value="Hòa Bình">Hòa Bình</option>
                                <option value="Hưng Yên">Hưng Yên</option>
                                <option value="Khánh Hòa">Khánh Hòa</option>
                                <option value="Kiên Giang">Kiên Giang</option>
                                <option value="Kon Tum">Kon Tum</option>
                                <option value="Lai Châu">Lai Châu</option>
                                <option value="Lâm Đồng">Lâm Đồng</option>
                                <option value="Lạng Sơn">Lạng Sơn</option>
                                <option value="Lào Cai">Lào Cai</option>
                                <option value="Long An">Long An</option>
                                <option value="Nam Định">Nam Định</option>
                                <option value="Nghệ An">Nghệ An</option>
                                <option value="Ninh Bình">Ninh Bình</option>
                                <option value="Ninh Thuận">Ninh Thuận</option>
                                <option value="Phú Thọ">Phú Thọ</option>
                                <option value="Phú Yên">Phú Yên</option>
                                <option value="Quảng Bình">Quảng Bình</option>
                                <option value="Quảng Nam">Quảng Nam</option>
                                <option value="Quảng Ngãi">Quảng Ngãi</option>
                                <option value="Quảng Ninh">Quảng Ninh</option>
                                <option value="Quảng Trị">Quảng Trị</option>
                                <option value="Sóc Trăng">Sóc Trăng</option>
                                <option value="Sơn La">Sơn La</option>
                                <option value="Tây Ninh">Tây Ninh</option>
                                <option value="Thái Bình">Thái Bình</option>
                                <option value="Thái Nguyên">Thái Nguyên</option>
                                <option value="Thanh Hóa">Thanh Hóa</option>
                                <option value="Thừa Thiên Huế">Thừa Thiên Huế</option>
                                <option value="Tiền Giang">Tiền Giang</option>
                                <option value="Trà Vinh">Trà Vinh</option>
                                <option value="Tuyên Quang">Tuyên Quang</option>
                                <option value="Vĩnh Long">Vĩnh Long</option>
                                <option value="Vĩnh Phúc">Vĩnh Phúc</option>
                                <option value="Yên Bái">Yên Bái</option>
                            </select>

                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ</label>
                            <textarea class="form-control" id="address" name="address"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="roles" class="form-label">Vai trò</label>
                            <select class="form-select" id="roles" name="roles" multiple>
                                <option value="ROLE_USER">Người dùng</option>
                                <option value="ROLE_ADMIN">Admin</option>
                            </select>
                            <small class="form-text text-muted">Giữ Ctrl (hoặc Cmd) để chọn nhiều vai trò</small>
                        </div>

                        <div class="mb-3 form-check form-switch">
                            <input type="hidden" name="status" value="inactive">
                            <input class="form-check-input" type="checkbox" id="status" name="status" value="active" checked>
                            <label class="form-check-label" for="status">Trạng thái hoạt động</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times"></i> Hủy
                        </button>
                        <button type="submit" class="btn btn-primary"   onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật không?');">
                            <i class="fas fa-check"></i> Lưu
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>



<script src="js/index.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
