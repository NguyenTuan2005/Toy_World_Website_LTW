<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/header.css"/>
    <link rel="stylesheet" href="css/root.css"/>
    <style>
        .filter-scroll {
            max-height: 300px;
            overflow-y: auto;
        }

        .btn-add-cart {
            flex: 1 1 auto;
            white-space: nowrap;
            background: #cf102d;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            width: calc(100% - 50px);
            font-weight: bold;
        }

        .btn-add-cart:hover {
            color: white;
            background: #b01030;
        }

        .wishlist-icon {
            font-size: 35px;
            color: #999;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .wishlist-icon:hover {
            color: #dc3545;
            transform: scale(1.1);
        }

        .wishlist-icon.active {
            color: #dc3545;
        }

    </style>
</head>
<body>
<jsp:include page="/common/header.jsp"/>

<main class="px-0 mt-5">

    <div class="container-lg mb-5">
        <div class="row">
            <!-- Filter Section -->
            <aside class="col-md-3 mb-4">
                <div class="card border border-0">
                    <div class="card-header bg-primary text-white d-flex align-items-center">
                        <h5 class="mb-0">Danh mục</h5>
                        <button class="btn btn-sm text-white ms-auto d-sm-block d-md-none collapsed" type="button"
                                data-bs-toggle="collapse" data-bs-target="#filterCard" aria-expanded="true"
                                aria-controls="filterCard"
                                aria-label="Toggle filters">
                            <i class="fa fa-chevron-down"></i>
                        </button>
                    </div>
                    <div id="filterCard" class="card-body collapse show d-md-block">
                        <!-- Category Filter -->
                        <h6 class="fw-bold mb-3">Danh mục đồ chơi</h6>
                        <div class="list-group mb-4 list-group-flush filter-scroll">
                            <c:forEach items="${categories}" var="c">
                                <a href="#" class="list-group-item list-group-item-action">${c.name}</a>
                            </c:forEach>
                        </div>

                        <!-- Price Filter -->
                        <h6 class="fw-bold mb-3">Khoảng giá</h6>
                        <div class="mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="price1">
                                <label class="form-check-label" for="price1">Dưới 200.000₫</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="price2">
                                <label class="form-check-label" for="price2">200.000₫ - 500.000₫</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="price3">
                                <label class="form-check-label" for="price3">500.000₫ - 1.000.000₫</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="price4">
                                <label class="form-check-label" for="price4">Trên 1.000.000₫</label>
                            </div>
                        </div>

                        <!-- Brand Filter -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="fw-bold mb-0 text-primary">Thương hiệu</h6>
                            <button type="button" class="text-primary"
                                    onclick="window.location.href='${pageContext.request.contextPath}/products/filter/brand/clear'"
                                    style="all: unset; cursor: pointer;">Xóa
                            </button>
                        </div>
                        <form id="filterForm" method="get" action="${pageContext.request.contextPath}/products">
                            <div class="mb-3 filter-scroll">
                                <c:set var="selectedBrandIds" value="${sessionScope.selectedBrandIds}"/>

                                <c:forEach items="${brands}" var="b">
                                    <div class="form-check">
                                        <input class="form-check-input"
                                               type="checkbox"
                                               name="brandId"
                                               value="${b.id}"
                                               id="brand-${b.id}"
                                            ${paramValues.brandId != null && fn:contains(
                                                    fn:join(paramValues.brandId, ','), b.id) ? 'checked' : ''}
                                               onchange="this.form.submit()">

                                        <label class="form-check-label" for="brand-${b.id}">
                                                ${b.name}
                                        </label>
                                    </div>
                                </c:forEach>

                            </div>
                        </form>

                    </div>
                </div>
            </aside>

            <!-- Products List Section -->
            <section class="col-md-9">
                <div class="d-flex align-items-center flex-nowrap mb-4">
                    <span class="text-muted me-2">Có 24 sản phẩm</span>
                    <div class="hstack gap-1">
                        <label>Sắp xếp theo: </label>
                        <div class="dropdown">
                            <button id="sortBtn" class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                Tên sản phẩm A-Z
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="sortBtn">
                                <li><a class="dropdown-item" href="#">Tên sản phẩm A-Z</a></li>
                                <li><a class="dropdown-item" href="#">Tên sản phẩm Z-A</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <%-- products --%>
                <div id="productContainer" class="row g-4">
                    <c:forEach items="${products}" var="p">
                        <div class="col-sm-6 col-lg-4">
                            <div class="card h-100 position-relative">
                                <!-- Badge giảm giá -->
                                <c:if test="${p.discountPercent > 0}">
                                    <span class="badge bg-danger position-absolute top-0 end-0 m-2">
                                        -${p.discountPercent}%
                                    </span>
                                </c:if>

                                <img src="${p.imgPaths.get(0)}"
                                     class="card-img-top p-3 cursor-pointer"
                                     alt="${p.name}"
                                     role="button"
                                     onclick="window.location.href='${pageContext.request.contextPath}/products/${p.id}'">

                                <div class="card-body d-flex flex-column">
                                    <p class="text-muted small mb-1">${p.category}</p>
                                    <h5 class="card-title text-truncate">${p.name}</h5>

                                    <!-- Giá -->
                                    <div class="mb-3">
                                        <c:if test="${p.discountPercent > 0}">
                                            <!-- Giá giảm -->
                                            <span class="text-danger fw-bold fs-5">
                                                <fmt:formatNumber value="${p.finalPrice}" type="currency" currencyCode="VND"/>
                                            </span>
                                            <!-- Giá gốc -->
                                            <span class="text-muted text-decoration-line-through me-2">
                                                <fmt:formatNumber value="${p.originPrice}" type="currency" currencyCode="VND"/>
                                            </span>
                                        </c:if>
                                        <c:if test="${p.discountPercent == 0}">
                                            <!-- Chỉ giá gốc nếu không giảm -->
                                            <span class="text-danger fw-bold fs-5">
                                                <fmt:formatNumber value="${p.originPrice}" type="currency" currencyCode="VND"/>
                                            </span>
                                        </c:if>
                                    </div>

                                    <div class="action-buttons d-flex justify-content-between align-items-center gap-3">
                                        <button class="btn-add-cart">
                                            Thêm Vào Giỏ Hàng
                                        </button>
                                        <a class="wishlist-icon">
                                            <i class="bi bi-heart"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>


                <!-- Pagination Section -->
                <nav aria-label="Phân trang" class="mt-5">
                    <ul class="pagination justify-content-center gap-1">

                        <!-- Previous -->
                        <li class="page-item text-primary ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">&laquo;</a>
                        </li>

                        <c:set var="startPage" value="${currentPage - 3}" />
                        <c:set var="endPage" value="${currentPage + 3}" />

                        <c:if test="${startPage < 1}">
                            <c:set var="endPage" value="${endPage + (1 - startPage)}" />
                            <c:set var="startPage" value="1" />
                        </c:if>
                        <c:if test="${endPage > totalPages}">
                            <c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
                            <c:set var="endPage" value="${totalPages}" />
                        </c:if>
                        <c:if test="${startPage < 1}">
                            <c:set var="startPage" value="1" />
                        </c:if>

                        <!-- First page -->
                        <c:if test="${startPage > 1}">
                            <li class="page-item">
                                <a class="page-link text-primary" href="?page=1">1</a>
                            </li>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>

                        <!-- Middle pages -->
                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link ${i == currentPage ? '' : 'text-primary'}" href="?page=${i}">${i}</a>
                            </li>
                        </c:forEach>

                        <!-- Last page -->
                        <c:if test="${endPage < totalPages}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                            <li class="page-item">
                                <a class="page-link text-primary" href="?page=${totalPages}">${totalPages}</a>
                            </li>
                        </c:if>

                        <!-- Next -->
                        <li class="page-item text-primary ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">&raquo;</a>
                        </li>

                    </ul>
                </nav>
            </section>
        </div>
    </div>
</main>

<jsp:include page="/common/footer.jsp"/>

<script src="js/index.js"></script>
<script src="js/product.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.querySelectorAll('.btn-add-cart').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.dataset.id;
            fetch('${pageContext.request.contextPath}/cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `productId=${productId}&quantity=1`
            })
                .then(response => response.text())
                .then(data => {
                    alert('Đã thêm sản phẩm vào giỏ!');

                });
        });
    });

</script>
</body>
</html>