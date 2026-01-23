<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Sản Phẩm</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/products.css">
    <fmt:setLocale value="vi_VN"/>
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between">
                <h1 class="page-title">Quản lý sản phẩm</h1>

                <!-- Nav Pills -->
                <ul class="nav nav-pills">
                    <li class="nav-item me-1">
                        <button class="nav-link active">
                            <i class="fas fa-box"></i> Danh sách sản phẩm
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link"
                                onclick="window.location.href='${pageContext.request.contextPath}/admin/comments'">
                            <i class="fas fa-comments"></i> Bình luận sản phẩm
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="container">
        <div id="alert" class="alert alert-danger text-center d-none" role="alert">
            ${error}
        </div>

        <div class="filter-section">
            <div class="hstack align-items-center justify-content-between">
                <div class="search-wrapper">
                    <i class="fas fa-search search-icon"></i>
                    <form class="mb-0" method="post" action="${pageContext.request.contextPath}/admin/products">
                        <input type="text" name="keyword" class="form-control search-input" value="${keyword}" placeholder="Tìm theo tên sản phẩm..."/>
                        <c:if test="${keyword != null}">
                            <a class="clear-icon" href="${pageContext.request.contextPath}/admin/products">
                                <i class="fas fa-times"></i>
                            </a>
                        </c:if>
                    </form>
                </div>
                <div class="mt-3 mt-md-0">
                    <button class="btn-add fw-medium px-4 py-2" onclick="window.location.href='${pageContext.request.contextPath}/admin/new-products'">
                        <i class="fas fa-plus"></i> Thêm sản phẩm mới
                    </button>
                </div>
            </div>
        </div>

        <div class="table-container">
                <table class="table">
                    <thead class="table-primary">
                    <tr>
                        <th class="sortable text-white text-nowrap">Mã SP</th>
                        <th class="sortable text-white text-nowrap">Tên Sản Phẩm</th>
                        <th class="sortable text-white text-nowrap">Ảnh</th>
                        <th class="sortable text-white text-nowrap">Giá Tiền</th>
                        <th class="sortable text-white text-nowrap">Thương Hiệu</th>
                        <th class="sortable text-white text-nowrap">Danh Mục</th>
                        <th class="sortable text-white text-nowrap">Số lượng</th>
                        <th class="sortable text-white text-nowrap">Trạng thái</th>
                        <th class="text-white text-nowrap">Hành động</th>
                    </tr>
                    </thead>
                    <tbody id="productTableBody">
                        <c:if test="${empty products}">
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">Không có sản phẩm nào.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td>${p.productId}</td>
                                <td>
                                    <div title="${p.name}" class="product-name-cell">${p.name}</div>
                                </td>
                                <td>
                                    <img src="${p.imgPath}" class="thumb-img w-75" alt="thumbnail"/>
                                </td>
                                <td><fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/></td>
                                <td>${p.brand}</td>
                                <td>${p.category}</td>
                                <td>${p.quantity}</td>
                                <td><span class="badge bg-secondary">${p.status}</span></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-link text-secondary p-0"
                                                onclick="window.location.href='${pageContext.request.contextPath}/admin/edit-products?id=${p.productId}'";
                                                title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <form class="mb-0" action="${pageContext.request.contextPath}/admin/comments" method="post">
                                            <input type="hidden" name="keyword" value="${p.productId}">
                                            <button class="btn btn-link text-secondary p-0" title="Xem bình luận">
                                                <i class="fas fa-comment"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <hr class="mx-5"/>

                <c:if test="${keyword == null}">
                    <div class="d-flex justify-content-between align-items-center m-3">
                        <p id="pageInfo" class="mb-0">Hiển thị ${currentPage}-${totalPages} trong ${totalProduct} sản phẩm</p>
                        <nav>
                            <ul id="productPagination" class="pagination mb-0" data-current-page="${currentPage}">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a title="Tới trang đầu" class="page-link" href="#">|&lt;</a>
                                </li>
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a title="Tới trang sau" class="page-link" href="#">&lt;</a>
                                </li>

                                <c:forEach var="i"
                                           begin="${(totalPages <= 5) ? 1 : (currentPage <= 3 ? 1 : (currentPage >= (totalPages - 2) ? totalPages - 4 : currentPage - 2))}"
                                           end="${(totalPages <= 5) ? totalPages : (currentPage <= 3 ? 5 : (currentPage >= (totalPages - 2) ? totalPages : currentPage + 2))}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a title="Tới trang ${i}" class="page-link" href="#">${i}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                    <a title="Tới trang trước" class="page-link" href="#">&gt;</a>
                                </li>
                                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                    <a title="Tới trang cuối" class="page-link" href="#">&gt;|</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
    </div>
</main>

<c:if test="${not empty error}">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            showAlert(${error});
        });
    </script>
</c:if>

<script>
    const totalPages = ${totalPages};
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/adminPages/js/products.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
