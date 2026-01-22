document.getElementById('imageUploadAdd').addEventListener('change', function (e) {
    const preview = document.getElementById('previewAdd');
    preview.innerHTML = '';
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

function removeNewImg(wrapper, idx) {
    const input = document.getElementById('imageUploadAdd');
    const dt = new DataTransfer();

    Array.from(input.files).forEach((file, index) => {
        if (index !== idx) dt.items.add(file);
    });

    input.files = dt.files;
    wrapper.remove();
}

function addRowToTable(tableId) {
    const table = document.getElementById(tableId);
    const tbody = table.querySelector('tbody');

    const newRow = document.createElement('tr');
    newRow.innerHTML = `
        <td class="text-center">
            <input class="form-control key-input" placeholder="VD: Độ tuổi">
        </td>
        <td class="text-center">
            <input class="form-control value-input" placeholder="VD: 3-6 tuổi">
        </td>
        <td class="text-center">
            <button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">X</button>
        </td>
    `;

    tbody.appendChild(newRow);
}

function removeRow(button) {
    const row = button.closest('tr');
    row.remove();
}

function serializeTableData(tableId) {
    const table = document.getElementById(tableId);
    const rows = table.querySelectorAll('tbody tr');
    const data = {};

    rows.forEach(row => {
        const key = row.querySelector('.key-input').value.trim();
        const value = row.querySelector('.value-input').value.trim();

        if (key && value) {
            data[key] = value;
        }
    });

    return JSON.stringify(data);
}

function submitAddProduct() {
    const form = document.getElementById('addProductForm');
    const restInfo = serializeTableData('kvTableAdd');
    document.getElementById('restInfoAdd').value = restInfo;

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
                showAlert(data.message || 'Thêm sản phẩm thành công!', "success");
                setTimeout(() => window.location.href = contextPath + '/admin/products', 2000);
            } else {
                showAlert(data.message || 'Thêm sản phẩm thất bại!', "danger");
            }
        })
        .catch(error => showAlert(error.message || 'Đã xảy ra lỗi khi thêm sản phẩm!', "danger"))
        .finally(() => {
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalText;
        });
}

function showAlert(message, type = 'danger') {
    const alert = document.getElementById('alert');
    alert.textContent = message;
    alert.className = `alert alert-${type} text-center`;
    alert.classList.remove('d-none');
    window.scrollTo({ top: 0, behavior: 'smooth' });
    setTimeout(() => alert.classList.add('d-none'), 3000);
}