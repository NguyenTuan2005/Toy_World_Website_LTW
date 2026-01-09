<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Banner</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .dragging {
            opacity: 0.5;
            background-color: #e5e7eb;
        }
        .drag-over {
            border-top: 3px solid #3b82f6;
        }
    </style>
</head>
<body class="bg-gray-50">
<div class="container mx-auto px-4 py-8">
    <!-- Header -->
    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
        <div class="flex justify-between items-center">
            <h1 class="text-3xl font-bold text-gray-800">Quản Lý Banner</h1>
            <a href="banner?action=create" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 flex items-center gap-2">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                </svg>
                Tạo Banner Mới
            </a>
        </div>
    </div>

    <!-- Group Filter -->
    <div class="bg-white rounded-lg shadow-md p-4 mb-6">
        <div class="flex gap-2">
            <c:forEach var="tag" items="${groupTags}">
                <a href="banner?groupTag=${tag}"
                   class="px-4 py-2 rounded-lg ${param.groupTag == tag || (empty param.groupTag && tag == 'TRANG_CHU') ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'}">
                        ${tag}
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- Banner List -->
    <div class="bg-white rounded-lg shadow-md p-6">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-xl font-semibold text-gray-800">
                Danh sách Banner - ${empty param.groupTag ? 'TRANG_CHU' : param.groupTag}
            </h2>
            <button onclick="saveOrder()" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">
                <svg class="w-5 h-5 inline mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                </svg>
                Lưu Thứ Tự
            </button>
        </div>

        <div id="bannerList" class="space-y-3">
            <c:forEach var="banner" items="${banners}" varStatus="status">
                <div class="banner-item border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow"
                     draggable="true"
                     data-id="${banner.id}"
                     data-order="${banner.sort_order}">
                    <div class="flex items-center gap-4">
                        <!-- Drag Handle -->
                        <div class="drag-handle cursor-move text-gray-400 hover:text-gray-600">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8h16M4 16h16"/>
                            </svg>
                        </div>

                        <!-- Order Number -->
                        <div class="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center font-bold text-blue-600">
                                ${status.index + 1}
                        </div>

                        <!-- Image Preview -->
                        <img src="${banner.image_url}" alt="${banner.name}" class="w-24 h-16 object-cover rounded">

                        <!-- Banner Info -->
                        <div class="flex-1">
                            <h3 class="font-semibold text-gray-800">${banner.name}</h3>
                            <p class="text-sm text-gray-500">ID: ${banner.id} | Thứ tự: ${banner.sort_order}</p>
                        </div>

                        <!-- Status -->
                        <div>
                            <button onclick="toggleStatus(${banner.id}, ${banner.status})"
                                    class="px-3 py-1 rounded-full text-sm ${banner.status == 1 ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                    ${banner.status == 1 ? 'Hiển thị' : 'Ẩn'}
                            </button>
                        </div>

                        <!-- Actions -->
                        <div class="flex gap-2">
                            <a href="banner?action=edit&id=${banner.id}"
                               class="p-2 text-blue-600 hover:bg-blue-50 rounded">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                </svg>
                            </a>
                            <button onclick="deleteBanner(${banner.id})"
                                    class="p-2 text-red-600 hover:bg-red-50 rounded">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty banners}">
            <div class="text-center py-12 text-gray-500">
                <svg class="w-16 h-16 mx-auto mb-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"/>
                </svg>
                <p class="text-lg">Chưa có banner nào</p>
            </div>
        </c:if>
    </div>
</div>

<script>
    let draggedElement = null;

    // Drag and Drop functionality
    const bannerItems = document.querySelectorAll('.banner-item');

    bannerItems.forEach(item => {
        item.addEventListener('dragstart', handleDragStart);
        item.addEventListener('dragover', handleDragOver);
        item.addEventListener('drop', handleDrop);
        item.addEventListener('dragend', handleDragEnd);
        item.addEventListener('dragenter', handleDragEnter);
        item.addEventListener('dragleave', handleDragLeave);
    });

    function handleDragStart(e) {
        draggedElement = this;
        this.classList.add('dragging');
        e.dataTransfer.effectAllowed = 'move';
    }

    function handleDragOver(e) {
        if (e.preventDefault) {
            e.preventDefault();
        }
        e.dataTransfer.dropEffect = 'move';
        return false;
    }

    function handleDragEnter(e) {
        if (this !== draggedElement) {
            this.classList.add('drag-over');
        }
    }

    function handleDragLeave(e) {
        this.classList.remove('drag-over');
    }

    function handleDrop(e) {
        if (e.stopPropagation) {
            e.stopPropagation();
        }

        if (draggedElement !== this) {
            const allItems = [...document.querySelectorAll('.banner-item')];
            const draggedIndex = allItems.indexOf(draggedElement);
            const targetIndex = allItems.indexOf(this);

            if (draggedIndex < targetIndex) {
                this.parentNode.insertBefore(draggedElement, this.nextSibling);
            } else {
                this.parentNode.insertBefore(draggedElement, this);
            }

            updateOrderNumbers();
        }

        this.classList.remove('drag-over');
        return false;
    }

    function handleDragEnd(e) {
        this.classList.remove('dragging');
        document.querySelectorAll('.banner-item').forEach(item => {
            item.classList.remove('drag-over');
        });
    }

    function updateOrderNumbers() {
        const items = document.querySelectorAll('.banner-item');
        items.forEach((item, index) => {
            const orderBadge = item.querySelector('.bg-blue-100');
            orderBadge.textContent = index + 1;
        });
    }

    function saveOrder() {
        const items = document.querySelectorAll('.banner-item');
        const orderData = [];

        items.forEach((item, index) => {
            orderData.push({
                id: item.dataset.id,
                sort_order: index + 1
            });
        });

        fetch('banner?action=updateOrder', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(orderData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Đã lưu thứ tự thành công!');
                    location.reload();
                } else {
                    alert('Lỗi khi lưu thứ tự!');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Lỗi khi lưu thứ tự!');
            });
    }

    function toggleStatus(id, currentStatus) {
        const newStatus = currentStatus == 1 ? 0 : 1;

        fetch('banner?action=toggleStatus', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `id=${id}&status=${newStatus}`
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert('Lỗi khi cập nhật trạng thái!');
                }
            });
    }

    function deleteBanner(id) {
        if (confirm('Bạn có chắc muốn xóa banner này?')) {
            fetch('banner?action=delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `id=${id}`
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Đã xóa thành công!');
                        location.reload();
                    } else {
                        alert('Lỗi khi xóa banner!');
                    }
                });
        }
    }
</script>
</body>
</html>