<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Quản trị - Quản Lý Người Dùng</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>

    <style>
        .image-preview-container {
            width: 100%;
            max-width: 300px;
            height: 300px;
            border: 2px dashed #dee2e6;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
            position: relative;
            overflow: hidden;
            margin: 0 auto;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .image-preview-container:hover {
            border-color: #0d6efd;
            background-color: #e7f1ff;
        }
        .image-preview {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            display: none;
        }
        .image-preview.show {
            display: block;
        }
        .upload-placeholder {
            text-align: center;
            color: #6c757d;
            pointer-events: none;
        }
        .upload-placeholder.hide {
            display: none;
        }
        .remove-image-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(220, 53, 69, 0.9);
            color: white;
            border: none;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            cursor: pointer;
            display: none;
            z-index: 10;
            transition: all 0.2s ease;
        }
        .remove-image-btn.show {
            display: block;
        }
        .remove-image-btn:hover {
            background: rgba(220, 53, 69, 1);
            transform: scale(1.1);
        }
    </style>
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>
<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý thương hiệu</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-edit"></i> Cập Nhật Thương Hiệu</h2>
                    <a href="${pageContext.request.contextPath}/admin/brands"  class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <!-- Form Card -->
                <div class="card shadow">
                    <div class="card-body p-4">
                        <form id="brandForm" method="post" action="${pageContext.request.contextPath}/admin/update-brands"  enctype="multipart/form-data" >
                            <input type="hidden" name="brandId" value="${brand.id}">
                            <!-- Tên thương hiệu -->
                            <div class="mb-4">
                                <label for="brandName" class="form-label fw-bold">
                                    <i class="fas fa-tag"></i> Tên Thương Hiệu <span class="text-danger">*</span>
                                </label>
                                <input type="text"
                                       class="form-control form-control-lg"
                                       id="brandName"
                                       name="brandName"
                                       required
                                       placeholder="Nhập tên thương hiệu" value="${brand.name}">
                            </div>

                            <div class="form-group">
                                <label for="imgFile">
                                    Hình ảnh
                                </label>

                                <div class="current-image">
                                    <p>📷 Hình ảnh hiện tại:</p>
                                    <img src="${brand.imgPath}"
                                         alt="bug r a"
                                         style="width: 350px; height: auto;">
                                </div>

                                <input type="file"
                                       id="imgFile"
                                       name="imgFile"
                                       accept="image/*"
                                       onchange="previewImage(this)">
                                <div class="help-text">Chọn file ảnh mới nếu muốn thay đổi (JPG, PNG, GIF). Để trống nếu giữ nguyên ảnh cũ.</div>

                                <div class="image-preview" id="imagePreview">
                                    <p style="font-weight: 600; margin-top: 10px;">🔄 Ảnh mới:</p>
                                    <img id="preview" src="" alt="Preview"     style="width: 350px; height: auto;">
                                </div>
                            </div>

                            <!-- Trạng thái -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-toggle-on"></i> Trạng Thái
                                </label>
                                <div>
                                    <select class="form-select" name="active" required>
                                        <option value="true"
                                        ${brand.active == true ? "selected" : ""}>
                                            Đang hoạt động
                                        </option>

                                        <option value="false"
                                        ${brand.active == false ? "selected" : ""}>
                                            Ngưng hoạt động
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <!-- Buttons -->
                            <div class="d-flex gap-2 justify-content-end">
                                <button type="button" onclick="goBack()" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Hủy
                                </button>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save"></i> Lưu Thay Đổi
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- Toast thông báo -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="toast" class="toast hide" role="alert">
        <div class="toast-header">
            <i class="fas fa-check-circle text-success me-2"></i>
            <strong class="me-auto">Thông báo</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body" id="toastMessage"></div>
    </div>
</div>

<c:if test="${not empty notify}">
    <div class="alert alert-success alert-dismissible fade show position-fixed top-0 end-0 m-3"
         role="alert" style="z-index: 9999">
            ${notify}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function previewImage(input) {
        const preview = document.getElementById('preview');
        const previewContainer = document.getElementById('imagePreview');

        if (input.files && input.files[0]) {
            const reader = new FileReader();

            reader.onload = function(e) {
                preview.src = e.target.result;
                previewContainer.style.display = 'block';
            }

            reader.readAsDataURL(input.files[0]);
        } else {
            previewContainer.style.display = 'none';
        }
    }

    function validateForm() {
        const groupTag = document.getElementById('groupTag');
        const sortOrder = document.getElementById('sortOrder');

        if (!groupTag.value) {
            alert('Vui lòng chọn nhóm banner!');
            return false;
        }

        if (sortOrder.value === '') {
            alert('Vui lòng nhập thứ tự hiển thị!');
            return false;
        }

        return confirm('Bạn có chắc muốn cập nhật banner này?');
    }
</script>

</body>
</html>