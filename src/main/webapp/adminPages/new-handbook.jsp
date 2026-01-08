<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản trị - Đăng Bài Viết Mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
    <script src="https://cdn.ckeditor.com/ckeditor5/40.2.0/classic/ckeditor.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/new-handbook.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>

</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>


<div class="main-container">
    <div class="header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h1><i class="bi bi-pencil-square me-2"></i>Đăng Bài Viết Mới</h1>
                <div class="header-buttons">
                    <button type="button" class="btn btn-add" id="addParagraphBtn">
                        <i class="bi bi-plus-square me-2"></i>Thêm Đoạn Mới
                    </button>
                    <button type="button" class="btn btn-cancel" id="cancelBtn">
                        <i class="bi bi-x-circle me-2"></i>Hủy
                    </button>
                    <button type="button" class="btn btn-submit" id="submitBtn">
                        <i class="bi bi-send me-2"></i>Đăng Bài
                    </button>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <div class="container mb-3">
      <form id="blogForm">
        <!-- Tiêu đề bài viết -->
        <div class="form-card">
            <div class="section-title">
                <i class="bi bi-type"></i>Tiêu đề bài viết
            </div>
            <input type="text" class="form-control" id="postTitle" placeholder="Nhập tiêu đề hấp dẫn cho bài viết..." required />
        </div>

        <!-- Danh mục -->
        <div class="form-card">
            <div class="section-title">
                <i class="bi bi-tags"></i>Danh mục bài viết
            </div>
            <div class="category-select-wrapper">
                <select class="form-select" id="categorySelect" required>
                    <option value="">-- Chọn danh mục --</option>

                    <c:forEach items="${categoryOfHB}" var="cate">
                        <option value="${cate.id}">${cate.name}</option>
                    </c:forEach>
                </select>
                <button type="button" class="btn btn-new-category" id="newCategoryBtn">
                    <i class="bi bi-plus-lg me-1"></i>Tạo mới
                </button>
            </div>
        </div>

        <!-- Các đoạn bài viết -->
        <div class="form-card">
            <div class="section-title">
                <i class="bi bi-file-text"></i>Nội dung bài viết (chia từng đoạn)
            </div>
            <div id="paragraphsContainer"></div>
        </div>
    </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/adminPages/js/new-handbook.js"></script>
</body>
</html>