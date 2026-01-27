// Biến global
let paragraphCount = 0;
let editorInstances = [];

// Thêm đoạn mới
function addParagraph() {
    paragraphCount++;
    const container = document.getElementById('paragraphsContainer');
    const paragraphDiv = document.createElement('div');
    paragraphDiv.className = 'paragraph-card';
    paragraphDiv.setAttribute('data-index', paragraphCount);
    paragraphDiv.setAttribute('data-editor-id', 'editor-' + paragraphCount);

    paragraphDiv.innerHTML =
        '<div class="paragraph-header">' +
        '<span><i class="bi bi-file-earmark-text me-2"></i>Đoạn ' + paragraphCount + '</span>' +
        '<i class="bi bi-x-lg delete-paragraph"></i>' +
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
        '<button type="button" class="btn btn-sm btn-outline-secondary change-image-btn me-2" data-input-id="fileInput-' + paragraphCount + '">' +
        '<i class="bi bi-arrow-repeat me-1"></i> Thay đổi hình' +
        '</button>' +
        '<button type="button" class="btn btn-sm btn-danger delete-image-btn" data-paragraph-id="' + paragraphCount + '">' +
        '<i class="bi bi-trash me-1"></i> Xóa hình' +
        '</button>' +
        '</div>' +
        '</div>' +
        '</div>';

    container.appendChild(paragraphDiv);

    document.getElementById('uploadWrapper-' + paragraphCount).addEventListener('click', function () {
        const inputId = this.id.replace('uploadWrapper-', 'fileInput-');
        document.getElementById(inputId).click();
    });

    document.getElementById('fileInput-' + paragraphCount).addEventListener('change', function () {
        handleImageUpload(this);
    });

    paragraphDiv.querySelector('.delete-paragraph').addEventListener('click', function () {
        deleteParagraph(this);
    });

    paragraphDiv.querySelector('.change-image-btn').addEventListener('click', function () {
        const inputId = this.getAttribute('data-input-id');
        document.getElementById(inputId).click();
    });

    paragraphDiv.querySelector('.delete-image-btn').addEventListener('click', function() {
        deleteImage(this);
    });

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
            paragraphDiv.setAttribute('data-editor-index', paragraphCount);
            editor.editing.view.change(function (writer) {
                writer.setStyle('min-height', '400px', editor.editing.view.document.getRoot());
            });
        })
        .catch(function (error) {
            showAlert('Error initializing CKEditor:' + error, "danger");
        });
}

function deleteParagraph(element) {
    showConfirmModal('Bạn có chắc muốn xóa đoạn này?', function () {
        var card = element.closest('.paragraph-card');
        var editorIndex = card.getAttribute('data-editor-index');

        if (editorIndex && editorInstances[editorIndex]) {
            editorInstances[editorIndex].destroy();
            delete editorInstances[editorIndex];
        }

        card.remove();
        updateParagraphNumbers();
    });
}

function deleteImage(element) {
    showConfirmModal('Bạn có chắc muốn xóa hình ảnh này?', function () {
        var paragraphId = element.getAttribute('data-paragraph-id');

        var fileInput = document.getElementById('fileInput-' + paragraphId);
        fileInput.value = '';

        document.getElementById('imagePreview-' + paragraphId).style.display = 'none';
        document.getElementById('uploadWrapper-' + paragraphId).style.display = 'block';

        document.getElementById('previewImg-' + paragraphId).src = '';
    });
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
    paragraphCount = paragraphs.length;
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
    const modal = new bootstrap.Modal(document.getElementById('newCategoryModal'));
    const input = document.getElementById('newCategoryInput');
    input.value = '';

    document.getElementById('confirmNewCategoryBtn').onclick = function() {
        const categoryName = input.value.trim();
        if (!categoryName) {
            const alert = document.getElementById('newCategoryAlert');
            alert.textContent = 'Vui lòng nhập tên danh mục!';
            alert.classList.remove('d-none');
            setTimeout(() => alert.classList.add('d-none'), 3000);
            return;
        }

        let categoryId = 0;

        fetch(contextPath + "/admin/category-handbooks", {
            method: "post",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({categoryName: categoryName})
        })
            .then(response => response.ok ? response.json() : response.text().then(text => {throw new Error(text)}))
            .then(data => {
                if (data.success) {
                    categoryId = data.id;
                    addCategoryOption(categoryName, categoryId);
                    modal.hide();
                    showAlert('Đã tạo danh mục mới: ' + categoryName, 'success');
                } else {
                    const alert = document.getElementById('newCategoryAlert');
                    alert.textContent = data.message;
                    alert.classList.remove('d-none');
                    setTimeout(() => alert.classList.add('d-none'), 3000);
                }
            })
            .catch(error => {
                const alert = document.getElementById('newCategoryAlert');
                alert.textContent = error.message;
                alert.classList.remove('d-none');
                setTimeout(() => alert.classList.add('d-none'), 3000);
            });
    };

    modal.show();
}

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

