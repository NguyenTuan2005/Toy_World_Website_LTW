function toggleMenu(header) {
    // Kiểm tra nếu menu item không có children thì không làm gì
    if (header.classList.contains('no-children')) {
        return;
    }

    const submenu = header.nextElementSibling;
    
    // Toggle collapsed class
    header.classList.toggle('collapsed');
    submenu.classList.toggle('collapsed');
}

function handleClick(itemName) {
    console.log('Clicked:', itemName);
    // Thêm logic xử lý khi click vào menu item ở đây
    alert('Bạn đã chọn: ' + itemName);
}

// Đóng tất cả menu mặc định
document.addEventListener('DOMContentLoaded', function() {
    const allMenuHeaders = document.querySelectorAll('.menu-header:not(.no-children)');
    allMenuHeaders.forEach(header => {
        header.classList.add('collapsed');
        const submenu = header.nextElementSibling;
        if (submenu) {
            submenu.classList.add('collapsed');
        }
    });
});


// Toggle view buttons
document.querySelectorAll('.view-toggle button').forEach(btn => {
    btn.addEventListener('click', function() {
        document.querySelectorAll('.view-toggle button').forEach(b => b.classList.remove('active'));
        this.classList.add('active');
    });
});

// Category dropdown toggle
document.querySelectorAll('.category-item').forEach(item => {
    item.addEventListener('click', function() {
        this.style.background = '#f8f9fa';
        setTimeout(() => {
            this.style.background = '';
        }, 200);
    });
});

// Search functionality
document.querySelector('.search-box input').addEventListener('input', function(e) {
    console.log('Searching for:', e.target.value);
});
