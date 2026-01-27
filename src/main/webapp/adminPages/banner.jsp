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
<style>
    .status-badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        white-space: nowrap; /* không cho xuống dòng */
        padding: 4px 10px;
    }


    .filter-section select {
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
    }
    .group-section {
        margin-bottom: 40px;
    }
    .group-header {
        background: #cf102d;
        color: white;
        padding: 15px 20px;
        border-radius: 5px;
        margin-bottom: 15px;
        font-size: 18px;
        font-weight: 600;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    th {
        background: #f8f9fa;
        padding: 12px;
        text-align: left;
        font-weight: 600;
        color: #333;
        border-bottom: 2px solid #dee2e6;
    }
    td {
        padding: 12px;
        border-bottom: 1px solid #dee2e6;
    }
    tr:hover {
        background: #f8f9fa;
    }
    .banner-img {
        width: 100px;
        height: 60px;
        object-fit: cover;
        border-radius: 4px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .status-badge {
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 600;
    }
    .status-active {
        background: #d4edda;
        color: #155724;
    }
    .status-inactive {
        background: #f8d7da;
        color: #721c24;
    }
    .actions {
        display: flex;
        gap: 8px;
    }
    .empty-state {
        text-align: center;
        padding: 40px;
        color: #999;
    }
    .sort-order {
        font-weight: 600;
        color: #667eea;
        font-size: 16px;
    }
</style>

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
                    <button class="nav-link btn-nav  fw-medium px-4 py-2 text-decoration-none"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/events'">
                        <i class="fas fa-calendar-check me-2"></i>Events
                    </button>

                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none" type="button"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/promotions'">
                        <i class="fas fa-percentage me-2"></i>Promotions
                    </button>


                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none active "
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/events'">
                        <i class="fas fa-image me-2"></i>Banners
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-content">
        <script>
            document.getElementById("searchInput")
                .addEventListener("keydown", function (e) {
                    if (e.key === "Enter") {
                        e.preventDefault(); // tránh reload không mong muốn
                        document.getElementById("searchForm").submit();
                    }
                });
        </script>
        <!-- Banners Tab -->
        <div class=" container mb-3" >
            <div class="filter-section">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="search-wrapper">
                            <i class="fas fa-search search-icon"></i>
                            <form class="mb-0" id="searchForm"  action="${pageContext.request.contextPath}/admin/search-banners" method="post">
                                <input
                                        type="text"
                                        id="searchInput"
                                        class="search-input"
                                        name="keyword"
                                        placeholder="Nhập  Tên"
                                />
                            </form>
                        </div>
                    </div>
                    <div class="col-md-6 d-flex align-items-center justify-content-end">
                        <c:if test="${find_banners != null }">
                            <nav>
                                <ul class="pagination mb-0 me-2">
                                    <li class="page-item"><a  class="page-link" href="${pageContext.request.contextPath}/admin/banners">Load lại bảng</a></li>
                                </ul>
                            </nav>
                        </c:if>
                        <button class="btn-add fw-medium px-4 py-2 text-decoration-none"    onclick="window.location.href='${pageContext.request.contextPath}/admin/banners/new'">
                            <i class="fas fa-plus"></i> Thêm banner
                        </button>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <c:choose>
                    <c:when test="${empty bannersByGroup}">
                        <div class="empty-state">
                            <h3>Chưa có banner nào</h3>
                            <p>Hãy thêm banner đầu tiên của bạn!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="entry" items="${bannersByGroup}">
                            <div class="group-section">
                                <div class="group-header">
                                    Nhóm: ${entry.key}
                                </div>

                                <table>
                                    <thead>
                                    <tr>
                                        <th style="width: 60px;">Thứ tự</th>
                                        <th style="width: 120px;">Hình ảnh</th>
                                        <th>Tiêu đề</th>
                                        <th>Event ID</th>
                                        <th style="width: 100px;">Trạng thái</th>
                                        <th>Ngày tạo</th>
                                        <th style="width: 150px;">Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="banner" items="${entry.value}">
                                        <tr>
                                            <td class="sort-order">#${banner.sortOrder}</td>
                                            <td>
                                                <img src="${banner.imgPath}"
                                                     alt="${banner.title}"
                                                     class="banner-img"
                                                     onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'">
                                            </td>
                                            <td>${banner.title}</td>
                                            <td>${banner.eventId != null ? banner.eventId : '-'}</td>
                                            <td>
                                                <span class="status-badge ${banner.active ? 'status-active' : 'status-inactive'}">
                                                        ${banner.active ? 'Hoạt động' : 'Tắt'}
                                                </span>
                                            </td>
                                            <td>
                                                <div>"${banner.createdAtFormatted}"</div>
                                            </td>
                                            <td>
                                                <div class="actions">
                                                    <a href="${pageContext.request.contextPath}/admin/banners/update?id=${banner.id}"
                                                       class="btn btn-edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/admin/banners"
                                                          method="post"
                                                          class ="mb-0"
                                                          onsubmit="return confirm('Bạn có chắc muốn xóa banner này?');">
                                                        <input type="hidden" name="id" value="${banner.id}">
                                                        <button type="submit" class="btn btn-delete">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

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
                                               href="${pageContext.request.contextPath}/admin/banners?banner-page=${st.index + 1}">
                                                    ${st.index + 1}
                                            </a>
                                        </li>
                                    </c:when>

                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="${pageContext.request.contextPath}/admin/banners?banner-page=${st.index + 1}">
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
