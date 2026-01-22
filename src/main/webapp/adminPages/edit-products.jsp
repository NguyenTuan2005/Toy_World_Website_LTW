<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <fmt:setLocale value="vi_VN"/>
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>
<main class="main-content">
    <div class="px-3 py-4 hstack justify-content-between">
        <h2 class="fw-bold">Cập Nhật Sản Phẩm Mới</h2>
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
        <form id="editProductForm"
              action="${pageContext.request.contextPath}/admin/edit-products"
              method="post"
              enctype="multipart/form-data">

            <input type="hidden" name="id" value="${product.id}">

            <div class="mb-3">
                <label class="form-label">Tên Sản Phẩm <span class="text-danger">*</span></label>
                <input class="form-control" name="name" value="${product.name}" required>
            </div>

            <div class="hstack gap-2 mb-3">
                <div class="col">
                    <label class="form-label">Giá <span class="text-danger">*</span></label>
                    <fmt:formatNumber value="${product.price}"
                                      type="number"
                                      groupingUsed="false"
                                      var="plainPrice"/>

                    <input type="number"
                           class="form-control"
                           name="price"
                           value="${plainPrice}"
                           min="0">
                </div>
                <div class="col">
                    <label class="form-label">Số Lượng <span class="text-danger">*</span></label>
                    <input type="number" class="form-control" name="quantity" value="${product.quantity}" required min="0">
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
                <c:forEach var="entry" items="${product.restInfo}">
                    <tr>
                        <td class="text-center"><input class="form-control key-input" value="${entry.key}"></td>
                        <td class="text-center"><input class="form-control value-input" value="${entry.value}"></td>
                        <td class="text-center">
                            <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">X
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <button type="button" class="btn btn-secondary mb-3" onclick="addRowToTable('kvTableUpdate')">
                <i class="bi bi-plus-circle"></i> Thêm Thông Số
            </button>

            <input type="hidden" name="restInfo" id="restInfoEdit">

            <div class="mb-3">
                <label class="form-label">Mô Tả Sản Phẩm</label>
                <textarea class="form-control" name="description" rows="4">${product.description}</textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Khuyến mãi <span class="text-danger">*</span></label>
                <select class="form-select" size="6" name="promotionId" required>
                    <option disabled>-- Chọn loại khuyến mãi --</option>

                    <c:set var="hasPromotion" value="false" />
                    <c:forEach var="prCheck" items="${promotions}">
                        <c:if test="${prCheck.id == product.promotionId}">
                            <c:set var="hasPromotion" value="true" />
                        </c:if>
                    </c:forEach>

                    <option value=""
                            <c:if test="${product.promotionId == null and hasPromotion == false}">
                                selected
                            </c:if>
                    >Không áp dụng</option>
                    <c:forEach var="pr" items="${promotions}">
                        <option value="${pr.id}"
                                <c:if test="${ product.promotionId != null and pr.id == product.promotionId}">
                                    selected
                                </c:if>
                        >${pr.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Thương Hiệu <span class="text-danger">*</span></label>
                <select class="form-select" size="6" name="brandId" required>
                    <option disabled>-- Chọn Thương Hiệu --</option>
                    <c:forEach var="b" items="${brands}">
                        <option value="${b.id}" <c:if test="${b.id == product.brandId}">selected</c:if>>${b.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Danh Mục <span class="text-danger">*</span></label>
                <select class="form-select" size="6" name="categoryId" required>
                    <option disabled>-- Chọn Danh Mục --</option>
                    <c:forEach var="c" items="${categories}">
                        <option value="${c.id}" <c:if test="${c.id == product.categoryId}">selected</c:if>>${c.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Hình Ảnh Mới (Chọn để thêm ảnh)</label>
                <input type="file" class="form-control" id="imageUploadEdit" name="images" multiple
                       accept="image/*">
                <div id="previewEdit" class="overflow-x-auto hstack gap-2 image-preview mt-2">
                    <c:forEach var="a" items="${assets}">
                        <div class="position-relative preview-wrapper" data-asset-id="${a.id}" style="width: 120px">
                            <img src="${a.imgPath}" style="width: 120px; height: 80px; object-fit: cover; border-radius: 4px">
                            <button type="button"
                                    class="btn btn-sm bg-secondary-subtle fw-bold position-absolute"
                                    style="top: 1px; right: 1px"
                                    onclick="removeExistingImg(this, ${a.id})"
                            >×</button>
                        </div>
                    </c:forEach>
                </div>

                <input type="hidden" name="deletedImages" id="deletedImages" value="">
            </div>

            <div class="mb-3 form-check form-switch">
                <input type="hidden" name="isActive" id="isActive" value="${product.active}">
                <input class="form-check-input"
                       type="checkbox"
                       id="statusAdd"
                       onchange="document.getElementById('isActive').value = this.checked"
                       <c:if test="${product.active}">checked</c:if>>
                <label class="form-check-label" for="statusAdd">Trạng thái bán hàng (Bán ngay)</label>
            </div>
        </form>
    </div>
    <div class="p-3 hstack gap-2 justify-content-end">
        <button type="button" class="btn btn-outline-secondary" onclick="window.location.href='${pageContext.request.contextPath}/admin/products'">
            <i class="fas fa-times"></i> Hủy
        </button>
        <button id="submitButton" type="button" class="btn btn-danger" onclick="submitUpdateProduct()">
            <i class="fas fa-check"></i> Cập Nhật
        </button>
    </div>
</main>

<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>

<script src="${pageContext.request.contextPath}/adminPages/js/new-products.js"></script>
<script src="${pageContext.request.contextPath}/adminPages/js/edit-products.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
