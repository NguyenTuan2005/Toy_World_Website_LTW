<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Người Dùng</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>

    <style>
        .main-content {
            background: #f8f9fa;
            min-height: 100vh;
        }

        .header-section {
            background: white;
            padding: 2rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
        }

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

        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .btn-add-user {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.625rem 1.5rem;
            border-radius: 8px;
            color: white;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-add-user:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .table-container {
            padding: 1.5rem;
            overflow-x: auto;
        }

        .table-custom {
            margin: 0;
        }

        .table-custom thead {
            background: #f8f9fa;
        }

        .table-custom thead th {
            border: none;
            color: #6c757d;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1rem;
        }

        .table-custom tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f0f0f0;
        }

        .table-custom tbody tr:hover {
            background: #f8f9fa;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-right: 0.75rem;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-name {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.25rem;
        }

        .user-email {
            font-size: 0.875rem;
            color: #6c757d;
            margin: 0;
        }

        .badge-role {
            padding: 0.375rem 0.75rem;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 500;
            display: inline-block;
            margin-right: 0.25rem;
        }

        .badge-admin {
            background: #fef3e8;
            color: #f59e0b;
        }

        .badge-user {
            background: #e8f4fd;
            color: #3b82f6;
        }

        .badge-moderator {
            background: #f0e7fe;
            color: #8b5cf6;
        }

        .badge-status {
            padding: 0.375rem 0.875rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .badge-active {
            background: #d1fae5;
            color: #059669;
        }

        .badge-inactive {
            background: #fee2e2;
            color: #dc2626;
        }

        .action-buttons .btn {
            width: 32px;
            height: 32px;
            padding: 0;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 0.25rem;
            border: none;
            transition: all 0.2s;
        }

        .btn-edit {
            background: #e0f2fe;
            color: #0284c7;
        }

        .btn-edit:hover {
            background: #0284c7;
            color: white;
        }

        .btn-delete {
            background: #fee2e2;
            color: #dc2626;
        }

        .btn-delete:hover {
            background: #dc2626;
            color: white;
        }

        .pagination-container {
            padding: 1.5rem;
            border-top: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .user-detail-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .user-detail-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 2rem;
            color: white;
            text-align: center;
        }

        .user-detail-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: white;
            color: #667eea;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .user-detail-name {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .user-detail-email {
            font-size: 1rem;
            opacity: 0.9;
        }

        .user-detail-body {
            padding: 2rem;
        }

        .info-section {
            margin-bottom: 2rem;
        }

        .info-section:last-child {
            margin-bottom: 0;
        }

        .section-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 1.25rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid #e9ecef;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 0.5rem;
            color: #667eea;
        }

        .info-row {
            display: flex;
            padding: 0.875rem 0;
            border-bottom: 1px solid #f8f9fa;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #6c757d;
            min-width: 150px;
            flex-shrink: 0;
        }

        .info-value {
            color: #2c3e50;
            flex: 1;
            word-break: break-word;
        }

        .info-value.empty {
            color: #adb5bd;
            font-style: italic;
        }

        .gender-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.375rem 0.875rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .gender-male {
            background: #dbeafe;
            color: #1e40af;
        }

        .gender-female {
            background: #fce7f3;
            color: #be185d;
        }

        .gender-other {
            background: #f3e8ff;
            color: #7c3aed;
        }

        .location-info {
            display: flex;
            align-items: start;
            gap: 0.5rem;
        }

        .location-info i {
            color: #667eea;
            margin-top: 0.25rem;
        }

        .user-actions {
            padding: 1.5rem 2rem;
            background: #f8f9fa;
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }

        .btn-action {
            padding: 0.625rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
        }

        .btn-primary-action {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary-action {
            background: white;
            color: #6c757d;
            border: 1px solid #dee2e6;
        }

        .btn-secondary-action:hover {
            background: #f8f9fa;
            border-color: #adb5bd;
        }

        .btn-danger-action {
            background: #fee2e2;
            color: #dc2626;
        }

        .btn-danger-action:hover {
            background: #dc2626;
            color: white;
        }

        .modal-content {
            border: none;
            border-radius: 12px;
        }

        .modal-header {
            border-bottom: 1px solid #e9ecef;
            padding: 1.5rem;
        }

        .modal-title {
            font-weight: 600;
            color: #2c3e50;
        }

        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #dee2e6;
            padding: 0.625rem 0.875rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
        }
    </style>
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <!-- Header Section -->
    <div class="header-section">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">
                        <i class="fas fa-users me-2"></i>
                        Quản lý người dùng
                    </h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <!-- User Detail Container Example -->
        <div class="row mb-4">
            <div class="col-lg-8 mx-auto">
                <div class="user-detail-container">
                    <!-- Header với Avatar -->
                    <div class="user-detail-header">
                        <div class="user-detail-avatar">NVA</div>
                        <h2 class="user-detail-name">${user.firstName}</h2>
                        <p class="user-detail-email">
                            <i class="fas fa-envelope me-2"></i>
                            ${user.email}
                        </p>
                    </div>

                    <!-- Body với thông tin chi tiết -->
                    <div class="user-detail-body">
                        <!-- Thông tin cá nhân -->
                        <div class="info-section">
                            <h3 class="section-title">
                                <i class="fas fa-user"></i>
                                Thông tin cá nhân
                            </h3>
                            <div class="info-row">
                                <span class="info-label">Họ:</span>
                                <span class="info-value">${user.firstName}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Tên:</span>
                                <span class="info-value">${user.lastName}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Giới tính:</span>
                                <span class="info-value">
                                    <span class="gender-badge gender-male">
                                        <i class="fas fa-mars me-1"></i>
                                        ${user.gender}
                                    </span>
                                </span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Số điện thoại:</span>
                                <span class="info-value">
                                    <i class="fas fa-phone me-2"></i>
                                    ${user.phone}
                                </span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Vai trò</span>
                                <span class="gender-badge gender-male">
                                     <i class="fas fa-user-circle me-2"></i>
                                    ${role}
                                </span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Trạng thái</span>
                                <span class="gender-badge gender-male">
                                    <c:choose>
                                        <c:when test="${user.active}">
                                            Hoạt động
                                        </c:when>
                                        <c:otherwise>
                                            Khóa
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>

                        <!-- Thông tin liên hệ -->
                        <div class="info-section">
                            <h3 class="section-title">
                                <i class="fas fa-address-card"></i>
                                Thông tin liên hệ
                            </h3>
                            <div class="info-row">
                                <span class="info-label">Email:</span>
                                <span class="info-value">${user.email}</span>
                            </div>
                            <c:if test="${not empty location}">
                                <div class="info-row">
                                    <span class="info-label">Tỉnh/Thành phố:</span>
                                    <span class="info-value">${location.province}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Địa chỉ:</span>
                                    <span class="info-value">
                                        <div class="location-info">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span>${location.address}</span>
                                        </div>
                                    </span>
                                </div>
                            </c:if>
                        </div>

                        <!-- Thông tin bảo mật -->
                        <div class="info-section">
                            <h3 class="section-title">
                                <i class="fas fa-shield-alt"></i>
                                Thông tin bảo mật
                            </h3>
                            <div class="info-row">
                                <span class="info-label">Mật khẩu:</span>
                                <span class="info-value">
                                    <i class="fas fa-lock me-2"></i>
                                    ••••••••
                                    <button class="btn btn-sm btn-link text-primary p-0 ms-2">
                                        <i class="fas fa-key"></i> Đổi mật khẩu
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Footer với các nút action -->
                    <div class="user-actions">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary-action">
                            <i class="fas fa-arrow-left me-2"></i>
                            Quay lại
                        </a>
                        <form method="post" action="/childrentoyweb_war/admin/hidden-users">
                            <input type="hidden" name="userId" value="${user.id}">
                            <input type="hidden" name="active" value="${user.active}">
                            <button type="submit" class="btn btn-danger-action">
                                <i class="fas fa-trash me-2"></i>
                                Xóa
                            </button>
                        </form>


                        <button class="btn btn-primary-action" data-bs-toggle="modal" data-bs-target="#userModal">
                            <i class="fas fa-edit me-2"></i>
                            Chỉnh sửa
                        </button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Modal thêm/sửa người dùng -->
    <div class="modal fade" id="userModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="userModalLabel">Thêm người dùng mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="userForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="firstName" class="form-label">Họ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="firstName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="lastName" class="form-label">Tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="lastName" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="gender" class="form-label">Giới tính</label>
                                <select class="form-select" id="gender">
                                    <option value="">Chọn giới tính</option>
                                    <option value="male">Nam</option>
                                    <option value="female">Nữ</option>
                                    <option value="other">Khác</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label">Điện thoại</label>
                                <input type="tel" class="form-control" id="phone">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" required>
                        </div>

                        <div id="userModalPassword" class="mb-3">
                            <label for="password" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="password" required>
                        </div>

                        <div class="mb-3">
                            <label for="province" class="form-label">Tỉnh/TP</label>
                            <select class="form-select" id="province">
                                <option value="">Chọn địa điểm</option>
                                <option value="hanoi">Hà Nội</option>
                                <option value="hcm">TP. Hồ Chí Minh</option>
                                <option value="danang">Đà Nẵng</option>
                                <option value="haiphong">Hải Phòng</option>
                                <option value="cantho">Cần Thơ</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ</label>
                            <textarea class="form-control" id="address" rows="3"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="roles" class="form-label">Vai trò</label>
                            <select class="form-select" id="roles" multiple>
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                                <option value="moderator">Moderator</option>
                                <option value="editor">Editor</option>
                            </select>
                            <small class="form-text text-muted">Giữ Ctrl (hoặc Cmd) để chọn nhiều vai trò</small>
                        </div>

                        <div class="mb-3 form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="status" checked>
                            <label class="form-check-label" for="status">Trạng thái hoạt động</label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Hủy
                    </button>
                    <button type="button" class="btn btn-primary" id="btnSaveUser">
                        <i class="fas fa-check me-2"></i>Lưu
                    </button>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // JavaScript cho chức năng tìm kiếm và xử lý form có thể thêm ở đây
    document.addEventListener('DOMContentLoaded', function() {
        // Xử lý tìm kiếm
        const searchInput = document.querySelector('.search-box input');
        searchInput.addEventListener('input', function(e) {
            // Thêm logic tìm kiếm ở đây
            console.log('Searching for:', e.target.value);
        });

        // Xử lý nút lưu người dùng
        const btnSaveUser = document.getElementById('btnSaveUser');
        btnSaveUser.addEventListener('click', function() {
            // Thêm logic lưu người dùng ở đây
            console.log('Saving user...');
        });
    });
</script>
</body>
</html>