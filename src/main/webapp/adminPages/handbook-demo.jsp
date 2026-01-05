<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản trị - Đăng Bài Viết Mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
    <script src="https://cdn.ckeditor.com/ckeditor5/40.2.0/classic/ckeditor.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header h1 {
            font-size: 28px;
            font-weight: 600;
            margin: 0;
        }

        .header-buttons .btn {
            margin-left: 10px;
            padding: 10px 20px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .btn-add {
            background-color: white;
            color: #667eea;
            border: 2px solid white;
        }

        .btn-add:hover {
            background-color: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .btn-cancel {
            background-color: transparent;
            color: white;
            border: 2px solid white;
        }

        .btn-cancel:hover {
            background-color: rgba(255,255,255,0.1);
        }

        .btn-submit {
            background-color: #10b981;
            color: white;
            border: 2px solid #10b981;
        }

        .btn-submit:hover {
            background-color: #059669;
            border-color: #059669;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(16,185,129,0.3);
        }

        .main-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .form-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            color: #667eea;
        }

        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            padding: 12px 15px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }

        .paragraph-card {
            background: #f9fafb;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            position: relative;
        }

        .paragraph-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 600;
        }

        .delete-paragraph {
            cursor: pointer;
            transition: all 0.3s;
            color: white;
            opacity: 0.8;
        }

        .delete-paragraph:hover {
            opacity: 1;
            transform: scale(1.2);
        }

        .image-upload-wrapper {
            border: 2px dashed #cbd5e1;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
        }

        .image-upload-wrapper:hover {
            border-color: #667eea;
            background-color: #f8f9fa;
        }

        .image-preview-container {
            margin-top: 15px;
            text-align: center;
        }

        .image-preview {
            max-width: 100%;
            max-height: 400px;
            border-radius: 8px;
            display: block;
            margin: 0 auto;
        }

        .change-image-btn {
            margin-top: 10px;
        }

        .ck-editor__editable {
            min-height: 400px !important;
            font-size: 16px !important;
            line-height: 1.8 !important;
        }

        .category-select-wrapper {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .category-select-wrapper .form-select {
            flex: 1;
        }

        .btn-new-category {
            white-space: nowrap;
            background-color: #667eea;
            color: white;
            border: none;
        }

        .btn-new-category:hover {
            background-color: #5568d3;
        }

        .image-upload-text {
            color: #6b7280;
            margin-top: 10px;
            font-size: 14px;
        }

        input[type="file"] {
            display: none;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <h1><i class="bi bi-pencil-square me-2"></i>Đăng Bài Viết Mới</h1>
            <div class="header-buttons">
                <button type="button" class="btn btn-add" id="addParagraphBtn">
                    <i class="bi bi-plus-square me-2"></i>Thêm Đoạn Mới
                </button>
                <button type="button" class="btn btn-cancel" id="cancelBtn">
                    <i class="bi bi-x-circle me-2"></i>Hủy
                </button>
                <button type="button" class="btn btn-submit" id="submitBtn">
                    <i class="bi bi-send me-2"></i>Đăng Bài
                </button>
            </div>
        </div>
    </div>
</div>

<div class="main-container">
    <form id="blogForm">
        <!-- Tiêu đề bài viết -->
        <div class="form-card">
            <div class="section-title">
                <i class="bi bi-type"></i>Tiêu đề bài viết
            </div>
            <input type="text" class="form-control" id="postTitle" placeholder="Nhập tiêu đề hấp dẫn cho bài viết..." required />
        </div>

        <!-- Danh mục -->
        <div class="form-card">
            <div class="section-title">
                <i class="bi bi-tags"></i>Danh mục bài viết
            </div>
            <div class="category-select-wrapper">
                <select class="form-select" id="categorySelect" required>
                    <option value="">-- Chọn danh mục --</option>
                    <option value="day-con-thong-minh">Dạy con thông minh</option>
                    <option value="choi-cung-con">Chơi cùng con</option>
                    <option value="dinh-duong">Dinh dưỡng</option>
                    <option value="suc-khoe">Sức khỏe</option>
                    <option value="ky-nang-song">Kỹ năng sống</option>
                    <option value="tam-ly-tre">Tâm lý trẻ</option>
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
            <div id="paragraphsContainer"></div>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
    // Biến global
    var paragraphCount = 0;
    var editorInstances = [];

    // Thêm đoạn mới
    function addParagraph() {
        paragraphCount++;
        var container = document.getElementById('paragraphsContainer');
        var paragraphDiv = document.createElement('div');
        paragraphDiv.className = 'paragraph-card';
        paragraphDiv.setAttribute('data-index', paragraphCount);

        paragraphDiv.innerHTML =
            '<div class="paragraph-header">' +
            '<span><i class="bi bi-file-earmark-text me-2"></i>Đoạn ' + paragraphCount + '</span>' +
            '<i class="bi bi-x-lg delete-paragraph" data-paragraph-id="' + paragraphCount + '"></i>' +
            '</div>' +

            '<div class="mb-4">' +
            '<label class="form-label">Tiêu đề đoạn ' + paragraphCount + ' (tùy chọn)</label>' +
            '<input type="text" class="form-control paragraph-title" placeholder="Nhập tiêu đề cho đoạn này..." />' +
            '</div>' +

            '<div class="mb-4">' +
            '<label class="form-label">Nội dung</label>' +
            '<textarea class="form-control editor-' + paragraphCount + '" id="editor-' + paragraphCount + '"></textarea>' +
            '</div>' +

            '<div class="mb-3">' +
            '<label class="form-label">Hình ảnh (tùy chọn)</label>' +
            '<div class="image-upload-wrapper" id="uploadWrapper-' + paragraphCount + '">' +
            '<i class="bi bi-image fs-1 text-secondary"></i>' +
            '<div class="image-upload-text">Nhấn để chọn hình ảnh cho đoạn này</div>' +
            '</div>' +
            '<input type="file" id="fileInput-' + paragraphCount + '" accept="image/*" />' +
            '<div id="imagePreview-' + paragraphCount + '" class="image-preview-container" style="display: none;">' +
            '<img id="previewImg-' + paragraphCount + '" class="image-preview" />' +
            '<button type="button" class="btn btn-sm btn-primary change-image-btn" data-input-id="fileInput-' + paragraphCount + '">' +
            '<i class="bi bi-arrow-repeat me-1"></i>Thay đổi hình' +
            '</button>' +
            '</div>' +
            '</div>';

        container.appendChild(paragraphDiv);

        // Gắn event cho upload wrapper
        document.getElementById('uploadWrapper-' + paragraphCount).addEventListener('click', function() {
            var inputId = this.id.replace('uploadWrapper-', 'fileInput-');
            document.getElementById(inputId).click();
        });

        // Gắn event cho file input
        document.getElementById('fileInput-' + paragraphCount).addEventListener('change', function() {
            handleImageUpload(this);
        });

        // Gắn event cho nút delete
        paragraphDiv.querySelector('.delete-paragraph').addEventListener('click', function() {
            deleteParagraph(this);
        });

        // Gắn event cho nút thay đổi hình
        paragraphDiv.querySelector('.change-image-btn').addEventListener('click', function() {
            var inputId = this.getAttribute('data-input-id');
            document.getElementById(inputId).click();
        });

        // Khởi tạo CKEditor cho đoạn mới
        ClassicEditor
            .create(document.getElementById('editor-' + paragraphCount), {
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
            })
            .then(function(editor) {
                editorInstances[paragraphCount] = editor;
                editor.editing.view.change(function(writer) {
                    writer.setStyle('min-height', '400px', editor.editing.view.document.getRoot());
                });
            })
            .catch(function(error) {
                console.error('Error initializing CKEditor:', error);
            });
    }

    // Xóa đoạn
    function deleteParagraph(element) {
        if (confirm('Bạn có chắc muốn xóa đoạn này?')) {
            var card = element.closest('.paragraph-card');
            var index = card.getAttribute('data-index');

            // Xóa editor instance
            if (editorInstances[index]) {
                editorInstances[index].destroy();
                delete editorInstances[index];
            }

            card.remove();
            updateParagraphNumbers();
        }
    }

    // Cập nhật số thứ tự đoạn
    function updateParagraphNumbers() {
        var paragraphs = document.querySelectorAll('.paragraph-card');
        for (var i = 0; i < paragraphs.length; i++) {
            var num = i + 1;
            var p = paragraphs[i];
            p.querySelector('.paragraph-header span').innerHTML = '<i class="bi bi-file-earmark-text me-2"></i>Đoạn ' + num;
            p.querySelectorAll('.form-label')[0].textContent = 'Tiêu đề đoạn ' + num + ' (tùy chọn)';
        }
    }

    // Xử lý upload hình
    function handleImageUpload(input) {
        var file = input.files[0];
        if (file) {
            var inputId = input.id;
            var index = inputId.replace('fileInput-', '');

            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('previewImg-' + index).src = e.target.result;
                document.getElementById('imagePreview-' + index).style.display = 'block';
                document.getElementById('uploadWrapper-' + index).style.display = 'none';
            };
            reader.readAsDataURL(file);
        }
    }

    // Tạo danh mục mới
    function createNewCategory() {
        var categoryName = prompt('Nhập tên danh mục mới:');
        if (categoryName && categoryName.trim()) {
            var select = document.getElementById('categorySelect');
            var option = document.createElement('option');
            var slug = categoryName.toLowerCase()
                .normalize('NFD')
                .replace(/[\u0300-\u036f]/g, '')
                .replace(/[đĐ]/g, 'd')
                .replace(/[^a-z0-9\s-]/g, '')
                .replace(/\s+/g, '-');

            option.value = slug;
            option.textContent = categoryName.trim();
            option.selected = true;
            select.appendChild(option);

            alert('Đã tạo danh mục mới: ' + categoryName);
        }
    }

    // Submit form
    function submitPost() {
        var title = document.getElementById('postTitle').value.trim();
        var category = document.getElementById('categorySelect').value;

        if (!title) {
            alert('Vui lòng nhập tiêu đề bài viết!');
            return;
        }

        if (!category) {
            alert('Vui lòng chọn danh mục!');
            return;
        }

        var paragraphs = [];
        var paragraphCards = document.querySelectorAll('.paragraph-card');

        var promises = [];

        for (var i = 0; i < paragraphCards.length; i++) {
            (function(idx) {
                var card = paragraphCards[idx];
                var dataIndex = card.getAttribute('data-index');
                var paragraphTitle = card.querySelector('.paragraph-title').value.trim();

                var content = '';
                if (editorInstances[dataIndex]) {
                    content = editorInstances[dataIndex].getData();
                }

                var fileInput = card.querySelector('input[type="file"]');

                if (fileInput.files[0]) {
                    var promise = fileToBase64(fileInput.files[0]).then(function(imageBase64) {
                        paragraphs[idx] = {
                            index: idx + 1,
                            title: paragraphTitle,
                            content: content,
                            image: imageBase64
                        };
                    });
                    promises.push(promise);
                } else {
                    paragraphs[idx] = {
                        index: idx + 1,
                        title: paragraphTitle,
                        content: content,
                        image: null
                    };
                }
            })(i);
        }

        Promise.all(promises).then(function() {
            if (paragraphs.length === 0) {
                alert('Vui lòng thêm ít nhất một đoạn nội dung!');
                return;
            }

            var postData = {
                title: title,
                category: category,
                paragraphs: paragraphs,
                createdAt: new Date().toISOString()
            };

            console.log('Dữ liệu bài viết:', postData);

            // Gửi JSON qua AJAX
            fetch('/childrentoyweb_war/handbooks', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify(postData)
            })
                .then(function(response) {
                    return response.json();
                })
                .then(function(result) {
                    if (result.success) {
                        alert('Đăng bài thành công!');
                        window.location.href = '<%= request.getContextPath() %>/handbooks.jsp';
                    } else {
                        alert('Lỗi: ' + result.message);
                    }
                })
                .catch(function(error) {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi đăng bài.');
                });
        });
    }

    // Convert file to base64
    function fileToBase64(file) {
        return new Promise(function(resolve, reject) {
            var reader = new FileReader();
            reader.onload = function() {
                resolve(reader.result);
            };
            reader.onerror = function(error) {
                reject(error);
            };
            reader.readAsDataURL(file);
        });
    }

    // Khởi tạo khi DOM loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Thêm đoạn đầu tiên
        addParagraph();

        // Gắn events cho các nút
        document.getElementById('addParagraphBtn').addEventListener('click', function() {
            addParagraph();
        });

        document.getElementById('cancelBtn').addEventListener('click', function() {
            if (confirm('Bạn có chắc muốn hủy? Dữ liệu sẽ không được lưu.')) {
                window.location.href = '<%= request.getContextPath() %>/handbooks.jsp';
            }
        });

        document.getElementById('submitBtn').addEventListener('click', function() {
            submitPost();
        });

        document.getElementById('newCategoryBtn').addEventListener('click', function() {
            createNewCategory();
        });
    });
</script>
</body>
</html>