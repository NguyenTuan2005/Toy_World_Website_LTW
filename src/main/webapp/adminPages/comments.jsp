<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Sản Phẩm</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/products.css">
</head>
<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between">
                <h1 class="page-title">Quản lý sản phẩm</h1>

                <!-- Nav Pills -->
                <ul class="nav nav-pills">
                    <li class="nav-item me-1">
                        <button class="nav-link"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/products'">
                            <i class="fas fa-box"></i> Danh sách sản phẩm
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link active">
                            <i class="fas fa-comments"></i> Bình luận sản phẩm
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="container">
        <div id="alert" class="alert alert-danger text-center d-none" role="alert">
            ${error}
        </div>

        <div class="filter-section">
            <div class="align-items-center">
                <div class="search-wrapper">
                    <i class="fas fa-search search-icon"></i>
                    <form class="mb-0" method="post" action="${pageContext.request.contextPath}/admin/comments">
                        <input type="text" name="keyword" class="form-control search-input" value="${keyword}" placeholder="Tìm theo tên sản phẩm..."/>
                        <c:if test="${keyword != null}">
                            <a class="clear-icon" href="${pageContext.request.contextPath}/admin/comments">
                                <i class="fas fa-times"></i>
                            </a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>

        <div class="table-container">
            <table class="table">
                <thead class="table-primary">
                <tr>
                    <th class="sortable text-white text-nowrap">Khách Hàng</th>
                    <th class="sortable text-white text-nowrap">Sản Phẩm</th>
                    <th class="text-white" style="min-width: 250px">Nội Dung</th>
                    <th class="sortable text-white text-nowrap">Thời Gian</th>
                    <th class="text-white">Hành động</th>
                </tr>
                </thead>
                <tbody id="commentTableBody">
                <c:if test="${empty comments}">
                    <tr>
                        <td colspan="5" class="text-center text-muted py-4">Không có bình luận nào.</td>
                    </tr>
                </c:if>
                <c:forEach var="c" items="${comments}">
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <span>${c.user}</span>
                            </div>
                        </td>
                        <td>
                            <div title="${c.product}" class="product-name-cell">${c.product}</div>
                        </td>
                        <td>
                            <div title="${c.content}" class="comment-content">${c.content}</div>
                        </td>
                        <td><small>${c.createdAt}</small></td>
                        <td>
                            <div class="d-flex gap-2">
                                <c:choose>
                                    <c:when test="${c.active}">
                                        <button class="btn btn-link text-secondary p-0"
                                                onclick="toggleComment(${c.commentId}, false)"
                                                title="Ẩn bình luận">
                                            <i class="fas fa-eye-slash"></i>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-link text-secondary p-0"
                                                onclick="toggleComment(${c.commentId}, true)"
                                                title="Hiện bình luận">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <hr class="mx-5"/>
            <c:if test="${keyword == null}">
                <div class="d-flex justify-content-between align-items-center m-3">
                    <p id="pageInfo" class="mb-0">Hiển thị ${currentPage}-${totalPages} trong ${totalComments} bình luận</p>
                    <nav>
                        <ul id="commentPagination" class="pagination mb-0" data-current-page="${currentPage}">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a title="Tới trang đầu" class="page-link" href="#">|&lt;</a>
                            </li>
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a title="Tới trang sau" class="page-link" href="#">&lt;</a>
                            </li>

                            <c:forEach var="i"
                                       begin="${(totalPages <= 5) ? 1 : (currentPage <= 3 ? 1 : (currentPage >= (totalPages - 2) ? totalPages - 4 : currentPage - 2))}"
                                       end="${(totalPages <= 5) ? totalPages : (currentPage <= 3 ? 5 : (currentPage >= (totalPages - 2) ? totalPages : currentPage + 2))}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a title="Tới trang ${i}" class="page-link" href="#">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                <a title="Tới trang trước" class="page-link" href="#">&gt;</a>
                            </li>
                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                <a title="Tới trang cuối" class="page-link" href="#">&gt;|</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Toggle Comment Confirmation Modal -->
    <div class="modal fade" id="toggleCommentModal" tabindex="-1" aria-labelledby="toggleCommentModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="toggleCommentModalLabel">Xác nhận</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p id="toggleCommentMessage"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                    <button type="button" class="btn btn-primary" onclick="confirmSubmit()">
                        <i class="fas fa-check"></i> Xác nhận
                    </button>
                </div>
            </div>
        </div>
    </div>
</main>


<script>
    const contextPath = "${pageContext.request.contextPath}"
    const page = ${currentPage};
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/adminPages/js/comments.js"></script>
</body>
</html>
