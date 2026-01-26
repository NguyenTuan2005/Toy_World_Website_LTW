<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN" />
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Bài Viết</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png"/>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/edit-handbook.css"/>
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="px-5 py-4 hstack justify-content-between align-items-center">
        <h2 class="">Quản lý cẩm nang</h2>
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

        <form id="blogForm" onsubmit="handleSubmit(event)">
            <input id="handbookId" type="hidden" value="${handbookId}">

            <div class="form-card">
                <div class="section-title">
                    Tiêu đề bài viết
                </div>
                <input type="text" class="form-control" id="postTitle"
                       value="${title}" required />
            </div>

            <div class="form-card">
                <div class="section-title">
                    Danh mục bài viết
                </div>
                <div class="category-select-wrapper">
                    <select class="form-select" id="categorySelect" required>
                        <option value="" disabled>-- Chọn danh mục --</option>
                        <c:forEach items="${categoryOfHB}" var="cate">
                            <option value="${cate.id}">${cate.name}</option>
                        </c:forEach>
                    </select>
                    <button type="button" class="btn btn-new-category" onclick="newCategory()">
                        <i class="bi bi-plus-lg me-1"></i>Tạo mới
                    </button>
                </div>
            </div>

            <div class="form-card">
                <div class="section-title">
                    Nội dung bài viết
                </div>
                <div id="paragraphsContainer">
                    <c:forEach var="entry" items="${paragraphs}" varStatus="counter">

                        <div class="paragraph-item" data-paragraph-id="${counter.index + 1}">
                            <input id="paragraphId" type="hidden" value="${entry.id}">
                            <div class="paragraph-header p-2 hstack justify-content-between align-items-center rounded-top-2">
                                <span class="text-white">
                                    Đoạn ${counter.index + 1}
                                </span>
                                <button type="button" class="btn delete-paragraph" onclick="deleteParagraph(this)">
                                    <i class="bi bi-x-lg text-white"></i>
                                </button>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Tiêu đề đoạn ${counter.index + 1} (tùy chọn)</label>
                                <input type="text" class="form-control paragraph-title"
                                       value="${entry.header}"
                                       placeholder="Nhập tiêu đề cho đoạn này..." />
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Nội dung</label>
                                <textarea class="form-control editor-${counter.index + 1}"
                                          id="editor-${counter.index + 1}">${entry.description}</textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Hình ảnh (tùy chọn)</label>
                                <div class="image-upload-wrapper ${entry.imagePath == null ? "": "d-none"}" id="uploadWrapper-${counter.index + 1}">
                                    <i class="bi bi-image fs-1 text-secondary"></i>
                                    <div class="image-upload-text">
                                        Nhấn để chọn hình ảnh cho đoạn này
                                    </div>
                                </div>

                                <input type="file" id="fileInput-${counter.index + 1}" accept="image/*" />

                                <div id="imagePreview-${counter.index + 1}"
                                     class="image-preview-container ${entry.imagePath == null ? "d-none" : ""}">
                                    <img
                                            src="${entry.imagePath == null ? "" : entry.imagePath}"
                                            id="previewImg-${counter.index + 1}"
                                            class="image-preview" />

                                    <div class="mt-2">
                                        <button type="button"
                                                class="btn btn-sm btn-outline-secondary change-image-btn me-2"
                                                data-input-id="fileInput-${counter.index + 1}">
                                            <i class="bi bi-arrow-repeat me-1"></i>Thay đổi hình
                                        </button>

                                        <button type="button"
                                                class="btn btn-sm btn-danger delete-image-btn"
                                                data-paragraph-id="${counter.index + 1}">
                                            <i class="bi bi-trash me-1"></i>Xóa hình
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button type="button" class="btn btn-add-paragraph" id="addParagraphBtn" onclick="addNewParagraph()">
                    <i class="bi bi-plus-circle me-2"></i>Thêm đoạn mới
                </button>
            </div>

            <div class="text-end">
                <button type="button" class="btn btn-outline-secondary me-2"
                        onclick="cancel()">
                    <i class="bi bi-x-circle me-1"></i>Hủy
                </button>
                <button type="submit" class="btn btn-custom-primary">
                    <i class="bi bi-check-circle me-1"></i>Lưu bài viết
                </button>
            </div>
        </form>
    </div>
</main>

<!-- Confirmation Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel">
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
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại
                </button>
                <button type="button" class="btn btn-danger" id="confirmBtn" autofocus>
                    <i class="bi bi-x-circle me-1"></i>Xác nhận
                </button>
            </div>
        </div>
    </div>
</div>

<!-- New Category Modal -->
<div class="modal fade" id="newCategoryModal" tabindex="-1" aria-labelledby="newCategoryModalLabel">
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

<!-- Scripts -->
<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/adminPages/js/edit-handbook.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/40.2.0/classic/ckeditor.js"></script>
</body>
</html>