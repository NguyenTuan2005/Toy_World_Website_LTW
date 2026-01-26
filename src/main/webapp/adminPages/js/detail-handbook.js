function submitActive(form) {
    const formData = new FormData(form);
    const params = new URLSearchParams(formData);

    fetch(form.action, {
        method: form.method,
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params
    })
        .then(response => response.ok ? response.json() : response.text().then(text => { throw new Error(text || 'Đã xảy ra lỗi'); }))
        .then(data => {
            if (data.success) {
                showAlert(data.message || 'Đã cập nhật bài viết', "success");
                setTimeout(() => window.location.href = contextPath + '/admin/handbooks', 2000);
            } else {
                showAlert(data.message || 'Đã xảy ra lỗi:', "danger");
            }
        })
        .catch(error => showAlert(error.message || 'Đã xảy ra lỗi:', "danger"))
}

function showAlert(message, type = 'danger') {
    const alert = document.getElementById('alert');
    alert.textContent = message;
    alert.className = `alert alert-${type} text-center`;
    alert.classList.remove('d-none');
    window.scrollTo({ top: 0, behavior: 'smooth' });
    setTimeout(() => alert.classList.add('d-none'), 3000);
}