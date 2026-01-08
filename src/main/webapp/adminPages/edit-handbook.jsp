<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN" />
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Bài Viết</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/new-handbook.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
</head>
<style>
    /* Form Cards */
    .form-card {
        background: white;
        border-radius: 12px;
        padding: 24px;
        margin-bottom: 24px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        border: 1px solid #e5e7eb;
    }

    /* Section Title */
    .section-title {
        font-size: 18px;
        font-weight: 600;
        color: #1f2937;
        margin-bottom: 16px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .section-title i {
        color: #3b82f6;
    }

    /* Category Select */
    .category-select-wrapper {
        display: flex;
        gap: 12px;
    }

    .category-select-wrapper .form-select {
        flex: 1;
    }

    .btn-new-category {
        background: #10b981;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        font-weight: 500;
        white-space: nowrap;
        transition: all 0.2s;
    }

    .btn-new-category:hover {
        background: #059669;
        transform: translateY(-1px);
    }

    /* Paragraph Items */
    .paragraph-item {
        background: #f9fafb;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        transition: all 0.2s;
    }

    .paragraph-item:hover {
        border-color: #3b82f6;
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.1);
    }

    /* Paragraph Header */
    .paragraph-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 16px;
        padding-bottom: 12px;
        border-bottom: 2px solid #e5e7eb;
    }

    .paragraph-header span {
        font-size: 16px;
        font-weight: 600;
        color: #374151;
        display: flex;
        align-items: center;
    }

    .paragraph-header i.bi-file-earmark-text {
        color: #3b82f6;
    }

    .delete-paragraph {
        cursor: pointer;
        color: #ef4444;
        font-size: 18px;
        padding: 8px;
        border-radius: 6px;
        transition: all 0.2s;
    }

    .delete-paragraph:hover {
        background: #fee2e2;
        transform: scale(1.1);
    }

    /* Image Upload Wrapper */
    .image-upload-wrapper {
        border: 2px dashed #d1d5db;
        border-radius: 12px;
        padding: 40px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s;
        background: white;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 200px;
    }

    .image-upload-wrapper:hover {
        border-color: #3b82f6;
        background: #eff6ff;
    }

    .image-upload-text {
        color: #6b7280;
        font-size: 14px;
        margin-top: 12px;
    }

    /* Image Preview */
    .image-preview-container {
        text-align: center;
    }

    .image-preview {
        max-width: 100%;
        max-height: 400px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    /* Hidden File Input */
    input[type="file"] {
        display: none;
    }

    /* Add Paragraph Button */
    .btn-add-paragraph {
        width: 100%;
        padding: 16px;
        background: #3b82f6;
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        margin-top: 20px;
    }

    .btn-add-paragraph:hover {
        background: #2563eb;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
    }

    /* Form Controls */
    .form-control, .form-select {
        border: 2px solid #e5e7eb;
        border-radius: 8px;
        padding: 10px 14px;
        font-size: 14px;
        transition: all 0.2s;
    }

    .form-control:focus, .form-select:focus {
        border-color: #3b82f6;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }

    /* Form Labels */
    .form-label {
        font-weight: 600;
        color: #374151;
        margin-bottom: 8px;
        font-size: 14px;
    }

    /* CKEditor Container */
    .ck-editor__editable {
        min-height: 400px;
        border-radius: 8px;
    }

    /* Buttons */
    .btn-sm {
        font-size: 13px;
        padding: 6px 12px;
        border-radius: 6px;
        font-weight: 500;
    }

    /* Page Title */
    .page-title {
        font-size: 28px;
        font-weight: 700;
        color: #1f2937;
        margin: 0;
    }

    /* Header Section */
    .header-section {
        padding: 24px 0;
    }

    /* Responsive */
    @media (max-width: 768px) {
    .category-select-wrapper {
            flex-direction: column;
        }

    .btn-new-category {
            width: 100%;
        }

    .form-card {
            padding: 16px;
        }

    .paragraph-item {
            padding: 16px;
        }

    .image-upload-wrapper {
            padding: 30px 20px;
            min-height: 150px;
        }
    }
</style>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý cẩm nang</h1>
                </div>
            </div>
        </div>
    </div>
    <hr>

    <div class="container mb-3">
        <form id="blogForm">
            <!-- Tiêu đề bài viết -->
            <div class="form-card">
                <div class="section-title">
                    <i class="bi bi-type"></i>Tiêu đề bài viết
                </div>
                <input type="text" class="form-control" id="postTitle"
                       placeholder="Nhập tiêu đề hấp dẫn cho bài viết..." required />
            </div>

            <!-- Danh mục -->
            <div class="form-card">
                <div class="section-title">
                    <i class="bi bi-tags"></i>Danh mục bài viết
                </div>
                <div class="category-select-wrapper">
                    <select class="form-select" id="categorySelect" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach items="${categoryOfHB}" var="cate">
                            <option value="${cate.id}">${cate.name}</option>
                        </c:forEach>
                    </select>
                    <button type="button" class="btn btn-new-category" id="newCategoryBtn">
                        <i class="bi bi-plus-lg me-1"></i>Tạo mới
                    </button>
                </div>
            </div>

            <!-- Các đoạn bài viết -->
            <div class="form-card">
                <div class="section-title">
                    <i class="bi bi-file-text"></i>Nội dung bài viết (chia từng đoạn)
                </div>
                <div id="paragraphsContainer">
                    <c:forEach var="entry" items="${paragraphs}" varStatus="counter">
                        <div class="paragraph-item" data-paragraph-id="${counter.index + 1}">
                            <div class="paragraph-header">
                                <span>
                                    <i class="bi bi-file-earmark-text me-2"></i>
                                    Đoạn ${counter.index + 1}
                                </span>
                                <i class="bi bi-x-lg delete-paragraph" data-paragraph-id="${counter.index + 1}"></i>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Tiêu đề đoạn ${counter.index + 1} (tùy chọn)</label>
                                <input type="text" class="form-control paragraph-title"
                                       value="${entry.title}"
                                       placeholder="Nhập tiêu đề cho đoạn này..." />
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Nội dung</label>
                                <textarea class="form-control editor-${counter.index + 1}"
                                          id="editor-${counter.index + 1}">${entry.description}</textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Hình ảnh (tùy chọn)</label>

                                <div class="image-upload-wrapper" id="uploadWrapper-${counter.index + 1}">
                                    <i class="bi bi-image fs-1 text-secondary"></i>
                                    <div class="image-upload-text">
                                        Nhấn để chọn hình ảnh cho đoạn này
                                    </div>
                                </div>

                                <input type="file" id="fileInput-${counter.index + 1}" accept="image/*" />

                                <div id="imagePreview-${counter.index + 1}"
                                     class="image-preview-container"
                                     style="display: none;">
                                    <img id="previewImg-${counter.index + 1}" class="image-preview" />

                                    <div class="mt-2">
                                        <button type="button"
                                                class="btn btn-sm btn-primary change-image-btn me-2"
                                                data-input-id="fileInput-${counter.index + 1}">
                                            <i class="bi bi-arrow-repeat me-1"></i>Thay đổi hình
                                        </button>

                                        <button type="button"
                                                class="btn btn-sm btn-danger delete-image-btn"
                                                data-paragraph-id="${counter.index + 1}">
                                            <i class="bi bi-trash me-1"></i>Xóa hình
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Nút Submit -->
            <div class="text-end">
                <button type="button" class="btn btn-secondary me-2">
                    <i class="bi bi-x-circle me-1"></i>Hủy
                </button>
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-check-circle me-1"></i>Lưu bài viết
                </button>
            </div>
        </form>
    </div>
</main>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/40.2.0/classic/ckeditor.js"></script>
<%--<script src="${pageContext.request.contextPath}/adminPages/js/new-handbook.js"></script>--%>
<script>
    // ============================================
    // FILE: /adminPages/js/new-handbook.js
    // Quản lý CKEditor và các chức năng thêm/xóa đoạn, hình ảnh
    // ============================================

    // Biến toàn cục
    let paragraphCount = 0;
    let editorInstances = {};

    // Khởi tạo khi trang load
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Initializing handbook editor...');

        // Khởi tạo CKEditor cho các đoạn đã có
        initializeExistingEditors();

        // Thêm nút "Thêm đoạn mới"
        addNewParagraphButton();

        // Xử lý upload hình cho các đoạn có sẵn
        initializeImageUploadHandlers();

        // Xử lý nút tạo danh mục mới
        handleNewCategoryButton();

        // Xử lý nút xóa cho các đoạn có sẵn
        initializeDeleteButtons();
    });

    // Khởi tạo CKEditor cho các đoạn đã có từ server
    function initializeExistingEditors() {
        const existingEditors = document.querySelectorAll('[id^="editor-"]');

        existingEditors.forEach(function(editorElement) {
            const editorId = editorElement.id;
            const paragraphId = editorId.split('-')[1];
            paragraphCount = Math.max(paragraphCount, parseInt(paragraphId));

            ClassicEditor
                .create(editorElement, getEditorConfig())
                .then(function(editor) {
                    editorInstances[paragraphId] = editor;
                    editor.editing.view.change(function(writer) {
                        writer.setStyle('min-height', '400px', editor.editing.view.document.getRoot());
                    });
                })
                .catch(function(error) {
                    console.error('Error initializing CKEditor:', error);
                });
        });
    }

    // Cấu hình CKEditor
    function getEditorConfig() {
        return {
            toolbar: [
                'heading', '|',
                'bold', 'italic', 'underline', 'strikethrough', '|',
                'link', 'bulletedList', 'numberedList', '|',
                'indent', 'outdent', '|',
                'blockQuote', 'insertTable', '|',
                'undo', 'redo'
            ],
            heading: {
                options: [
                    { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
                    { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
                    { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' }
                ]
            }
        };
    }

    // Thêm nút "Thêm đoạn mới"
    function addNewParagraphButton() {
        const container = document.getElementById('paragraphsContainer');
        if (!container) return;

        const addButton = document.createElement('button');
        addButton.type = 'button';
        addButton.className = 'btn btn-add-paragraph';
        addButton.id = 'addParagraphBtn';
        addButton.innerHTML = '<i class="bi bi-plus-circle me-2"></i>Thêm đoạn mới';

        addButton.addEventListener('click', addNewParagraph);
        container.parentElement.appendChild(addButton);
    }

    // Thêm đoạn mới
    function addNewParagraph() {
        paragraphCount++;
        const container = document.getElementById('paragraphsContainer');

        const paragraphDiv = document.createElement('div');
        paragraphDiv.className = 'paragraph-item';
        paragraphDiv.setAttribute('data-paragraph-id', paragraphCount);

        paragraphDiv.innerHTML = `
        <div class="paragraph-header">
            <span>
                <i class="bi bi-file-earmark-text me-2"></i>
                Đoạn ${paragraphCount}
            </span>
            <i class="bi bi-x-lg delete-paragraph" data-paragraph-id="${paragraphCount}"></i>
        </div>

        <div class="mb-4">
            <label class="form-label">Tiêu đề đoạn ${paragraphCount} (tùy chọn)</label>
            <input type="text" class="form-control paragraph-title"
                   placeholder="Nhập tiêu đề cho đoạn này..." />
        </div>

        <div class="mb-4">
            <label class="form-label">Nội dung</label>
            <textarea class="form-control editor-${paragraphCount}"
                      id="editor-${paragraphCount}"></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Hình ảnh (tùy chọn)</label>

            <div class="image-upload-wrapper" id="uploadWrapper-${paragraphCount}">
                <i class="bi bi-image fs-1 text-secondary"></i>
                <div class="image-upload-text">
                    Nhấn để chọn hình ảnh cho đoạn này
                </div>
            </div>

            <input type="file" id="fileInput-${paragraphCount}" accept="image/*" style="display: none;" />

            <div id="imagePreview-${paragraphCount}"
                 class="image-preview-container"
                 style="display: none;">
                <img id="previewImg-${paragraphCount}" class="image-preview" />

                <div class="mt-2">
                    <button type="button"
                            class="btn btn-sm btn-primary change-image-btn me-2"
                            data-input-id="fileInput-${paragraphCount}">
                        <i class="bi bi-arrow-repeat me-1"></i>Thay đổi hình
                    </button>

                    <button type="button"
                            class="btn btn-sm btn-danger delete-image-btn"
                            data-paragraph-id="${paragraphCount}">
                        <i class="bi bi-trash me-1"></i>Xóa hình
                    </button>
                </div>
            </div>
        </div>
    `;

        container.appendChild(paragraphDiv);

        // Khởi tạo CKEditor cho đoạn mới
        ClassicEditor
            .create(document.getElementById('editor-' + paragraphCount), getEditorConfig())
            .then(function(editor) {
                editorInstances[paragraphCount] = editor;
                editor.editing.view.change(function(writer) {
                    writer.setStyle('min-height', '400px', editor.editing.view.document.getRoot());
                });
            })
            .catch(function(error) {
                console.error('Error initializing CKEditor:', error);
            });

        // Khởi tạo xử lý upload hình cho đoạn mới
        initializeImageUploadForParagraph(paragraphCount);

        // Xử lý nút xóa đoạn
        const deleteBtn = paragraphDiv.querySelector('.delete-paragraph');
        deleteBtn.addEventListener('click', function() {
            deleteParagraph(paragraphCount);
        });
    }

    // Xóa đoạn
    function deleteParagraph(paragraphId) {
        if (confirm('Bạn có chắc chắn muốn xóa đoạn này?')) {
            // Hủy CKEditor instance
            if (editorInstances[paragraphId]) {
                editorInstances[paragraphId].destroy()
                    .then(() => {
                        delete editorInstances[paragraphId];
                    })
                    .catch(error => console.error(error));
            }

            // Xóa element
            const paragraphDiv = document.querySelector(`[data-paragraph-id="${paragraphId}"]`);
            if (paragraphDiv) {
                paragraphDiv.remove();
            }

            // Cập nhật lại số thứ tự các đoạn
            updateParagraphNumbers();
        }
    }

    // Cập nhật lại số thứ tự đoạn
    function updateParagraphNumbers() {
        const paragraphs = document.querySelectorAll('.paragraph-item');
        paragraphs.forEach((para, index) => {
            const newNumber = index + 1;
            const header = para.querySelector('.paragraph-header span');
            if (header) {
                header.innerHTML = `<i class="bi bi-file-earmark-text me-2"></i>Đoạn ${newNumber}`;
            }
            const titleLabel = para.querySelector('.form-label');
            if (titleLabel) {
                titleLabel.textContent = `Tiêu đề đoạn ${newNumber} (tùy chọn)`;
            }
        });
    }

    // Khởi tạo xử lý upload hình cho tất cả đoạn có sẵn
    function initializeImageUploadHandlers() {
        const uploadWrappers = document.querySelectorAll('[id^="uploadWrapper-"]');

        uploadWrappers.forEach(function(wrapper) {
            const paragraphId = wrapper.id.split('-')[1];
            initializeImageUploadForParagraph(paragraphId);
        });
    }

    // Khởi tạo xử lý upload hình cho một đoạn cụ thể
    function initializeImageUploadForParagraph(paragraphId) {
        const uploadWrapper = document.getElementById(`uploadWrapper-${paragraphId}`);
        const fileInput = document.getElementById(`fileInput-${paragraphId}`);
        const imagePreview = document.getElementById(`imagePreview-${paragraphId}`);
        const previewImg = document.getElementById(`previewImg-${paragraphId}`);

        if (!uploadWrapper || !fileInput) return;

        // Click vào wrapper để mở file dialog
        uploadWrapper.addEventListener('click', function() {
            fileInput.click();
        });

        // Xử lý khi chọn file
        fileInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file && file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    previewImg.src = event.target.result;
                    uploadWrapper.style.display = 'none';
                    imagePreview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            }
        });

        // Xử lý nút "Thay đổi hình"
        const changeBtn = document.querySelector(`[data-input-id="fileInput-${paragraphId}"]`);
        if (changeBtn) {
            changeBtn.addEventListener('click', function(e) {
                e.preventDefault();
                fileInput.click();
            });
        }

        // Xử lý nút "Xóa hình"
        const deleteBtn = document.querySelector(`.delete-image-btn[data-paragraph-id="${paragraphId}"]`);
        if (deleteBtn) {
            deleteBtn.addEventListener('click', function(e) {
                e.preventDefault();
                if (confirm('Bạn có chắc chắn muốn xóa hình ảnh này?')) {
                    fileInput.value = '';
                    previewImg.src = '';
                    imagePreview.style.display = 'none';
                    uploadWrapper.style.display = 'flex';
                }
            });
        }
    }

    // Xử lý nút tạo danh mục mới
    function handleNewCategoryButton() {
        const newCategoryBtn = document.getElementById('newCategoryBtn');
        if (newCategoryBtn) {
            newCategoryBtn.addEventListener('click', function() {
                const categoryName = prompt('Nhập tên danh mục mới:');
                if (categoryName && categoryName.trim()) {
                    // TODO: Gọi API để tạo danh mục mới
                    // Sau khi tạo thành công, thêm option mới vào select
                    addCategoryOption(categoryName.trim());
                }
            });
        }
    }

    // Thêm option mới vào select danh mục
    function addCategoryOption(categoryName, categoryId) {
        const select = document.getElementById('categorySelect');
        if (select) {
            const option = document.createElement('option');
            option.value = categoryId || 'new-' + Date.now();
            option.textContent = categoryName;
            option.selected = true;
            select.appendChild(option);
        }
    }

    // Lấy dữ liệu form để submit
    function getFormData() {
        const formData = {
            title: document.getElementById('postTitle').value,
            category: document.getElementById('categorySelect').value,
            paragraphs: []
        };

        const paragraphs = document.querySelectorAll('.paragraph-item');
        paragraphs.forEach(function(para) {
            const paragraphId = para.getAttribute('data-paragraph-id');
            const title = para.querySelector('.paragraph-title').value;
            const content = editorInstances[paragraphId] ? editorInstances[paragraphId].getData() : '';
            const fileInput = para.querySelector('input[type="file"]');
            const image = fileInput && fileInput.files[0] ? fileInput.files[0] : null;

            formData.paragraphs.push({
                title: title,
                content: content,
                image: image
            });
        });

        return formData;
    }

    // Xử lý submit form
    document.getElementById('blogForm')?.addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = getFormData();

        // Validate
        if (!formData.title.trim()) {
            alert('Vui lòng nhập tiêu đề bài viết');
            return;
        }

        if (!formData.category) {
            alert('Vui lòng chọn danh mục');
            return;
        }

        if (formData.paragraphs.length === 0) {
            alert('Vui lòng thêm ít nhất một đoạn nội dung');
            return;
        }

        console.log('Form data:', formData);
        // TODO: Gửi dữ liệu lên server
    });
</script>
</body>
</html>