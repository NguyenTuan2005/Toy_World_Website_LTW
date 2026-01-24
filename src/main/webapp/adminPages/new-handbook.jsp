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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/new-handbook.css"/>
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<div class="main-content">
    <div class="px-3 py-4 hstack justify-content-between align-items-center">
        <h1 class="h3">Đăng Bài Viết Mới</h1>
        <button class="btn text-secondary"
           onclick="cancel()">
            <i class="fas fa-arrow-left"></i> Quay lại
        </button>
    </div>
    <hr>
    <div class="container mb-3">
        <div id="alert" class="alert alert-danger text-center d-none" role="alert">
            ${error}
        </div>

        <form id="blogForm" action="${pageContext.request.contextPath}/admin/new-handbooks" method="post">
            <div class="mb-3">
                <label for="postTitle" class="form-label">Tiêu đề bài viết</label>
                <input type="text" class="form-control" id="postTitle" placeholder="Nhập tiêu đề cho bài viết..." required />
            </div>

            <div class="mb-3">
                <label for="categorySelect" class="form-label">Danh mục bài viết</label>
                <div class="d-flex gap-2">
                    <select class="form-select flex-grow-1" id="categorySelect" required>
                        <option value="" disabled>-- Chọn danh mục --</option>
                        <c:forEach items="${categoryOfHB}" var="cate">
                            <option value="${cate.id}">${cate.name}</option>
                        </c:forEach>
                    </select>
                    <button type="button" class="btn btn-outline-secondary text-nowrap" onclick="createNewCategory()">
                        <i class="bi bi-plus-lg me-1"></i>Tạo mới
                    </button>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Nội dung bài viết (chia từng đoạn)</label>
                <div id="paragraphsContainer" class="mb-3">
                    <!-- Paragraphs will be dynamically added here -->
                </div>
                <button type="button" class="btn btn-outline-secondary fs-4 w-100" onclick="addParagraph()" style="height: 100px">
                    <i class="bi bi-plus-square me-2"></i>Thêm Đoạn Mới
                </button>
            </div>
        </form>

        <div class="p-3 hstack gap-2 justify-content-end">
            <button type="button" class="btn" onclick="cancel()">
                <i class="bi bi-x-circle me-2"></i>Hủy
            </button>
            <button type="button" class="btn btn-custom-primary" onclick="submitPost()">
                <i class="bi bi-send me-2"></i>Đăng Bài
            </button>
        </div>
    </div>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">Xác nhận</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="confirmMessage"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại
                </button>
                <button type="button" class="btn btn-danger" id="confirmBtn">
                    <i class="bi bi-x-circle me-1"></i>Xác nhận
                </button>
            </div>
        </div>
    </div>
</div>

<!-- New Category Modal -->
<div class="modal fade" id="newCategoryModal" tabindex="-1" aria-labelledby="newCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="newCategoryModalLabel">Tạo danh mục mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="newCategoryAlert" class="alert alert-danger text-center d-none" role="alert">
                </div>
                <label for="newCategoryInput" class="form-label">Tên danh mục</label>
                <input type="text" class="form-control" id="newCategoryInput" placeholder="Nhập tên danh mục mới...">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-1"></i>Hủy
                </button>
                <button type="button" class="btn btn-primary" id="confirmNewCategoryBtn">
                    <i class="bi bi-plus-circle me-1"></i>Tạo
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/adminPages/js/new-handbook.js"></script>
</body>
</html>