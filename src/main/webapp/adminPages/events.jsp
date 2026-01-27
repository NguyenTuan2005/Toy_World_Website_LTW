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

                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/promotions'"
                            type="button">
                        <i class="fas fa-percentage me-2"></i>Promotions
                    </button>

                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/banners'"
                            type="button">
                        <i class="fas fa-image me-2"></i>Banners
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-content">
        <!-- Events Tab -->
        <div class="tab-pane active fade show container mb-3" id="events">
            <%--     statistic   --%>
            <div class="row g-3 my-2">
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="stats-number fs-2 fw-bold text-dark">
                                    <fmt:formatNumber value="${total_events}" type="number" maxFractionDigits="0"/>
                                </div>
                                <div class="stats-label text-primary bold-title">
                                    Tổng sự kiện
                                </div>
                            </div>
                            <i class="fas fa-calendar-alt text-muted fs-3"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="stats-number fs-2 fw-bold text-dark">
                                    <fmt:formatNumber value="${total_in_process}" type="number" maxFractionDigits="0"/>
                                </div>
                                <div class="stats-label text-success bold-title">
                                    Đang diễn ra
                                </div>
                            </div>
                            <i class="bi bi-play-circle text-muted fs-3"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="stats-number fs-2 fw-bold text-dark">
                                    <fmt:formatNumber value="${total_by_take_place}" type="number" maxFractionDigits="0"/>
                                </div>
                                <div class="stats-label text-warning bold-title">
                                    Sắp diễn ra
                                </div>
                            </div>
                            <i class="bi bi-calendar-event text-muted fs-3"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="stats-number fs-2 fw-bold text-dark">
                                    <fmt:formatNumber value="${total_done}" type="number" maxFractionDigits="0"/>
                                </div>
                                <div class="stats-label text-danger bold-title">
                                    Đã kết thúc
                                </div>
                            </div>
                            <i class="bi bi-clock text-muted fs-3"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="filter-section">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="search-wrapper">
                            <i class="fas fa-search search-icon"></i>
                            <form class="mb-0" id="searchForm"  action="${pageContext.request.contextPath}/admin/find-events" method="post">
                                <input
                                        type="text"
                                        id="searchInput"
                                        name="keyword"
                                        class="search-input"
                                        placeholder="Nhập ten"
                                >
                            </form>
                        </div>
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
                    <div class="col-md-6 text-end mt-3 mt-md-0">
<%--                        <button type="button"--%>
<%--                                class="btn btn-secondary"--%>
<%--                                onclick="window.location.href='${pageContext.request.contextPath}/admin/new-events'">--%>
<%--                            <i class="bi bi-arrow-left"></i>--%>
<%--                        </button>--%>
                        <button class="btn-add fw-medium px-4 py-2 text-decoration-none"
                                onclick="window.location.href='${pageContext.request.contextPath}/admin/new-events'">
                            <i class="fas fa-plus"></i> Thêm sự kiện
                        </button>
                    </div>
                </div>
            </div>
            <%--        data table--%>
            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Mã sự kiện</th>
                        <th>Tên Sự Kiện</th>
                        <th>Loại</th>
                        <th>Thời gian bắt đầu</th>
                        <th>Thời gian kết thúc</th>
                        <th>Trạng thái</th>
                        <th>Hiện thị</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${events}" var="event">
                            <td class="bold-title">${event.id}</td>
                            <td class="bold-title">${event.name}</td>
                            <td class="text-nowrap">
                                <span class="badge bg-primary">${event.typeEvent}</span>
                            </td>
                            <td>${event.openedAt}</td>
                            <td>${event.closedAt}</td>
                            <td class="text-nowrap">
                                ${event.status}
                            </td>
                                 <td>
                                     <c:choose>

                                         <c:when test="${event.active}">
                                             <span class="badge bg-success">Hiện thị</span>
                                         </c:when>

                                         <c:otherwise>
                                             <span class="badge bg-secondary">Ẩn</span>
                                         </c:otherwise>
                                     </c:choose>
                                 </td>
                            <td>
                                <div class="d-flex gap-2">

                                    <button class="btn btn-link text-success text-decoration-none"
                                            onclick="location.href='${pageContext.request.contextPath}/admin/update-events?id=${event.id}'">
                                        <i class="fas fa-edit"></i>
                                    </button>

                                    <form method="post" action="${pageContext.request.contextPath}/admin/events"   onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật không?');">
                                        <input type="hidden" name="id" value="${event.id}">
                                        <input type="hidden" name="page" value="${currentPage}">
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
                                               href="${pageContext.request.contextPath}/admin/events?page=${st.index + 1}">
                                                    ${st.index + 1}
                                            </a>
                                        </li>
                                    </c:when>

                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="${pageContext.request.contextPath}/admin/events?page=${st.index + 1}">
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
        <c:if test="${not empty notify}">
            <div class="alert alert-success alert-dismissible fade show position-fixed top-0 end-0 m-3"
                 role="alert" style="z-index: 9999">
                    ${notify}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>


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

</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
