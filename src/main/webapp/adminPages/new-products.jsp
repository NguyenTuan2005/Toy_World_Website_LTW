<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Sản Phẩm</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
</head>
<body>
    <jsp:include page="/common/sidebar.jsp"></jsp:include>
    <main class="main-content">
        <div class="px-3 py-4 hstack justify-content-between">
            <h1 class="fw-bold">Thêm Sản Phẩm Mới</h1>
            <button class="btn btn-outline-secondary"
                    onclick="window.location.href='${pageContext.request.contextPath}/admin/products'">
                <i class="fas fa-arrow-left"></i> Quay lại
            </button>
        </div>
        <hr class="mb-2">

        <div id="alert" class="alert alert-danger text-center d-none" role="alert">
            ${error}
        </div>

        <div class="p-3">
            <form id="addProductForm"
                  action="${pageContext.request.contextPath}/admin/new-products"
                  method="post"
                  enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">Tên Sản Phẩm <span class="text-danger">*</span></label>
                    <input class="form-control" name="name" required>
                </div>

                <div class="hstack gap-2 mb-3">
                    <div class="col">
                        <label class="form-label">Giá <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" name="price" required min="0">
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
                    </tbody>
                </table>
                <button type="button" class="btn btn-secondary mb-3" onclick="addRowToTable('kvTableAdd')">
                    <i class="bi bi-plus-circle"></i> Thêm Thông Số
                </button>

                <input type="hidden" name="restInfo" id="restInfoAdd">

                <div class="mb-3">
                    <label class="form-label">Mô Tả Sản Phẩm</label>
                    <textarea class="form-control" name="description" rows="4"
                              placeholder="Nhập mô tả chi tiết về sản phẩm..."></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Khuyến mãi <span class="text-danger">*</span></label>
                    <select class="form-select" size="6" name="promotionId" required>
                        <option disabled>-- Chọn loại khuyến mãi --</option>
                        <option value="">Không áp dụng</option>
                        <c:forEach var="p" items="${promotions}">
                            <option value="${p.id}">${p.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Thương Hiệu <span class="text-danger">*</span></label>
                    <select class="form-select" size="6" name="brandId" required>
                        <option disabled>-- Chọn Thương Hiệu --</option>
                        <c:forEach var="b" items="${brands}">
                            <option value="${b.id}">${b.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Danh Mục <span class="text-danger">*</span></label>
                    <select class="form-select" size="6" name="categoryId" required>
                        <option disabled>-- Chọn Danh Mục --</option>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.id}">${c.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Hình Ảnh</label>
                    <input type="file" class="form-control" id="imageUploadAdd" name="images" multiple
                           accept="image/*">
                    <div id="previewAdd" class="hstack gap-2 image-preview mt-2"></div>
                </div>

                <div class="mb-3 form-check form-switch">
                    <input class="form-check-input" type="checkbox" name="isActive" id="statusAdd" value="true"
                           checked>
                    <label class="form-check-label" for="statusAdd">Trạng thái bán hàng (Bán ngay)</label>
                </div>
            </form>
        </div>
        <div class="p-3 hstack gap-2 justify-content-end">
            <button type="button" class="btn btn-outline-secondary" onclick="window.location.href='${pageContext.request.contextPath}/admin/products'">
                <i class="fas fa-times"></i> Hủy
            </button>
            <button id="submitButton" type="button" class="btn btn-danger" onclick="submitAddProduct()">
                <i class="fas fa-check"></i> Lưu
            </button>
        </div>
    </main>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
    </script>

    <script src="${pageContext.request.contextPath}/adminPages/js/new-products.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
