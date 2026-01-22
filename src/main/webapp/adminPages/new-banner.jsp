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

    <form id="bannerForm" method="post" enctype="multipart/form-data"
          action="${pageContext.request.contextPath}/admin/new-banners">

        <input type="hidden" name="id" value="${banner.id}">

        <div class="mb-3">
            <label class="form-label">Tên Banner *</label>
            <input type="text"
                   class="form-control"
                   name="name"
                   value="${banner.name}"
                   required>
        </div>

        <div class="mb-3">
            <label class="form-label">Chọn Sự Kiện</label>
            <select class="form-select" name="eventId">
                <option value="">-- Chọn sự kiện --</option>
                <c:forEach var="e" items="${events}">
                    <option value="${e.id}" ${e.id == banner.eventId ? 'selected' : ''}>
                            ${e.name}
                    </option>
                </c:forEach>
            </select>
        </div>

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

            <small class="text-muted">JPG, PNG, GIF - tối đa 5MB</small>
        </div>

        <div class="mb-4">
            <label class="form-label">Trạng Thái</label>
            <select class="form-select" name="status">
                <option value="true" ${banner.status ? 'selected' : ''}>Hiển thị</option>
                <option value="false" ${!banner.status ? 'selected' : ''}>Ẩn</option>
            </select>
        </div>

        <div class="mb-4">
            <label class="form-label">Vị trí</label>
            <select class="form-select" name="group">
                <option value="TRANG_CHU" ${banner.status ? 'selected' : ''}>Trang chủ</option>
                <option value="KHUYEN_MAI" ${!banner.status ? 'selected' : ''}>Khuyến mãi</option>
            </select>
        </div>
        <input
                type="number"
                name="sortOrder"
                value="0"
                min="0"
                step="1"
        />


        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">
                <i class="fa-solid fa-floppy-disk"></i> Lưu Banner
            </button>
            <button type="button" class="btn btn-secondary" onclick="cancelForm()">
                <i class="fa-solid fa-xmark"></i> Hủy
            </button>
        </div>
    </form>

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
    let selectedImage = null;

    // Load dữ liệu mẫu khi trang load (giả lập load từ server)
    window.onload = function() {
        // Giả lập dữ liệu brand từ server
        const brandData = {
            name: "Nike",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_NIKE.svg",
            productCount: 150,
            status: "active",
            description: "Thương hiệu thể thao hàng đầu thế giới"
        };

        // Điền dữ liệu vào form
        loadBrandData(brandData);
    };

    function loadBrandData(data) {
        document.getElementById('brandName').value = data.name || '';
        document.getElementById('productCount').value = data.productCount || 0;
        document.getElementById('description').value = data.description || '';

        // Set status
        if (data.status === 'locked') {
            document.getElementById('statusLocked').checked = true;
        } else {
            document.getElementById('statusActive').checked = true;
        }

        // Load image nếu có
        if (data.imageUrl) {
            const preview = document.getElementById('imagePreview');
            const placeholder = document.getElementById('uploadPlaceholder');
            const removeBtn = document.getElementById('removeImageBtn');

            preview.src = data.imageUrl;
            preview.classList.add('show');
            placeholder.classList.add('hide');
            removeBtn.classList.add('show');
        }
    }

    function previewImage(event) {
        const file = event.target.files[0];

        if (file) {
            // Kiểm tra kích thước file (5MB)
            if (file.size > 5 * 1024 * 1024) {
                showToast('Kích thước file không được vượt quá 5MB!', 'error');
                event.target.value = '';
                return;
            }

            // Kiểm tra định dạng file
            const allowedTypes = ['image/png', 'image/jpeg', 'image/jpg'];
            if (!allowedTypes.includes(file.type)) {
                showToast('Chỉ chấp nhận file PNG, JPG hoặc JPEG!', 'error');
                event.target.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById('imagePreview');
                const placeholder = document.getElementById('uploadPlaceholder');
                const removeBtn = document.getElementById('removeImageBtn');

                preview.src = e.target.result;
                preview.classList.add('show');
                placeholder.classList.add('hide');
                removeBtn.classList.add('show');

                selectedImage = file;
            };
            reader.readAsDataURL(file);
        }
    }

    function removeImage(event) {
        event.stopPropagation(); // Ngăn trigger click vào container

        const preview = document.getElementById('imagePreview');
        const placeholder = document.getElementById('uploadPlaceholder');
        const removeBtn = document.getElementById('removeImageBtn');
        const fileInput = document.getElementById('imageFile');

        // Reset preview
        preview.src = '';
        preview.classList.remove('show');
        placeholder.classList.remove('hide');
        removeBtn.classList.remove('show');

        // Clear file input
        fileInput.value = '';
        selectedImage = null;
    }

    function goBack() {
        if (confirm('Bạn có chắc muốn hủy? Các thay đổi sẽ không được lưu.')) {
            window.history.back();
        }
    }



    function showToast(message, type = 'success') {
        const toastEl = document.getElementById('toast');
        const toastMessage = document.getElementById('toastMessage');
        const toastHeader = toastEl.querySelector('.toast-header');

        toastMessage.textContent = message;

        // Đổi màu icon theo loại
        const icon = toastHeader.querySelector('i');
        if (type === 'error') {
            icon.className = 'fas fa-exclamation-circle text-danger me-2';
        } else {
            icon.className = 'fas fa-check-circle text-success me-2';
        }

        const toast = new bootstrap.Toast(toastEl);
        toast.show();
    }
</script>
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