// Submit form
function submitPost() {
    const form = document.getElementById("blogForm");
    const title = document.getElementById('postTitle').value.trim();
    const category = document.getElementById('categorySelect').value;

    if (!title) {
        showAlert('Vui lòng nhập tiêu đề bài viết!', "danger");
        form.reportValidity();
        return;
    }

    let paragraphs = [];
    const paragraphCards = document.querySelectorAll('.paragraph-card');

    let promises = [];

    for (let i = 0; i < paragraphCards.length; i++) {
        (function (idx) {
            const card = paragraphCards[idx];
            const dataIndex = card.getAttribute('data-index');
            const paragraphTitle = card.querySelector('.paragraph-title').value.trim();

            let content = '';
            if (editorInstances[dataIndex]) {
                content = editorInstances[dataIndex].getData();
            }

            const fileInput = card.querySelector('input[type="file"]');

            if (fileInput.files[0]) {
                const promise = fileToBase64(fileInput.files[0]).then(function (imageBase64) {
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
            showAlert('Vui lòng thêm ít nhất một đoạn nội dung!', "danger");
            return;
        }

        const postData = {
            title: title,
            category: category,
            paragraphs: paragraphs,
            createdAt: new Date().toISOString()
        };

        fetch(form.action, {
            method: form.method,
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
                    showAlert(result.message || 'Đăng bài thành công!', "success");
                    setTimeout(() => {
                        window.location.href = contextPath + '/admin/handbooks';
                    }, 2000);
                } else {
                    showAlert('Lỗi: ' + result.message, "danger");
                }
            })
            .catch(function (error) {
                showAlert('Có lỗi xảy ra khi đăng bài: ' + error , "danger");
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

function cancel() {
    showConfirmModal("Bạn có chắc muốn hủy? Dữ liệu sẽ không được lưu.", function () {
        window.location.href = contextPath + '/admin/handbooks';
    });
}

function showConfirmModal(message, callback) {
    const modalEl = document.getElementById('confirmModal');
    const modal = new bootstrap.Modal(modalEl);
    const confirmBtn = document.getElementById('confirmBtn');
    document.getElementById('confirmMessage').textContent = message;

    const newConfirmBtn = confirmBtn.cloneNode(true);
    confirmBtn.parentNode.replaceChild(newConfirmBtn, confirmBtn);

    newConfirmBtn.addEventListener('click', function () {
        modal.hide();
        if (typeof callback === 'function') callback();
    }, { once: true });

    modal.show();
}

function showAlert(message, type = 'danger') {
    const alert = document.getElementById('alert');
    alert.textContent = message;
    alert.className = `alert alert-${type} text-center`;
    alert.classList.remove('d-none');
    window.scrollTo({ top: 0, behavior: 'smooth' });
    setTimeout(() => alert.classList.add('d-none'), 3000);
}

// Khởi tạo khi DOM loaded
document.addEventListener('DOMContentLoaded', function () {
    addParagraph();
});