<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<body>
    <div class="filter-section">
        <div class="align-items-center">
            <div class="search-wrapper">
                <i class="fas fa-search search-icon"></i>
                <input type="text" class="search-input" placeholder="Tìm theo tên người dùng hoặc sản phẩm..."/>
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
            <tbody>
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
        <div class="d-flex justify-content-between align-items-center m-3">
            <p class="mb-0">Hiển thị ${currentPage}-${totalPages} trong ${totalComments} bình luận</p>
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

                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a title="Tới trang trước" class="page-link" href="#">&gt;</a>
                    </li>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a title="Tới trang cuối" class="page-link" href="#">&gt;|</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/adminPages/js/comments.js"></script>
</body>
</html>
