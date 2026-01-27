<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Banners</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        h1 {
            color: #333;
            font-size: 28px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        .btn-primary {
            background: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background: #45a049;
        }
        .btn-edit {
            background: #2196F3;
            color: white;
            padding: 6px 12px;
            font-size: 13px;
        }
        .btn-edit:hover {
            background: #0b7dda;
        }
        .btn-delete {
            background: #f44336;
            color: white;
            padding: 6px 12px;
            font-size: 13px;
        }
        .btn-delete:hover {
            background: #da190b;
        }
        .filter-section {
            margin-bottom: 20px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 5px;
        }
        .filter-section label {
            margin-right: 10px;
            font-weight: 600;
        }
        .filter-section select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .group-section {
            margin-bottom: 40px;
        }
        .group-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 20px;
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 18px;
            font-weight: 600;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th {
            background: #f8f9fa;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #dee2e6;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
        }
        tr:hover {
            background: #f8f9fa;
        }
        .banner-img {
            width: 100px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .status-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }
        .actions {
            display: flex;
            gap: 8px;
        }
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }
        .sort-order {
            font-weight: 600;
            color: #667eea;
            font-size: 16px;
        }
    </style>
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>
<div class="container">
    <div class="header">
        <h1>📋 Quản lý Banners</h1>
        <a href="${pageContext.request.contextPath}/admin/banners/create" class="btn btn-primary">
            ➕ Thêm Banner Mới
        </a>
    </div>

    <div class="filter-section">
        <label for="groupFilter">Lọc theo nhóm:</label>
        <select id="groupFilter" onchange="filterByGroup(this.value)">
            <option value="all">Tất cả nhóm</option>
            <c:forEach var="group" items="${groupTags}">
                <option value="${group}" ${param.group eq group ? 'selected' : ''}>
                        ${group}
                </option>
            </c:forEach>
        </select>
    </div>

    <c:choose>
        <c:when test="${empty bannersByGroup}">
            <div class="empty-state">
                <h3>Chưa có banner nào</h3>
                <p>Hãy thêm banner đầu tiên của bạn!</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="entry" items="${bannersByGroup}">
                <div class="group-section">
                    <div class="group-header">
                        📌 Nhóm: ${entry.key}
                    </div>

                    <table>
                        <thead>
                        <tr>
                            <th style="width: 60px;">Thứ tự</th>
                            <th style="width: 120px;">Hình ảnh</th>
                            <th>Tiêu đề</th>
                            <th>Event ID</th>
                            <th style="width: 100px;">Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th style="width: 150px;">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="banner" items="${entry.value}">
                            <tr>
                                <td class="sort-order">#${banner.sortOrder}</td>
                                <td>
                                    <img src="${banner.imgPath}"
                                         alt="${banner.title}"
                                         class="banner-img"
                                         onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'">
                                </td>
                                <td class="bold-title"  >${banner.title}</td>
                                <td>${banner.eventId != null ? banner.eventId : '-'}</td>
                                <td>
                                            <span class="status-badge ${banner.active ? 'status-active' : 'status-inactive'}">
                                                    ${banner.active ? 'Hoạt động' : 'Tắt'}
                                            </span>
                                </td>
                                <td>
                                    <div>"${banner.createdAt}"</div>
<%--                                    <fmt:formatDate value="${banner.createdAt}" pattern="dd/MM/yyyy HH:mm" />--%>
                                </td>
                                <td>
                                    <div class="actions">
                                        <a href="${pageContext.request.contextPath}/admin/banners/edit?id=${banner.id}"
                                           class="btn btn-edit">✏️ Sửa</a>
                                        <form action="${pageContext.request.contextPath}/admin/banners/delete"
                                              method="post"
                                              style="display: inline;"
                                              onsubmit="return confirm('Bạn có chắc muốn xóa banner này?');">
                                            <input type="hidden" name="id" value="${banner.id}">
                                            <button type="submit" class="btn btn-delete">🗑️ Xóa</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function filterByGroup(group) {
        if (group === 'all') {
            window.location.href = '${pageContext.request.contextPath}/admin/banners';
        } else {
            window.location.href = '${pageContext.request.contextPath}/admin/banners?group=' + encodeURIComponent(group);
        }
    }
</script>
</body>
</html>