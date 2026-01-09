<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Sự Kiện</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý sự kiện</h1>
                </div>
                <div class="nav col d-flex gap-2 justify-content-end">
                    <button class="nav-link btn-nav active fw-medium px-4 py-2 text-decoration-none" data-bs-toggle="tab"
                            data-bs-target="#events" type="button">
                        <i class="fas fa-calendar-check me-2"></i>Events
                    </button>

                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none" data-bs-toggle="tab"
                            data-bs-target="#promotions" type="button">
                        <i class="fas fa-percentage me-2"></i>Promotions
                    </button>

                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none" data-bs-toggle="tab"
                            data-bs-target="#vouchers" type="button">
                        <i class="fas fa-ticket-alt me-2"></i>Vouchers
                    </button>

                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none" data-bs-toggle="tab"
                            data-bs-target="#banners" type="button">
                        <i class="fas fa-image me-2"></i>Banners
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-content">
        <!-- Banners Tab -->
        <div class="tab-pane fade container mb-3" id="banners">
            <div class="filter-section">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="search-wrapper">
                            <i class="fas fa-search search-icon"></i>
                            <input
                                    type="text"
                                    class="search-input"
                                    placeholder="Tìm theo tên banner..."
                            />
                        </div>
                    </div>
                    <div class="col-md-6 text-end mt-3 mt-md-0">
                        <button class="btn-add fw-medium px-4 py-2 text-decoration-none" data-bs-toggle="modal"
                                data-bs-target="#bannerModal">
                            <i class="fas fa-plus"></i> Thêm banner
                        </button>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Tên Banner</th>
                        <th>Ảnh</th>
                        <th>Sự kiện</th>
                        <th>Trạng Thái</th>
                        <th>Thao Tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Black Friday Hero Banner</td>
                        <td><img src="" alt=""></td>
                        <td>/events/black-friday</td>
                        <td><span class="badge badge-active">Hiển thị</span></td>
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
                    <p class="mb-0">
                        Hiển thị ${pageSize_banner} trong ${totalElements_banner} giam gia,
                        trang hiện tại ${currentPage_banner},
                        tổng trang ${totalPages_banner}
                    </p>

                    <nav>
                        <ul class="pagination mb-0">
                            <c:forEach var="i" begin="0" end="${totalPages_banner - 1}" varStatus="st">

                                <c:choose>
                                    <c:when test="${st.index+1 == currentPage_banner}">
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

</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
