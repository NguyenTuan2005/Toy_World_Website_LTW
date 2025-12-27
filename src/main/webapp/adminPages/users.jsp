
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN" />
<html lang="en">
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
                                <i class="fas fa-users"></i>
                            </div>
                            <h3 class="stats-value"><fmt:formatNumber value="${total_users_num}" type="number" /></h3>
                            <p class="stats-label">Tổng người dùng</p>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-3">
                        <div class="stats-card warning">
                            <div class="stats-icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <h3 class="stats-value"><fmt:formatNumber value="${total_new_users_num}" type="number" /></h3>
                            <p class="stats-label">Mới tháng này</p>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-3">
                        <div class="stats-card info">
                            <div class="stats-icon">
                                <i class="fas fa-user-shield"></i>
                            </div>
                            <h3 class="stats-value"><fmt:formatNumber value="${total_admins_num}" type="number" /></h3>
                            <p class="stats-label">Quản trị viên</p>
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
                    <c:if test="${find_user != null}">
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
                <table class="table">
                    <thead class="table-primary">
                    <tr>
                        <th class ="text-center align-middle" style="width: 40px">
                            <input class="form-check-input" type="checkbox" id="selectAl"/>
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
                    <style>
                        .status-active {
                            background-color: #e6f4ea;
                            color: #1e7e34;
                            border: 1px solid #1e7e34;
                        }

                        .status-locked {
                            background-color: #fdecea;
                            color: #dc3545;
                            border: 1px solid #dc3545;
                        }

                    </style>
                    <c:forEach var="u" items="${manage_users}">
                        <tr>
                            <td class ="text-center align-middle" style="width: 40px">
                                <input class="form-check-input" type="checkbox" id="selectl"/>
                            </td>
                            <td>${u.firstName}</td>
                            <td>${u.email}</td>
                            <td>${u.phone}</td>
                            <td>${u.sex}</td>
                            <td>${u.province}</td>
                            <td><span class="badge bg-secondary">
                                    ${u.role}
                            </span></td>
                            <td>
                                <span class="badge ${u.active ? 'status-active' : 'status-locked'}">
                                  <c:choose>
                                      <c:when test="${u.active}">
                                          Hoạt động
                                      </c:when>
                                      <c:otherwise>
                                          Khóa
                                      </c:otherwise>
                                  </c:choose>
                                </span>
                            </td>
                            <td>${u.createdAt}</td>
                            <td>
                                <div class="d-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/user-details?userId=${u.userId}" class="btn btn-link text-primary text-decoration-none">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>

                                    <button class="btn btn-link text-success text-decoration-none">
                                        <i class="fas fa-edit"></i>
                                    </button>

                                    <form method="post" action="/childrentoyweb_war/admin/hidden-users">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <input type="hidden" name="active" value="${u.active}">
                                        <button class="btn btn-link text-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>


                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>

                <hr class="mx-5"/>
                <div class="d-flex justify-content-between align-items-center m-3">

                    <c:if test="${find_user == null}">
                        <p class="mb-0">
                            Hiển thị ${pageSize} trong ${totalElements} người dùng,
                            trang hiện tại ${currentPage },
                            tổng trang ${totalPages}
                        </p>

                        <nav>
                            <ul class="pagination mb-0">
                                <c:forEach var="i" begin="0" end="${totalPages - 1}" varStatus="st">

                                    <c:choose>
                                        <c:when test="${st.index+1 == currentPage}">
                                            <li class="page-item active">
                                                <a class="page-link"
                                                   href="${pageContext.request.contextPath}/admin/users?page=${st.index + 1}">
                                                        ${st.index + 1}
                                                </a>
                                            </li>
                                        </c:when>

                                        <c:otherwise>
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="${pageContext.request.contextPath}/admin/users?page=${st.index + 1}">
                                                        ${st.index + 1}
                                                </a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>

                                </c:forEach>
                            </ul>
                        </nav>
                    </c:if>

                </div>
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
                                    <option value="male">Nam</option>
                                    <option value="female">Nữ</option>
                                    <option value="other">Khác</option>
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
                                <option value="hanoi">Hà Nội</option>
                                <option value="hcm">TP. Hồ Chí Minh</option>
                                <option value="danang">Đà Nẵng</option>
                                <option value="haiphong">Hải Phòng</option>
                                <option value="cantho">Cần Thơ</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ</label>
                            <textarea class="form-control" id="address" name="address"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="roles" class="form-label">Vai trò</label>
                            <select class="form-select" id="roles" name="roles" multiple>
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                                <option value="moderator">Moderator</option>
                                <option value="editor">Editor</option>
                            </select>
                            <small class="form-text text-muted">Giữ Ctrl (hoặc Cmd) để chọn nhiều vai trò</small>
                        </div>

                        <div class="mb-3 form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="status" name="status" value="active" checked>
                            <label class="form-check-label" for="status">Trạng thái hoạt động</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times"></i> Hủy
                        </button>
                        <button type="submit" class="btn btn-primary">
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
