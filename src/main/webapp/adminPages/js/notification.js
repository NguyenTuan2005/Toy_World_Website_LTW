function showSuccessToast(message) {
    // Sử dụng Bootstrap Toast hoặc alert
    const toastHtml = `
        <div class="position-fixed top-0 end-0 p-3" style="z-index: 10000">
            <div class="toast show bg-success text-white" role="alert">
                <div class="toast-header bg-success text-white">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <strong class="me-auto">Success</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">
                    ${message}
                </div>
            </div>
        </div>
    `;
    document.body.insertAdjacentHTML('beforeend', toastHtml);

    // Auto remove sau 3 giây
    setTimeout(() => {
        document.querySelector('.toast').remove();
    }, 3000);
}
