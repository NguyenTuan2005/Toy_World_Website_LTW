
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN" />
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Bài Viết</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý cẩm nang</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6 hstack align-items-center">
                    <div class="search-wrapper me-2">
                        <i class="fas fa-search search-icon"></i>
                        <form class="mb-0" id="searchForm"  action="${pageContext.request.contextPath}/admin/handbooks" method="post">
                            <input
                                    type="text"
                                    id="searchInput"
                                    name="keyword"
                                    class="search-input"
                                    value="${keyword}"
                                    placeholder="Nhập mã hoặc tiêu đề bài viết"
                            >
                        </form>

                    </div>
                    <c:if test="${keyword != null}">
                        <btn class="btn btn-outline-secondary h-100 hstack align-items-center"
                             onclick="window.location.href='${pageContext.request.contextPath}/admin/handbooks?page=1'">
                            <i class="bi bi-arrow-repeat"></i>
                        </btn>
                    </c:if>
                    <script>
                        document.getElementById("searchInput")
                            .addEventListener("keydown", function (e) {
                                if (e.key === "Enter") {
                                    e.preventDefault();
                                    document.getElementById("searchForm").submit();
                                }
                            });
                    </script>
                </div>
                <div class="col-md-6 d-flex align-items-center justify-content-end">

                    <div class="text-end mt-md-0">
                        <a  href="${pageContext.request.contextPath}/admin/new-handbooks"  class="btn-add fw-medium px-4 py-2 text-decoration-none">
                            <i class="fas fa-plus"></i> Thêm bài viết
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <style>
            /* Ảnh card đều nhau */
            .img-cover {
                /*height: 260px;*/
                /*object-fit: cover;*/
            }

            /* Giới hạn mô tả 3 dòng */
            .clamp-3 {
                display: -webkit-box;
                -webkit-line-clamp: 5;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .card {
                border-radius: 16px;
                border: 2px solid #dee2e6;
                overflow: hidden;
                transition: all 0.25s ease;
            }

            .card:hover {
                border-color: #0d6efd;
                box-shadow: 0 12px 28px rgba(13,110,253,0.25);
            }

        </style>

        <div class="container my-5">
            <div id="handbookTableBody" class="row g-4">
                <c:if test="${empty handbooks}">
                    <div class="empty-state text-center w-100 py-5">
                        <i class="bi bi-inbox-fill fs-1 text-muted mb-3"></i>
                        <h5 class="text-muted">Không có cẩm nang nào</h5>
                    </div>
                </c:if>
                <c:forEach var="hb" items="${handbooks}">
                    <div class="col-12 col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="${hb.firstImage}"
                                 class="card-img-top img-cover"
                                 alt="Europe Toy Fair">

                            <div class="card-body d-flex flex-column">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <small class="text-muted">
                                            ${hb.createdAt} - ${hb.username}
                                    </small>
                                    <small class="text-muted">
                                        <i class="bi bi-eye me-1"></i> <fmt:formatNumber value="${hb.views}" type="number" />
                                    </small>

                                    <c:choose>
                                        <c:when test="${hb.status == 'POSTED'}">
                                            <span class="text-danger" title="Đã đăng">
                                                <i class="bi bi-send"></i>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-secondary" title="Đang ẩn">
                                               <i class="bi bi-eye-slash"></i>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <h2 class="card-title text-truncate" style="color:  rgb(213, 27, 27);"> ${hb.title}</h2>

                                <p class="card-text text-muted clamp-3">
                                        ${hb.description}
                                </p>
                                <div class="card-footer bg-white border-0">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <a class="text-decoration-none text-secondary" href="${pageContext.request.contextPath}/admin/edit-handbooks?id=${hb.id}">
                                            <i class="bi bi-pencil-square"></i> Chỉnh sửa
                                        </a>

                                        <form class="mb-0" action="${pageContext.request.contextPath}/admin/handbook-details">
                                            <input type="hidden" name="id" value="${hb.id}">
                                            <button class="btn text-secondary">
                                                Xem thêm <i class="bi bi-arrow-right"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <hr>
            <c:if test="${keyword == null}">
                <div class="d-flex justify-content-between align-items-center m-3">
                    <p id="pageInfo" class="mb-0">Hiển thị ${currentPage}-${totalPages} trong ${totalElements} bài viết</p>
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
    </div>


</main>

<script>
    const totalPages = ${totalPages};
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/adminPages/js/handbook.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
