document.getElementById('imageUploadEdit').addEventListener('change', function (e) {
    const preview = document.getElementById('previewEdit');
    const files = Array.from(e.target.files || []);

    if (!files.length) return;

    files.forEach((file, idx) => {
        if (!file.type.startsWith('image/')) return;

        const reader = new FileReader();
        reader.onload = function (ev) {
            const wrapper = document.createElement('div');
            wrapper.className = 'position-relative preview-wrapper';
            wrapper.style.width = '120px';

            const img = document.createElement('img');
            img.src = ev.target.result;
            img.style.cssText = 'width: 120px; height: 80px; object-fit: cover; border-radius: 4px';

            const removeBtn = document.createElement('button');
            removeBtn.type = 'button';
            removeBtn.className = 'btn btn-sm bg-secondary-subtle fw-bold position-absolute';
            removeBtn.style.cssText = 'top: 1px; right: 1px';
            removeBtn.innerHTML = '×';
            removeBtn.onclick = () => removeNewImg(wrapper, idx);

            wrapper.appendChild(img);
            wrapper.appendChild(removeBtn);
            preview.appendChild(wrapper);
        };

        reader.readAsDataURL(file);
    });
});

const deletedImageIds = new Set();

function removeExistingImg(button, assetId) {
    const wrapper = button.closest('.preview-wrapper');
    deletedImageIds.add(assetId);
    document.getElementById('deletedImages').value = Array.from(deletedImageIds).join(',');

    wrapper.style.transition = 'opacity 0.3s';
    wrapper.style.opacity = '0.5';
    setTimeout(() => wrapper.remove(), 300);
}

function removeNewImg(wrapper, idx) {
    const input = document.getElementById('imageUploadEdit');
    const dt = new DataTransfer();

    Array.from(input.files).forEach((file, index) => {
        if (index !== idx) dt.items.add(file);
    });

    input.files = dt.files;
    wrapper.remove();
}

function submitUpdateProduct() {
    const form = document.getElementById("editProductForm");
    const restInfo = serializeTableData('kvTableUpdate');
    document.getElementById('restInfoEdit').value = restInfo;

    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    const submitBtn = document.getElementById("submitButton");
    const originalText = submitBtn.innerHTML;
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang xử lý...';

    fetch(form.action, {
        method: 'POST',
        body: new FormData(form)
    })
        .then(response => response.ok ? response.json() : response.text().then(text => { throw new Error(text || 'Đã xảy ra lỗi'); }))
        .then(data => {
            if (data.success) {
                showAlert(data.message || 'Cập nhật sản phẩm thành công!', "success");
                setTimeout(() => window.location.href = contextPath + '/admin/products', 2000);
            } else {
                showAlert(data.message || 'Cập nhật sản phẩm thất bại!', "danger");
            }
        })
        .catch(error => showAlert(error.message || 'Đã xảy ra lỗi khi cập nhật sản phẩm!', "danger"))
        .finally(() => {
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalText;
        });
}