<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="now" class="java.util.Date"/>
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
                    <button class="nav-link btn-nav  fw-medium px-4 py-2 text-decoration-none"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/events'">
                        <i class="fas fa-calendar-check me-2"></i>Events
                    </button>

                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none active" type="button"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/promotions'">
                        <i class="fas fa-percentage me-2"></i>Promotions
                    </button>


                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none "
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/events'">
                        <i class="fas fa-image me-2"></i>Banners
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-content">
        <!-- Promotions Tab -->
        <div class="tab-pane active fade show container mb-3"  id="promotions">
            <div class="filter-section">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="search-wrapper">
                            <i class="fas fa-search search-icon"></i>
                            <input
                                    type="text"
                                    class="search-input"
                                    placeholder="Tìm theo tên promotion..."
                            />
                        </div>
                    </div>
                    <div class="col-md-6 text-end mt-3 mt-md-0">
                        <button class="btn-add fw-medium px-4 py-2 text-decoration-none" data-bs-toggle="modal"
                                data-bs-target="#promotionModal">
                            <i class="fas fa-plus"></i> Thêm promotion
                        </button>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Tên promotion</th>
                        <th> % </th>
                        <th> price </th>
                        <th>Thời hạn</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${promotions}" var="prom">
                        <tr>
                            <td>${prom.name}</td>
                            <td>
                                <span class="badge bg-success">  -${prom.discountPercent}%</span>
                            </td>
                            <td>
                                    <span class="badge bg-success"> -<fmt:formatNumber value="${prom.discountPrice}" type="currency"/> </span>
                            </td>

                            <td>${prom.expiredAt}</td>
                            <td class="text-nowrap">
                                <c:choose>
                                    <c:when test="${prom.active}">
                                        <span class="badge bg-success">Hoạt động</span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="badge bg-danger">ẩn</span>
                                    </c:otherwise>
                                </c:choose>


                            </td>
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
                    </c:forEach>
                    </tbody>
                </table>

                <hr class="mx-5"/>
                <div class="d-flex justify-content-between align-items-center m-3">
                    <p class="mb-0">
                        Hiển thị ${pageSize_promotion} trong ${totalElements_promotion} giam gia,
                        trang hiện tại ${currentPage_promotion },
                        tổng trang ${totalPages_promotion}
                    </p>

                    <nav>
                        <ul class="pagination mb-0">
                            <c:forEach var="i" begin="0" end="${totalPages_promotion - 1}" varStatus="st">

                                <c:choose>
                                    <c:when test="${st.index+1 == currentPage_promotion}">
                                        <li class="page-item active">
                                            <a class="page-link"
                                               href="${pageContext.request.contextPath}/admin/promotions?page=${st.index + 1}">
                                                    ${st.index + 1}
                                            </a>
                                        </li>
                                    </c:when>

                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="${pageContext.request.contextPath}/admin/promotions?page=${st.index + 1}">
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



</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
