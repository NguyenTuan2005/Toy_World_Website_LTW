document.getElementById('imageUploadAdd').addEventListener('change', function (e) {
    const preview = document.getElementById('previewAdd');
    preview.innerHTML = '';
    const files = Array.from(e.target.files || []);

    if (!files.length) return;

    files.forEach((file, idx) => {
        if (!file.type.startsWith('image/')) return;

        const reader = new FileReader();
        const wrapper = document.createElement('div');
        wrapper.className = 'position-relative';
        wrapper.style.width = '120px';

        const removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.className = 'btn btn-sm bg-secondary-subtle fw-bold position-absolute';
        removeBtn.style.top = '1px';
        removeBtn.style.right = '1px';
        removeBtn.innerHTML = '×';
        removeBtn.addEventListener('click', () => {
            const input = document.getElementById('imageUploadAdd');
            const dt = new DataTransfer();
            Array.from(input.files).forEach((f, i) => { if (i !== idx) dt.items.add(f); });
            input.files = dt.files;
            wrapper.remove();
            input.dispatchEvent(new Event('change'));
        });

        const info = document.createElement('div');
        info.className = 'small text-truncate mt-1';
        info.style.maxWidth = '120px';
        info.textContent = file.name;

        reader.onload = function (ev) {
            const img = document.createElement('img');
            img.src = ev.target.result;
            img.style.width = '120px';
            img.style.height = '80px';
            img.style.objectFit = 'cover';
            img.style.borderRadius = '4px';
            wrapper.appendChild(img);
            wrapper.appendChild(removeBtn);
            wrapper.appendChild(info);
        };

        reader.readAsDataURL(file);
        preview.appendChild(wrapper);
    });
});

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

    const formData = new FormData(form);

    const submitBtn = document.getElementById("submitButton");
    const originalText = submitBtn.innerHTML;
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang xử lý...';

    fetch(form.action, {
        method: 'POST',
        body: formData
    })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => {
                    throw new Error(text || 'Đã xảy ra lỗi');
                });
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                const alert = document.getElementById('alert');
                alert.textContent = data.message || 'Thêm sản phẩm thành công!';
                alert.classList.remove('alert-danger');
                alert.classList.add('alert-success')
                alert.classList.remove('d-none');
                window.scrollTo({ top: 0, behavior: 'smooth' });
                setTimeout(() => {
                    alert.classList.add('d-none');
                    window.location.href = contextPath + '/admin/products';
                }, 2000);
            } else {
                showAlert(data.message || 'Thêm sản phẩm thất bại!');
            }
        })
        .catch(error => {
            showAlert(error.message || 'Đã xảy ra lỗi khi thêm sản phẩm!');
        })
        .finally(() => {
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalText;
        });
}

function submitUpdateProduct() {
    const form = document.getElementById('updateProductForm');

    const restInfo = serializeTableData('kvTableUpdate');
    document.getElementById('restInfoUpdate').value = restInfo;

    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    form.submit();
}

function showAlert(message) {
    const alert = document.getElementById('alert');
    alert.textContent = message;
    alert.classList.remove('d-none');
    setTimeout(() => alert.classList.add('d-none'), 3000);
}