let pendingCommentToggle = null;
const modal = new bootstrap.Modal(document.getElementById('toggleCommentModal'));

function toggleComment(commentId, isActive) {
    pendingCommentToggle = commentId;

    document.getElementById('toggleCommentMessage').textContent = isActive
        ? 'Bạn có chắc muốn hiện bình luận này?'
        : 'Bạn có chắc muốn ẩn bình luận này?';

    modal.show();
}

function confirmSubmit() {
    if (!pendingCommentToggle) return;

    const commentId = pendingCommentToggle;

    fetch(contextPath + '/admin/hidden-comments', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            commentId: commentId,
            page: page
        })
    })
        .then(response => {
            if (response.ok) {
                return response.text();
            } else {
                return response.text().then(text => {
                    throw new Error(text || 'Đã xảy ra lỗi');
                });
            }
        })
        .then(html => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            const newTbody = doc.getElementById("commentTableBody");
            document.getElementById('commentTableBody').innerHTML = newTbody.innerHTML;

            const newPagination = doc.getElementById('commentPagination');
            document.getElementById('commentPagination').innerHTML = newPagination.innerHTML;

            const newPageInfo = doc.getElementById('pageInfo');
            document.getElementById('pageInfo').textContent = newPageInfo.textContent;

        })
        .catch(error => showAlert(error.message ||'Không thể kết nối đến server'))
        .finally(() => {
            modal.hide();
            pendingCommentToggle = null;
        });
}

function showAlert(message) {
    const alert = document.getElementById('alert');
    alert.textContent = message;
    alert.classList.remove('d-none');
    setTimeout(() => alert.classList.add('d-none'), 3000);
}