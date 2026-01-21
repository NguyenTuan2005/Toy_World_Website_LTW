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

                <!-- Nav Tabs -->
                <ul class="nav nav-pills" id="productTabs" role="tablist">
                    <li class="nav-item me-1" role="presentation">
                        <button class="nav-link active" id="products-tab" data-bs-toggle="tab" data-bs-target="#products" type="button" role="tab">
                            <i class="fas fa-box"></i> Danh sách sản phẩm
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="comments-tab" data-bs-toggle="tab" data-bs-target="#comments" type="button" role="tab" onclick="loadComments()">
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

        <!-- Tab Content -->
        <div class="tab-content" id="productTabsContent">
            <!-- PRODUCTS TAB -->
            <div class="tab-pane fade show active mb-4" id="products" role="tabpanel">
                <div class="filter-section">
                    <div class="hstack align-items-center justify-content-between">
                        <div class="search-wrapper">
                            <i class="fas fa-search search-icon"></i>
                            <form class="mb-0" method="post" action="${pageContext.request.contextPath}/admin/products">
                                <input type="text" name="keyword" class="form-control search-input" value="${keyword}" placeholder="Tìm theo tên sản phẩm..."/>
                                <c:if test="${keyword != null}">
                                    <i class="fas fa-times clear-icon"
                                       onclick="window.location.href='${pageContext.request.contextPath}/admin/products'"></i>
                                </c:if>
                            </form>
                        </div>
                        <div class="mt-3 mt-md-0">
                            <button class="btn-add fw-medium px-4 py-2" data-bs-toggle="modal" data-bs-target="#addProductModal">
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
                                            <button class="btn btn-link text-secondary p-0" data-bs-toggle="modal" data-bs-target="#updateProductModal" title="Chỉnh sửa">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn btn-link text-secondary p-0" title="Xem bình luận">
                                                <i class="fas fa-comment"></i>
                                            </button>
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

                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a title="Tới trang trước" class="page-link" href="#">&gt;</a>
                                    </li>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a title="Tới trang cuối" class="page-link" href="#">&gt;|</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- COMMENTS TAB -->
            <div class="tab-pane fade mb-5" id="comments" role="tabpanel">
            </div>
        </div>
    </div>

    <!-- MODAL: THÊM SẢN PHẨM MỚI -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModal" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm Sản Phẩm Mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addProductForm" action="/products/save" method="post" enctype="multipart/form-data">

                        <div class="mb-3">
                            <label class="form-label">Tên Sản Phẩm <span class="text-danger">*</span></label>
                            <input class="form-control" name="name" required>
                        </div>

                        <div class="row mb-3">
                            <div class="col">
                                <label class="form-label">Giá <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="price" required>
                            </div>
                            <div class="col">
                                <label class="form-label">Giảm Giá (%)</label>
                                <input type="number" class="form-control" name="discount_percent" min="0" max="100">
                            </div>
                            <div class="col">
                                <label class="form-label">Số Lượng <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="quantity" required min="0">
                            </div>
                        </div>

                        <label class="form-label">Thông Số Sản Phẩm</label>
                        <table class="table key-value-table" id="kvTableAdd">
                            <thead>
                            <tr>
                                <th>Từ Khóa</th>
                                <th>Nội Dung</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="text-center"><input class="form-control key-input"
                                                               placeholder="VD: Kích thước"></td>
                                <td class="text-center"><input class="form-control value-input"
                                                               placeholder="VD: 30x40cm"></td>
                                <td class="text-center">
                                    <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">X
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-center"><input class="form-control key-input"
                                                               placeholder="VD: Chất liệu"></td>
                                <td class="text-center"><input class="form-control value-input"
                                                               placeholder="VD: Nhựa ABS"></td>
                                <td class="text-center">
                                    <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">X
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-center"><input class="form-control key-input"
                                                               placeholder="VD: Trọng lượng"></td>
                                <td class="text-center"><input class="form-control value-input" placeholder="VD: 500g">
                                </td>
                                <td class="text-center">
                                    <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">X
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-secondary mb-3" onclick="addRowToTable('kvTableAdd')">
                            <i class="bi bi-plus-circle"></i> Thêm Thông Số
                        </button>

                        <input type="hidden" name="rest_info" id="restInfoAdd">

                        <div class="mb-3">
                            <label class="form-label">Mô Tả Sản Phẩm</label>
                            <textarea class="form-control" name="description" rows="4"
                                      placeholder="Nhập mô tả chi tiết về sản phẩm..."></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Thương Hiệu <span class="text-danger">*</span></label>
                            <select class="form-select" name="brand_id" required>
                                <option value="">-- Chọn Thương Hiệu --</option>
                                <option value="1">Nike</option>
                                <option value="2">Yonex</option>
                                <option value="3">Lining</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Danh Mục <span class="text-danger">*</span></label>
                            <select class="form-select" name="category_id" required>
                                <option value="">-- Chọn Danh Mục --</option>
                                <option value="1">Adi</option>
                                <option value="2">Racket</option>
                                <option value="3">Accessory</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Hình Ảnh</label>
                            <input type="file" class="form-control" id="imageUploadAdd" name="images" multiple
                                   accept="image/*">
                            <div id="previewAdd" class="image-preview mt-2"></div>
                        </div>

                        <div class="mb-3 form-check form-switch">
                            <input class="form-check-input" type="checkbox" name="is_active" id="statusAdd" value="true"
                                   checked>
                            <label class="form-check-label" for="statusAdd">Trạng thái bán hàng (Bán ngay)</label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                    <button type="button" class="btn btn-danger" onclick="submitAddProduct()">
                        <i class="fas fa-check"></i> Lưu
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL: CẬP NHẬT THÔNG TIN -->
    <div class="modal fade" id="updateProductModal" tabindex="-1" aria-labelledby="updateProductModal"
         aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cập Nhật Thông Tin Sản Phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="updateProductForm" action="/products/update" method="post" enctype="multipart/form-data">

                        <div class="mb-3">
                            <label class="form-label">Mã Sản Phẩm <span class="text-danger">*</span></label>
                            <div class="d-flex" style="gap: 10px;">
                                <input class="form-control" name="product_id" id="searchProductId"
                                       placeholder="Nhập mã sản phẩm..." style="flex: 1;">
                                <button type="button" class="btn btn-secondary" onclick="searchProduct()">
                                    <i class="bi bi-search"></i> Tìm Kiếm
                                </button>
                            </div>
                            <small class="form-text text-muted">Nhập mã sản phẩm và nhấn "Tìm Kiếm" để tải thông
                                tin</small>
                        </div>

                        <hr>

                        <div class="mb-3">
                            <label class="form-label">Tên Sản Phẩm <span class="text-danger">*</span></label>
                            <input class="form-control" name="name" id="updateName" required>
                        </div>

                        <div class="row mb-3">
                            <div class="col">
                                <label class="form-label">Giá <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="price" id="updatePrice" required>
                            </div>
                            <div class="col">
                                <label class="form-label">Giảm Giá (%)</label>
                                <input type="number" class="form-control" name="discount_percent" id="updateDiscount"
                                       min="0" max="100">
                            </div>
                            <div class="col">
                                <label class="form-label">Số Lượng <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="quantity" id="updateQuantity" required
                                       min="0">
                            </div>
                        </div>

                        <label class="form-label">Thông Số Sản Phẩm</label>
                        <table class="table key-value-table" id="kvTableUpdate">
                            <thead>
                            <tr>
                                <th>Từ Khóa</th>
                                <th>Nội Dung</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="text-center"><input class="form-control key-input"></td>
                                <td class="text-center"><input class="form-control value-input"></td>
                                <td class="text-center">
                                    <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">X
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-secondary mb-3" onclick="addRowToTable('kvTableUpdate')">
                            <i class="bi bi-plus-circle"></i> Thêm Thông Số
                        </button>

                        <input type="hidden" name="rest_info" id="restInfoUpdate">

                        <div class="mb-3">
                            <label class="form-label">Mô Tả Sản Phẩm</label>
                            <textarea class="form-control" name="description" id="updateDescription"
                                      rows="4"></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Thương Hiệu <span class="text-danger">*</span></label>
                            <select class="form-select" name="brand_id" id="updateBrand" required>
                                <option value="">-- Chọn Thương Hiệu --</option>
                                <option value="1">Nike</option>
                                <option value="2">Yonex</option>
                                <option value="3">Lining</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Danh Mục <span class="text-danger">*</span></label>
                            <select class="form-select" name="category_id" id="updateCategory" required>
                                <option value="">-- Chọn Danh Mục --</option>
                                <option value="1">Adi</option>
                                <option value="2">Racket</option>
                                <option value="3">Accessory</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Hình Ảnh Mới (Chọn để thay thế)</label>
                            <input type="file" class="form-control" id="imageUploadUpdate" name="images" multiple
                                   accept="image/*">
                            <div id="previewUpdate" class="image-preview mt-2"></div>
                        </div>

                        <div class="mb-3 form-check form-switch">
                            <input class="form-check-input" type="checkbox" name="is_active" id="statusUpdate"
                                   value="true" checked>
                            <label class="form-check-label" for="statusUpdate">Trạng thái bán hàng (Bán ngay)</label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                    <button type="button" class="btn btn-danger" onclick="submitUpdateProduct()">
                        <i class="fas fa-save"></i> Cập Nhật
                    </button>
                </div>
            </div>
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
