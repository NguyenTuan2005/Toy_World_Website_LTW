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
        '<div class="mt-2">' +
        '<button type="button" class="btn btn-sm btn-primary change-image-btn me-2" data-input-id="fileInput-' + paragraphCount + '">' +
        '<i class="bi bi-arrow-repeat me-1"></i>Thay đổi hình' +
        '</button>' +
        '<button type="button" class="btn btn-sm btn-danger delete-image-btn" data-paragraph-id="' + paragraphCount + '">' +
        '<i class="bi bi-trash me-1"></i>Xóa hình' +
        '</button>' +
        '</div>' +
        '</div>' +
        '</div>';

    container.appendChild(paragraphDiv);

    // Gắn event cho upload wrapper
    document.getElementById('uploadWrapper-' + paragraphCount).addEventListener('click', function () {
        var inputId = this.id.replace('uploadWrapper-', 'fileInput-');
        document.getElementById(inputId).click();
    });

    // Gắn event cho file input
    document.getElementById('fileInput-' + paragraphCount).addEventListener('change', function () {
        handleImageUpload(this);
    });

    // Gắn event cho nút delete
    paragraphDiv.querySelector('.delete-paragraph').addEventListener('click', function () {
        deleteParagraph(this);
    });

    // Gắn event cho nút thay đổi hình
    paragraphDiv.querySelector('.change-image-btn').addEventListener('click', function () {
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
                    {model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph'},
                    {model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2'},
                    {model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3'}
                ]
            }
        })
        .then(function (editor) {
            editorInstances[paragraphCount] = editor;
            editor.editing.view.change(function (writer) {
                writer.setStyle('min-height', '400px', editor.editing.view.document.getRoot());
            });
        })
        .catch(function (error) {
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

// BUG A oi
// // Thêm event listener cho nút xóa ảnh (đặt sau phần gắn event cho nút thay đổi hình)
// paragraphDiv.querySelector('.delete-image-btn').addEventListener('click', function() {
//     deleteImage(this);
// });
//
// // Thêm function deleteImage mới
// function deleteImage(element) {
//     if (confirm('Bạn có chắc muốn xóa hình ảnh này?')) {
//         var paragraphId = element.getAttribute('data-paragraph-id');
//
//         // Reset file input
//         var fileInput = document.getElementById('fileInput-' + paragraphId);
//         fileInput.value = '';
//
//         // Ẩn preview và hiện lại upload wrapper
//         document.getElementById('imagePreview-' + paragraphId).style.display = 'none';
//         document.getElementById('uploadWrapper-' + paragraphId).style.display = 'block';
//
//         // Xóa src của image
//         document.getElementById('previewImg-' + paragraphId).src = '';
//     }
// }

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
        reader.onload = function (e) {
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
        (function (idx) {
            var card = paragraphCards[idx];
            var dataIndex = card.getAttribute('data-index');
            var paragraphTitle = card.querySelector('.paragraph-title').value.trim();

            var content = '';
            if (editorInstances[dataIndex]) {
                content = editorInstances[dataIndex].getData();
            }

            var fileInput = card.querySelector('input[type="file"]');

            if (fileInput.files[0]) {
                var promise = fileToBase64(fileInput.files[0]).then(function (imageBase64) {
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

    Promise.all(promises).then(function () {
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
            .then(function (response) {
                return response.json();
            })
            .then(function (result) {
                if (result.success) {
                    alert('Đăng bài thành công!');
                    window.location.href = '<%= request.getContextPath() %>/handbooks.jsp';
                } else {
                    alert('Lỗi: ' + result.message);
                }
            })
            .catch(function (error) {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi đăng bài.');
            });
    });
}

// Convert file to base64
function fileToBase64(file) {
    return new Promise(function (resolve, reject) {
        var reader = new FileReader();
        reader.onload = function () {
            resolve(reader.result);
        };
        reader.onerror = function (error) {
            reject(error);
        };
        reader.readAsDataURL(file);
    });
}

// Khởi tạo khi DOM loaded
document.addEventListener('DOMContentLoaded', function () {
    // Thêm đoạn đầu tiên
    addParagraph();

    // Gắn events cho các nút
    document.getElementById('addParagraphBtn').addEventListener('click', function () {
        addParagraph();
    });

    document.getElementById('cancelBtn').addEventListener('click', function () {
        if (confirm('Bạn có chắc muốn hủy? Dữ liệu sẽ không được lưu.')) {
            window.location.href = '<%= request.getContextPath() %>/handbooks.jsp';
        }
    });

    document.getElementById('submitBtn').addEventListener('click', function () {
        submitPost();
    });

    document.getElementById('newCategoryBtn').addEventListener('click', function () {
        createNewCategory();
    });
});