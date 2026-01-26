
let paragraphCount = 0;
let editorInstances = {};

document.addEventListener('DOMContentLoaded', function() {
    initializeExistingEditors();
    initializeImageUploadHandlers();
});

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
                const paragraphDiv = editorElement.closest('.paragraph-item'); // Add this
                if (paragraphDiv) {
                    paragraphDiv.setAttribute('data-editor-index', paragraphId); // Add this
                }
                editor.editing.view.change(function(writer) {
                    writer.setStyle('min-height', '400px', editor.editing.view.document.getRoot());
                });
            })
            .catch(function(error) {
                console.error('Error initializing CKEditor:', error);
            });
    });
}
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

function addNewParagraph() {
    paragraphCount++;
    const container = document.getElementById('paragraphsContainer');

    const paragraphDiv = document.createElement('div');
    paragraphDiv.className = 'paragraph-item';
    paragraphDiv.setAttribute('data-paragraph-id', paragraphCount);
    paragraphDiv.setAttribute('data-editor-id', 'editor-' + paragraphCount);

    paragraphDiv.innerHTML = `
        <div class="paragraph-header p-2 hstack justify-content-between align-items-center rounded-top-2">
            <span class="text-white">
                Đoạn ${paragraphCount}
            </span>
            <button type="button" class="btn delete-paragraph" onclick="deleteParagraph(this)">
                <i class="bi bi-x-lg text-white"></i>
            </button>
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
                 class="image-preview-container d-none">
                <img id="previewImg-${paragraphCount}" class="image-preview" />

                <div class="mt-2">
                    <button type="button"
                            class="btn btn-sm btn-outline-secondary change-image-btn me-2"
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

    ClassicEditor
        .create(document.getElementById('editor-' + paragraphCount), getEditorConfig())
        .then(function(editor) {
            editorInstances[paragraphCount] = editor;
            paragraphDiv.setAttribute('data-editor-index', paragraphCount);
            editor.editing.view.change(function(writer) {
                writer.setStyle('min-height', '400px', editor.editing.view.document.getRoot());
            });
        })
        .catch(function(error) {
            console.error('Error initializing CKEditor:', error);
        });

    initializeImageUploadForParagraph(paragraphCount);
}

function deleteParagraph(element) {
    showConfirmModal('Bạn có chắc chắn muốn xóa đoạn này?', function () {
        const paragraphDiv = element.closest(".paragraph-item");
        const editorIndex = paragraphDiv.getAttribute('data-editor-index'); // Add this line

        if (editorIndex && editorInstances[editorIndex]) { // Change this
            editorInstances[editorIndex].destroy();
            delete editorInstances[editorIndex];
        }

        paragraphDiv.remove();
        updateParagraphNumbers();
    });
}

// Cập nhật lại số thứ tự đoạn
function updateParagraphNumbers() {
    const paragraphs = document.querySelectorAll('.paragraph-item');
    paragraphs.forEach((para, index) => {
        const newNumber = index + 1;
        const header = para.querySelector('.paragraph-header span');
        if (header) {
            header.innerHTML = `Đoạn ${newNumber}`;
        }

        const titleLabel = para.querySelector('.form-label');
        if (titleLabel) {
            titleLabel.textContent = `Tiêu đề đoạn ${newNumber} (tùy chọn)`;
        }
    });
    paragraphCount = paragraphs.length;
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
                uploadWrapper.classList.add("d-none");
                imagePreview.classList.remove("d-none");
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
            showConfirmModal('Bạn có chắc chắn muốn xóa hình ảnh này?', function ()  {
                fileInput.value = '';
                previewImg.src = '';
                imagePreview.classList.add("d-none");
                uploadWrapper.classList.remove("d-none");
            });
        });
    }
}

// Xử lý nút tạo danh mục mới
function newCategory() {
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

async function getFormData() {
    const formData = {
        id: document.getElementById("handbookId").value,
        title: document.getElementById('postTitle').value,
        category: document.getElementById('categorySelect').value,
        paragraphs: []
    };

    const paragraphs = document.querySelectorAll('.paragraph-item');

    for (let index = 0; index < paragraphs.length; index++) {
        const para = paragraphs[index];
        const paragraph = para.getAttribute('data-paragraph-id');
        const title = para.querySelector('.paragraph-title').value;
        const content = editorInstances[paragraph] ? editorInstances[paragraph].getData() : '';
        const fileInput = para.querySelector('input[type="file"]');
        const previewImg = document.getElementById(`previewImg-${paragraph}`);
        const paragraphIdInput = para.querySelector("#paragraphId");

        let imageBase64 = null;

        if (fileInput && fileInput.files[0]) {
            imageBase64 = await convertFileToBase64(fileInput.files[0]);
        } else if (previewImg && previewImg.src && !previewImg.src.startsWith('data:')) {
            imageBase64 = previewImg.src;
        }

        formData.paragraphs.push({
            paragraphId: paragraphIdInput?.value || null,
            index: index,
            title: title,
            content: content,
            image: imageBase64
        });
    }

    return formData;
}

function convertFileToBase64(file) {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => resolve(reader.result);
        reader.onerror = reject;
        reader.readAsDataURL(file);
    });
}

async function handleSubmit(e) {
    e.preventDefault();

    const formData = await getFormData();

    if (!formData.title.trim()) {
        showAlert('Vui lòng nhập tiêu đề bài viết', "danger");
        return;
    }

    if (!formData.category) {
        showAlert('Vui lòng chọn danh mục', "danger");
        return;
    }

    if (formData.paragraphs.length === 0) {
        showAlert('Vui lòng thêm ít nhất một đoạn nội dung', "danger");
        return;
    }

    fetch(contextPath + "/admin/edit-handbooks", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData)
    })
        .then(response => response.ok ? response.json(): response.text().then(text => {throw new Error(text)}))
        .then(data => {
            if (data.success) {
                showAlert(data.message || 'Sửa bài viết thành công!', "success");
                setTimeout(() => {
                    window.location.href = contextPath + '/admin/handbooks';
                }, 2000);
            } else {
                showAlert(data.message, "danger");
            }
        })
        .catch(error => showAlert(error.message, "danger"));
}

function cancel() {
    showConfirmModal("Bạn có chắc muốn hủy? Dữ liệu sẽ không được lưu.", function () {
        window.location.href = contextPath + '/admin/handbooks';
    });
}

let lastCallBack = () => {};
function showConfirmModal(message, callback) {
    const modalEl = document.getElementById('confirmModal');
    const modal = new bootstrap.Modal(modalEl);
    const confirmBtn = document.getElementById('confirmBtn');

    document.getElementById('confirmMessage').textContent = message;

    confirmBtn.removeEventListener('click', lastCallBack);
    confirmBtn.addEventListener('click', function () {
        modal.hide();
        if (typeof callback === 'function')  {
            lastCallBack = callback;
            callback();
        }
    });

    modal.show();
}

function showAlert(message, type = 'danger') {
    const alert = document.getElementById('alert');
    alert.textContent = message;
    alert.className = `alert alert-${type} text-center`;
    alert.classList.remove('d-none');
    window.scrollTo({ top: 0, behavior: 'smooth' });
    // setTimeout(() => alert.classList.add('d-none'), 3000);
}