<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Bài Viết</title>

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
    <link rel="stylesheet" href="css/handbook.css"/>
    <link rel="stylesheet" href="css/index.css"/>
    <link rel="stylesheet" href="../css/root.css"/>
</head>

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

    <div class="container">
        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="search-wrapper">
                        <i class="fas fa-search search-icon"></i>
                        <input
                                type="text"
                                class="search-input"
                                placeholder="Tìm theo tên người dùng..."
                        />
                    </div>
                </div>
                <div class="col-md-6 text-end mt-3 mt-md-0">
                    <button class="btn-add fw-medium px-4 py-2 text-decoration-none" data-bs-toggle="modal" data-bs-target="#userModal">
                        <i class="fas fa-plus"></i> Thêm người dùng
                    </button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <table class="table">
                <thead class="table-primary">
                <tr>
                    <th class ="text-center align-middle" style="width: 40px">
                        <input class="form-check-input" type="checkbox" id="selectAll"/>
                    </th>
                    <th class="sortable text-white text-nowrap " data-column="name">Họ Tên<i class="fas fa-sort ms-1 text-white"></i></th>
                    <th class="sortable text-white text-nowrap " data-column="email">Email<i class="fas fa-sort ms-1 text-white"></i>
                    </th>
                    <th class="sortable text-white text-nowrap" data-column="phone">Điện thoại<i
                            class="fas fa-sort ms-1 text-white"></i></th>
                    <th class="sortable text-white text-nowrap" data-column="gender">Giới tính<i
                            class="fas fa-sort ms-1 text-white"></i></th>
                    <th class="sortable text-white text-nowrap" data-column="address">Địa chỉ<i class="fas fa-sort ms-1 text-white"></i>
                    </th>
                    <th class="sortable text-white text-nowrap" data-column="role">Vai trò<i class="fas fa-sort ms-1 text-white"></i>
                    </th>
                    <th class="sortable text-white text-nowrap" data-column="status">Trạng thái<i
                            class="fas fa-sort ms-1 text-white"></i></th>
                    <th class="sortable text-white text-nowrap" data-column="created">Ngày tạo<i
                            class="fas fa-sort ms-1 text-white"></i></th>
                    <th class="text-white">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class ="text-center align-middle" style="width: 40px">
                        <input class="form-check-input" type="checkbox" id="selectAll"/>
                    </td>
                    <td>Nguyễn Văn An</td>
                    <td>nguyenvanan@example.com</td>
                    <td>0912345678</td>
                    <td>Nam</td>
                    <td title="123 Đường Lê Lợi, Quận 1, TP.HCM">TP.HCM</td>
                    <td><span class="badge bg-secondary">Admin</span></td>
                    <td><span class="badge bg-success">Hoạt động</span></td>
                    <td>12/11/2025</td>
                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none">
                                <i class="fas fa-edit"></i>
                            </button>

                            <button class="btn btn-link text-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class ="text-center align-middle" style="width: 40px">
                        <input class="form-check-input" type="checkbox" id="selectAll"/>
                    </td>
                    <td>Nguyễn Văn An</td>
                    <td>nguyenvanan@example.com</td>
                    <td>0912345678</td>
                    <td>Nam</td>
                    <td title="123 Đường Lê Lợi, Quận 1, TP.HCM">TP.HCM</td>
                    <td><span class="badge bg-secondary">User</span></td>
                    <td><span class="badge bg-success">Hoạt động</span></td>
                    <td>12/11/2025</td>
                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none">
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
                <p class="mb-0">Hiển thị 2 trong 100 người dùng</p>
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

    <!-- Modal thêm/sửa người dùng -->
    <div class="modal fade" id="userModal" tabindex="-1" aria-labelledby="userModalLabel" aria-hidden="true">
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
                            <label for="address" class="form=label">Địa chỉ</label>
                            <textarea class="form-control" id="address"></textarea>
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
                        <i class="fas fa-times"></i> Hủy
                    </button>
                    <button type="button" class="btn btn-primary" id="btnSaveUser">
                        <i class="fas fa-check"></i> Lưu
                    </button>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
