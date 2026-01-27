<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật Banner</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }
        .breadcrumb {
            color: #666;
            font-size: 14px;
        }
        .breadcrumb a {
            color: #2196F3;
            text-decoration: none;
        }
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        .required {
            color: #f44336;
        }
        input[type="text"],
        input[type="number"],
        input[type="file"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus {
            outline: none;
            border-color: #2196F3;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
        }
        input[type="checkbox"] {
            width: 20px;
            height: 20px;
            margin-right: 10px;
            cursor: pointer;
        }
        .help-text {
            font-size: 13px;
            color: #666;
            margin-top: 5px;
        }
        .current-image {
            margin-top: 10px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 5px;
        }
        .current-image img {
            max-width: 100%;
            max-height: 200px;
            border-radius: 5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .current-image p {
            margin-bottom: 10px;
            font-weight: 600;
            color: #555;
        }
        .image-preview {
            margin-top: 15px;
            display: none;
        }
        .image-preview img {
            max-width: 100%;
            max-height: 300px;
            border-radius: 5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
            font-weight: 600;
        }
        .btn-primary {
            background: #2196F3;
            color: white;
        }
        .btn-primary:hover {
            background: #0b7dda;
        }
        .btn-secondary {
            background: #757575;
            color: white;
        }
        .btn-secondary:hover {
            background: #616161;
        }
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #f44336;
        }
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #4CAF50;
        }
        .info-box {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #2196F3;
        }
        .info-box strong {
            color: #1976D2;
        }
    </style>
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>
<div class="container">
    <button type="button" class="btn btn-secondary" onclick="history.back()">
        ← Quay lại
    </button>
    <div class="header">
        <h1>Cập nhật Banner</h1>
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">
            ⚠️ ${error}
        </div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="success-message">
            ✅ ${success}
        </div>
    </c:if>

    <div class="info-box">
        <strong>ID Banner:</strong> ${banner.id} |
        <strong>Ngày tạo:</strong> <div >${banner.createdAt} </div>
    </div>

    <form action="${pageContext.request.contextPath}/admin/banners/update"
          method="post"
          enctype="multipart/form-data"
          onsubmit="return validateForm()">

        <input type="hidden" name="id" value="${banner.id}">

        <div class="form-group">
            <label for="title">
                Tiêu đề Banner
            </label>
            <input type="text"
                   id="title"
                   name="title"
                   placeholder="Nhập tiêu đề banner..."
                   value="${banner.title}">
            <div class="help-text">Tiêu đề mô tả cho banner (tùy chọn)</div>
        </div>

        <div class="form-group">
            <label for="imgFile">
                Hình ảnh
            </label>

            <div class="current-image">
                <p>Hình ảnh hiện tại:</p>
                <img src="${banner.imgPath}"
                     alt="${banner.title}"
                     onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'">
            </div>

            <input type="file"
                   id="imgFile"
                   name="imgFile"
                   accept="image/*"
                   onchange="previewImage(this)">
            <div class="help-text">Chọn file ảnh mới nếu muốn thay đổi (JPG, PNG, GIF). Để trống nếu giữ nguyên ảnh cũ.</div>

            <div class="image-preview" id="imagePreview">
                <p style="font-weight: 600; margin-top: 10px;">Ảnh mới:</p>
                <img id="preview" src="" alt="Preview">
            </div>
        </div>

        <div class="form-group">
            <label for="groupTag">
                Nhóm Banner <span class="required">*</span>
            </label>
            <select id="groupTag" name="groupTag" required>
                <option value="">-- Chọn nhóm banner --</option>
                <option value="TRANG_CHU" ${banner.groupTag eq 'TRANG_CHU' ? 'selected' : ''}>Trang chủ (Home)</option>
                <option value="KHUYEN_MAI" ${banner.groupTag eq 'KHUYEN_MAI' ? 'selected' : ''}>Trang giảm giá (Discount)</option>

            </select>
            <div class="help-text">Chọn vị trí hiển thị banner trên website</div>
        </div>

        <div class="form-group">
            <label for="sortOrder">
                Thứ tự hiển thị <span class="required">*</span>
            </label>
            <input type="number"
                   id="sortOrder"
                   name="sortOrder"
                   min="0"
                   value="${banner.sortOrder}"
                   required>
            <div class="help-text">Số thứ tự hiển thị (0 = đầu tiên, càng lớn càng xuống dưới)</div>
        </div>

        <div class="form-group">
            <label for="eventId">
                Event liên kết
            </label>
            <select id="eventId" name="eventId">
                <option value="">-- Không liên kết event --</option>
                <c:forEach var="event" items="${events}">
                    <option value="${event.id}" ${banner.eventId eq event.id ? 'selected' : ''}>
                            ${event.name}
                    </option>
                </c:forEach>
            </select>
            <div class="help-text">Liên kết banner với một sự kiện (tùy chọn)</div>
        </div>

        <div class="form-group">

            <div class="mb-4">
                <label class="form-label">Trạng Thái</label>
                <select class="form-select" name="isActive">
                    <option value="true"
                    ${banner.active ? 'selected' : ''}>
                        Hiển thị
                    </option>

                    <option value="false"
                    ${!banner.active ? 'selected' : ''}>
                        Ẩn
                    </option>
                </select>
            </div>

            <div class="help-text">Bỏ check để tạm ẩn banner này khỏi website</div>
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-primary">
                Cập nhật Banner
            </button>
            <a href="${pageContext.request.contextPath}/admin/banners" class="btn btn-secondary">
                Hủy bỏ
            </a>
        </div>
    </form>
</div>

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