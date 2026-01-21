<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Banner</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>

    <!-- Font icon -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>
        .img-preview {
            max-width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 10px;
            border: 2px dashed #ddd;
            padding: 5px;
            transition: 0.3s;
        }

        .img-preview:hover {
            transform: scale(1.02);
        }
    </style>
</head>

<body>

<div class="container mt-5">

    <h4 class="mb-4">
        <i class="fa-solid fa-image"></i>
        Form Banner
    </h4>

    <form id="bannerForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/update-banners" >
        <input type="hidden" value="${banner.id}" name="id">

        <div class="mb-3">
            <label class="form-label">Tên Banner *</label>
            <input type="text"
                   class="form-control"
                   name="name"
                   value="${banner.title}"
                   required>
        </div>

        <div class="mb-3">
            <label class="form-label">Chọn Sự Kiện</label>
            <select class="form-select" name="eventId">
                    <c:forEach var="e" items="${events}">
                        <option value="${e.id}" >
                            ${e.name}
                        </option>
                    </c:forEach>
            </select>
        </div>

        <!-- Upload ảnh -->
        <div class="mb-3">
            <label class="form-label">Upload Hình Ảnh *</label>

            <input type="file"
                   class="form-control"
                   name="bannerImage"
                   accept="image/*"
                   onchange="previewBanner(this)">

            <div class="mt-3">
                <img id="bannerPreview"
                     src="${banner.imgPath}"
                     class="img-preview ${empty banner.imgPath ? 'd-none' : ''}">
            </div>

            <small class="text-muted">
                JPG, PNG, GIF - tối đa 5MB
            </small>
        </div>

        <div class="mb-4">
            <label class="form-label">Trạng Thái</label>
            <select class="form-select" name="status">
                <option value="true">
                    Hiển thị
                </option>
                <option value="false">
                    Ẩn
                </option>
            </select>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">
                <i class="fa-solid fa-floppy-disk"></i>
                Lưu Banner
            </button>

            <button type="button" class="btn btn-secondary" onclick="cancelForm()">
                <i class="fa-solid fa-xmark"></i>
                Hủy
            </button>
        </div>

    </form>

</div>

<!-- JS -->
<script>
    function previewBanner(input) {
        const preview = document.getElementById("bannerPreview");

        if (input.files && input.files[0]) {
            const reader = new FileReader();

            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.classList.remove("d-none");
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    function cancelForm() {
        if (confirm('Bạn có chắc muốn hủy? Các thay đổi sẽ không được lưu.')) {
            // Quay lại trang danh sách banner hoặc reset form
            window.history.back();
            // Hoặc reset form: document.getElementById('bannerForm').reset();
        }
    }
</script>

</body>
</html>