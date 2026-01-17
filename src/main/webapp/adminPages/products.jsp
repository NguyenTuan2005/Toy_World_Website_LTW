<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="d-flex align-items-center">
                <div class="flex-grow-1">
                    <h1 class="page-title">Quản lý sản phẩm</h1>
                </div>

                <!-- Nav Tabs -->
                <ul class="nav nav-pills" id="productTabs" role="tablist">
                    <li class="nav-item me-1" role="presentation">
                        <button class="nav-link active" id="products-tab" data-bs-toggle="tab" data-bs-target="#products" type="button" role="tab">
                            <i class="fas fa-box"></i> Danh sách sản phẩm
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="comments-tab" data-bs-toggle="tab" data-bs-target="#comments" type="button" role="tab">
                            <i class="fas fa-comments"></i> Bình luận sản phẩm
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Tab Content -->
        <div class="tab-content" id="productTabsContent">
            <!-- PRODUCTS TAB -->
            <div class="tab-pane fade show active" id="products" role="tabpanel">
                <div class="filter-section">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <div class="search-wrapper">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" class="search-input" placeholder="Tìm theo tên sản phẩm..."/>
                            </div>
                        </div>
                        <div class="col-md-6 text-end mt-3 mt-md-0">
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
                            <th class="text-center align-middle" style="width: 40px">
                                <input class="form-check-input" type="checkbox" id="selectAllProducts"/>
                            </th>
                            <th class="sortable text-white text-nowrap">Mã SP <i class="fas fa-sort ms-1"></i></th>
                            <th class="sortable text-white text-nowrap">Tên Sản Phẩm <i class="fas fa-sort ms-1"></i></th>
                            <th class="sortable text-white text-nowrap">Ảnh <i class="fas fa-sort ms-1"></i></th>
                            <th class="sortable text-white text-nowrap">Giá Tiền <i class="fas fa-sort ms-1"></i></th>
                            <th class="sortable text-white text-nowrap">Thương Hiệu <i class="fas fa-sort ms-1"></i></th>
                            <th class="sortable text-white text-nowrap">Danh Mục <i class="fas fa-sort ms-1"></i></th>
                            <th class="sortable text-white text-nowrap">Số lượng <i class="fas fa-sort ms-1"></i></th>
                            <th class="sortable text-white text-nowrap">Trạng thái <i class="fas fa-sort ms-1"></i></th>
                            <th class="text-white">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="text-center align-middle">
                                <input class="form-check-input" type="checkbox"/>
                            </td>
                            <td>123</td>
                            <td>Đồ Chơi Mô Hình Siêu Xe Sang Trọng Honda Civic FD2 Type-R</td>
                            <td>
                                <img src="https://www.mykingdom.com.vn/cdn/shop/articles/do-choi-tri-tue-cho-be-6-9-tuoi_0c2a3283-b493-44f6-8e2d-db8803a38067.jpg?v=1761885332" class="thumb-img w-75" alt="thumbnail"/>
                            </td>
                            <td>1.200.000₫</td>
                            <td>Toy's Việt</td>
                            <td>Xe Đồ Chơi</td>
                            <td>100</td>
                            <td><span class="badge bg-success">Còn hàng</span></td>
                            <td>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-link text-secondary p-0" title="Xem chi tiết">
                                        <i class="bi bi-eye-fill"></i>
                                    </button>
                                    <button class="btn btn-link text-secondary p-0" data-bs-toggle="modal" data-bs-target="#updateProductModal" title="Chỉnh sửa">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-link text-secondary p-0" title="Bình luận">
                                        <i class="fas fa-comment"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <hr class="mx-5"/>
                    <div class="d-flex justify-content-between align-items-center m-3">
                        <p class="mb-0">Hiển thị 1-10 trong 100 sản phẩm</p>
                        <nav>
                            <ul class="pagination mb-0">
                                <li class="page-item disabled"><a class="page-link">|&lt;</a></li>
                                <li class="page-item disabled"><a class="page-link">&lt;</a></li>
                                <li class="page-item active"><a class="page-link">1</a></li>
                                <li class="page-item"><a class="page-link">2</a></li>
                                <li class="page-item"><a class="page-link">3</a></li>
                                <li class="page-item"><a class="page-link">&gt;</a></li>
                                <li class="page-item"><a class="page-link">&gt;|</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

            <!-- COMMENTS TAB -->
            <div class="tab-pane fade" id="comments" role="tabpanel">
                <div class="filter-section">
                    <div class="align-items-center">
                        <div class="search-wrapper">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" class="search-input" placeholder="Tìm theo tên người dùng hoặc sản phẩm..."/>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <table class="table">
                        <thead class="table-primary">
                        <tr>
                            <th class="text-center align-middle" style="width: 40px">
                                <input class="form-check-input" type="checkbox" id="selectAllComments"/>
                            </th>
                            <th class="sortable text-white text-nowrap">Khách Hàng <i class="fas fa-sort ms-1"></i></th>
                            <th class="sortable text-white text-nowrap">Sản Phẩm <i class="fas fa-sort ms-1"></i></th>
                            <th class="text-white" style="min-width: 250px">Nội Dung</th>
                            <th class="sortable text-white text-nowrap">Thời Gian <i class="fas fa-sort ms-1"></i></th>
                            <th class="text-white">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="text-center align-middle">
                                <input class="form-check-input" type="checkbox"/>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="https://via.placeholder.com/32" class="rounded-circle me-2" alt="avatar" width="32" height="32"/>
                                    <span>Nguyễn Hữu Duy</span>
                                </div>
                            </td>
                            <td>Đồ chơi cát</td>
                            <td>
                                <div class="comment-content">Sản phẩm tốt quá hehe, con tôi rất thích chơi!</div>
                            </td>
                            <td><small>19/11/2025<br/>23:23:23</small></td>
                            <td>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-link text-warning p-0" title="Ẩn bình luận">
                                        <i class="fas fa-eye-slash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-center align-middle">
                                <input class="form-check-input" type="checkbox"/>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="https://via.placeholder.com/32" class="rounded-circle me-2" alt="avatar" width="32" height="32"/>
                                    <span>Trần Văn A</span>
                                </div>
                            </td>
                            <td>Đồ chơi xếp hình</td>
                            <td>
                                <div class="comment-content">Chất lượng tốt, giao hàng nhanh</div>
                            </td>
                            <td><small>18/11/2025<br/>15:30:00</small></td>
                            <td>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-link text-warning p-0" title="Hiện bình luận">
                                        <i class="fas fa-eye-fill"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <hr class="mx-5"/>
                    <div class="d-flex justify-content-between align-items-center m-3">
                        <p class="mb-0">Hiển thị 1-10 trong 150 bình luận</p>
                        <nav>
                            <ul class="pagination mb-0">
                                <li class="page-item disabled"><a class="page-link">|&lt;</a></li>
                                <li class="page-item disabled"><a class="page-link">&lt;</a></li>
                                <li class="page-item active"><a class="page-link">1</a></li>
                                <li class="page-item"><a class="page-link">2</a></li>
                                <li class="page-item"><a class="page-link">3</a></li>
                                <li class="page-item"><a class="page-link">&gt;</a></li>
                                <li class="page-item"><a class="page-link">&gt;|</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL: THÊM SẢN PHẨM MỚI -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModal" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModal">Thêm Sản Phẩm Mới</h5>
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
                    <h5 class="modal-title" id="updateProductModal">Cập Nhật Thông Tin Sản Phẩm</h5>
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

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
