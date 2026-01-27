<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Thương Hiệu</title>
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
                    <h1 class="page-title">Quản lý thương hiệu</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-3">
        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="search-wrapper">
                        <i class="fas fa-search search-icon"></i>
                        <form class="mb-0" id="searchForm"  action="${pageContext.request.contextPath}/admin/brands" method="post">
                            <input
                                    type="text"
                                    id="searchInput"
                                    class="search-input"
                                    name="keyword"
                                    placeholder="Nhập ID / Tên"
                            />
                        </form>
                    </div>
                </div>
                <div class="col-md-6 d-flex align-items-center justify-content-end">
                    <c:if test="${find_brand != null || brandManages == null}">
                        <nav>
                            <ul class="pagination mb-0 me-2">
                                <li class="page-item"><a  class="page-link" href="${pageContext.request.contextPath}/admin/brands">Load lại bảng</a></li>
                            </ul>
                        </nav>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/admin/new-brand" class="btn-add fw-medium px-4 py-2 text-decoration-none">
                        <i class="fas fa-plus"></i> Thêm thương hiệu
                    </a>
                </div>
            </div>
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

        <style>
            .status-active {
                background-color: #e6f4ea;
                color: #1e7e34;
                border: 1px solid #1e7e34;
            }

            .status-locked {
                background-color: #fdecea;
                color: #dc3545;
                border: 1px solid #dc3545;
            }

            .img-thumbnail {
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .img-thumbnail:hover {
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            }

            .zoomed {
                width: 400px !important;
                height: 200px !important;
                transform: scale(1.05);
            }

        </style>

        <div class="table-container">
            <table class="table">
                <thead>
                <tr>
                    <th>Mã</th>
                    <th>Ảnh Logo</th>
                    <th>Tên Thương Hiệu</th>
                    <th>Số Lượng Sản Phẩm</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach var="b" items="${brandManages}">
                        <tr>
                            <td  class="bold-title">${b.id}</td>
                            <td>
                                <img src="${b.logo}"  alt="Ninjago" class="img-thumbnail"  style="width: 200px; height: 100px; object-fit: cover;"  >
                            </td>
                            <td  class="bold-title">${b.name}</td>
                            <td  class="bold-title">${b.quantity}</td>
                            <td class="text-nowrap">

                                <c:if test="${b.isActive}">
                                    <span class="badge  ${b.isActive ? 'status-active' : 'status-locked'}">
                                        Đang hoạt động
                                    </span>
                                </c:if>

                                <c:if test="${!b.isActive}">
                                    <span class="badge  ${b.isActive ? 'status-active' : 'status-locked'}">
                                        Ngưng hoạt động
                                    </span>
                                </c:if>

                            </td>
                            <td>${b.createdAt}</td>
                            <td>
                                <div class="d-flex gap-2">

                                    <button class="btn btn-link text-success text-decoration-none"   onclick="window.location.href='${pageContext.request.contextPath}/admin/update-brands?brandId=${b.id}'">
                                        <i class="fas fa-edit"></i>
                                    </button>

                                    <form method="post" action="${pageContext.request.contextPath}/admin/hidden-brands"   onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật không?');">
                                        <input type="hidden" name="brandId" value="${b.id}">
                                        <input type="hidden" name="active" value="${b.isActive}">
                                        <button class="btn btn-link text-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>

            <hr class="mx-5"/>
            <div class="d-flex justify-content-between align-items-center m-3">
                <c:if test="${find_brand == null}">
                    <p class="mb-0">
                        Hiển thị ${pageSize} trong ${totalElements} brands,
                        trang hiện tại ${currentPage },
                        tổng trang ${totalPages}
                    </p>

                    <nav>
                        <ul class="pagination mb-0">
                            <c:forEach var="i" begin="0" end="${totalPages - 1}" varStatus="st">

                                <c:choose>
                                    <c:when test="${st.index+1 == currentPage}">
                                        <li class="page-item active">
                                            <a class="page-link"
                                               href="${pageContext.request.contextPath}/admin/brands?page=${st.index + 1}">
                                                    ${st.index + 1}
                                            </a>
                                        </li>
                                    </c:when>

                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="${pageContext.request.contextPath}/admin/brands?page=${st.index + 1}">
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
<%--    zooom --%>
    <script>
        document.querySelectorAll('.img-thumbnail').forEach(img => {
            img.addEventListener('click', () => {
                img.classList.toggle('zoomed');
            });
        });

    </script>
    <div class="modal fade" id="brandModal" tabindex="-1" aria-labelledby="brandModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="brandModalLabel">Thêm thương hiệu</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="brandName" class="form-label">Tên thương hiệu</label>
                            <input type="text" class="form-control" id="brandName" placeholder="Nhập tên thương hiệu">
                        </div>
                        <div class="mb-3">
                            <label for="brandLogo" class="form-label">Logo thương hiệu</label>
                            <input type="file" class="form-control" id="brandLogo" accept="image/*">
                        </div>
                        <div class="mb-3 form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="brandStatus" checked>
                            <label class="form-check-label" for="brandStatus">
                                Hoạt động
                            </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Lưu</button>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
