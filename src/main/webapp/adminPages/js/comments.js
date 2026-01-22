function toggleComment(commentId, isActive) {
    if (!confirm(isActive ? 'Bạn có chắc muốn hiện bình luận này?' : 'Bạn có chắc muốn ẩn bình luận này?')) {
        return;
    }

    fetch(contextPath + '/admin/comments/toggle', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            commentId: commentId,
            isActive: isActive
        })
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                console.log("success")
            } else {
                alert(data.message || 'Có lỗi xảy ra');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Không thể kết nối đến server');
        });
}