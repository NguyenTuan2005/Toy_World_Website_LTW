<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Cẩm Nang Đồ Chơi - Toy World</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/handbook.css" />
    <fmt:setLocale value="vi_VN"/>
</head>
<body>
    <jsp:include page="/common/header.jsp" />

    <div class="top-bar" role="navigation" aria-label="Breadcrumb and page header">
        <div class="container">
            <nav class="breadcrumb" aria-label="Breadcrumb" style="margin-left: -1px; ">
                <a href="${pageContext.request.contextPath}/home" aria-label="Trang Chủ">Trang Chủ</a>
                <svg class="crumb-sep" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                    <path d="M9 6l6 6-6 6" stroke="#8b8b8b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <a href="${pageContext.request.contextPath}/handbook" aria-label="Trang Chủ" style="width: 220px;">Cẩm Nang</a>
            </nav>
        </div>
    </div>

    <!-- Banner Section -->
    <div class="banner-section">
        <img src="${banner.imgPath}"
             alt="${banner.title}" class="banner-img">
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="sidebar my-3 hstack justify-content-between">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <form class="mb-0" method="post" action="${pageContext.request.contextPath}/handbook">
                    <input type="text" name="keyword" class="form-control search-input" value="${keyword}" placeholder="Tìm theo mã hoặc tên sản phẩm..."/>
                    <c:if test="${keyword != null}">
                        <a class="clear-icon" href="${pageContext.request.contextPath}/handbook">
                            <i class="fas fa-times"></i>
                        </a>
                    </c:if>
                </form>
            </div>
            <div class="fs-4 fw-bold text-secondary">Tất cả bài viết</div>
        </div>
        <c:choose>
            <c:when test="${empty handbooks}">
                <div id="handbookCards" class="mb-3">
                    <div class="empty-state text-center my-5" role="status" aria-live="polite">
                        <i class="bi bi-inbox-fill fs-1 text-muted mb-3"></i>
                        <h3 class="mt-3 text-secondary">Chưa có bài viết nào</h3>
                        <p class="text-muted">Không tìm thấy kết quả. Hãy thử lại sau hoặc thay đổi từ khóa tìm kiếm.</p>
                    </div>
            </c:when>
            <c:otherwise>
                <div id="handbookCards" class="article-grid mb-3">
            </c:otherwise>
        </c:choose>
            <c:forEach var="h" items="${handbooks}">
                <div class="article-card">
                    <img src="${h.firstImage}"
                         alt="Article" class="article-image">
                    <div class="article-content">
                        <h2 class="article-title">${h.title}</h2>
                        <div class="article-meta">
                            <span>
                                <fmt:formatDate value="${h.createdAtAsDate}" pattern="dd.MM.yyyy" />
                            </span>
                            <span>${h.username}</span>
                        </div>
                        <p class="article-excerpt">
                            ${h.description}
                        </p>
                        <a href="${pageContext.request.contextPath}/handbook-details?id=${h.id}" class="read-more">Xem Thêm</a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <c:if test="${keyword == null}">
            <div class="hstack justify-content-center m-3">
                <nav>
                    <ul id="handbookPagination" class="pagination mb-0" data-current-page="${currentPage}">
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

    <c:if test="${keyword == null}">
        <div class="container my-5">
            <div class="section-title">
                Có thể bạn sẽ thích
            </div>
            <div class="row g-4">
                <c:forEach var="h" items="${suggestHandbooks}">
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="card">
                            <img src="${h.firstImage}" class="card-img-top" alt="${h.title}">
                            <div class="card-body">
                                <div class="meta"><fmt:formatDate value="${h.createdAtAsDate}" pattern="dd.MM.yyyy" /> · ${h.username}</div>
                                <h5 class="card-title">${h.title}</h5>
                                <p class="card-text">${h.description}</p>
                                <a href="${pageContext.request.contextPath}/handbook-details?id=${h.id}" class="read-more">Xem thêm</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
    <jsp:include page="/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/js/handbook.js"></script>
</body>
</html>