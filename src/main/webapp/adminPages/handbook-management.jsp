
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
<style>
    .stats-card {
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        transition: transform 0.2s;
    }

    .stats-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.12);
    }

    .stats-icon {
        width: 48px;
        height: 48px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        margin-bottom: 1rem;
    }

    .stats-card.primary .stats-icon {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }

    .stats-card.success .stats-icon {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
    }

    .stats-card.warning .stats-icon {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
    }

    .stats-card.info .stats-icon {
        background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        color: white;
    }

    .stats-value {
        font-size: 2rem;
        font-weight: 700;
        color: #2c3e50;
        margin: 0;
    }

    .stats-label {
        color: #6c757d;
        font-size: 0.875rem;
        margin: 0;
    }

    .content-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        margin-bottom: 2rem;
    }

    .card-header-custom {
        padding: 1.5rem;
        border-bottom: 1px solid #e9ecef;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .card-title {
        font-size: 1.25rem;
        font-weight: 600;
        color: #2c3e50;
        margin: 0;
    }

    .search-box {
        position: relative;
        width: 300px;
    }

    .search-box input {
        padding-left: 2.5rem;
        border-radius: 8px;
        border: 1px solid #dee2e6;
    }
</style>

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
    <hr>

    <div class="container mb-3">


        <div class="container-fluid">
            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card primary">
                        <div class="stats-icon">
                            <i class="bi bi-file-earmark-text"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_handbooks}" type="number" /></h3>
                        <p class="stats-label">Tổng bài viết</p>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card info">
                        <div class="stats-icon">
                            <i class="bi bi-lock-fill"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_hidden_handbooks}" type="number" /></h3>
                        <p class="stats-label">Tổng bài viết đã ẩn </p>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card warning">
                        <div class="stats-icon">
                            <i class="bi bi-journal-text"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_new_handbooks_on_month}" type="number" /></h3>
                        <p class="stats-label">Mới tháng này</p>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card info">
                        <div class="stats-icon">
                            <i class="bi bi-check-circle-fill text-success"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_posted_on_month}" type="number" /></h3>
                        <p class="stats-label">Đã đăng trong tháng</p>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="stats-card info">
                        <div class="stats-icon">
                            <i class="bi bi-eye-slash-fill text-secondary"></i>
                        </div>
                        <h3 class="stats-value"><fmt:formatNumber value="${total_hidden_on_month}" type="number" /></h3>
                        <p class="stats-label">Đã ẩn trong tháng</p>
                    </div>
                </div>
            </div>
        </div>



        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6 hstack align-items-center">
                    <div class="search-wrapper flex-grow-1">
                        <i class="fas fa-search search-icon"></i>
                        <form class="mb-0" id="searchForm"  action="${pageContext.request.contextPath}/admin-x/handbooks" method="post">
                            <input
                                    type="text"
                                    id="searchInput"
                                    name="keyword"
                                    class="search-input"
                                    placeholder="Nhập ID / Title"
                            >
                        </form>

                    </div>
                    <script>
                        document.getElementById("searchInput")
                            .addEventListener("keydown", function (e) {
                                if (e.key === "Enter") {
                                    e.preventDefault(); // tránh reload không mong muốn
                                    document.getElementById("searchForm").submit();
                                }
                            });
                    </script>

                </div>
                <div class="col-md-6 d-flex align-items-center justify-content-end">
                    <c:if test="${find_user != null || manage_user == null}">
                        <nav>
                            <ul class="pagination mb-0 me-2">
                                <li class="page-item"><a  class="page-link" href="${pageContext.request.contextPath}/admin/users?page=1">Load lại bảng</a></li>
                            </ul>
                        </nav>
                    </c:if>
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
            <div class="section-title">Có thể bạn sẽ thích</div>
            <div class="row g-4">
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
                                            <span class="text-danger">
                                                <i class="bi bi-send"></i>

                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-secondary">
                                               <i class="bi bi-eye-slash"></i>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <h2 class="card-title text-truncate" style="color:  #0d6efd;"> ${hb.title}</h2>

                                <p class="card-text text-muted clamp-3">
                                        ${hb.description}
                                </p>
                                <!-- FIX CỨNG Ở ĐÂY -->
                                <div class="card-footer bg-white border-0">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <a href="#" class="action-link text-warning">
                                            <i class="bi bi-pencil-square"></i> Edit
                                        </a>

                                        <a href="#" class="action-link text-primary">
                                            Xem thêm <i class="bi bi-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <hr>
            <div class="d-flex justify-content-between align-items-center m-3">
                 <p class="mb-0">
                    Hiển thị ${pageSize} trong ${totalElements} cẩm nang,
                    trang hiện tại ${currentPage },
                    tổng trang ${totalPages}
                </p>
                <c:if test="${totalPages > 0}">
                    <nav>
                    <ul class="pagination mb-0">
                        <c:forEach var="i" begin="0" end="${totalPages - 1}" varStatus="st">

                            <c:choose>
                                <c:when test="${st.index+1 == currentPage}">
                                    <li class="page-item active">
                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/admin/users?page=${st.index + 1}">
                                                ${st.index + 1}
                                        </a>
                                    </li>
                                </c:when>

                                <c:otherwise>
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/admin/users?page=${st.index + 1}">
                                                ${st.index + 1}
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>
                    </ul>
                </nav>
                </c:if>
            </div>
        </div>
    </div>


</main>



<script src="js/index.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
