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
    <link rel="stylesheet" href="css/products.css"/>
</head>
<body>
<jsp:include page="/common/header.jsp"/>

<div class="top-bar" role="navigation" aria-label="Breadcrumb and page header">
    <div class="container">
        <nav class="breadcrumb" aria-label="Breadcrumb" style="margin-left: -1px; ">
            <a href="${pageContext.request.contextPath}/home" aria-label="Trang Chủ">Trang Chủ</a>
            <svg class="crumb-sep" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M9 6l6 6-6 6" stroke="#8b8b8b" stroke-width="2" stroke-linecap="round"
                      stroke-linejoin="round"/>
            </svg>
            <a href="${pageContext.request.contextPath}/products" aria-label="Tất cả sản phẩm"
               style="width: 235px; color:#444;">Tất cả sản phẩm</a>
        </nav>
    </div>
</div>

<main class="mt-2">

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
                        <form action="${pageContext.request.contextPath}/products" method="get">
                            <!-- Category Filter -->
                            <h6 class="fw-bold mb-3 text-primary">Danh mục đồ chơi</h6>

                            <div class="mb-4 filter-scroll">
                                <c:forEach items="${categories}" var="c">
                                    <c:set var="checked" value="false"/>
                                    <c:if test="${paramValues.categoryId != null}">
                                        <c:forEach items="${paramValues.categoryId}" var="cid">
                                            <c:if test="${cid == c.id}">
                                                <c:set var="checked" value="true"/>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                    <div class="form-check">
                                        <input class="form-check-input"
                                               type="checkbox"
                                               name="categoryId"
                                               value="${c.id}"
                                               id="cat-${c.id}"
                                            ${checked ? 'checked' : ''}>

                                        <label class="form-check-label d-flex justify-content-between w-100"
                                               for="cat-${c.id}">
                                            <span>${c.name}</span>
                                            <span class="text-muted">(${c.productCount})</span>
                                        </label>
                                    </div>
                                </c:forEach>

                            </div>

                            <!-- Price Filter -->
                            <h6 class="fw-bold mb-3 text-primary">Khoảng giá</h6>

                            <div class="mb-4">
                                <c:forEach items="${priceRanges}" var="priceRange" varStatus="st">
                                    <c:set var="rangeValue" value="${priceRange.min} - ${priceRange.max}"/>
                                    <c:set var="checked" value="false"/>

                                    <c:if test="${paramValues.priceRange != null}">
                                        <c:forEach items="${paramValues.priceRange}" var="pr">
                                            <c:if test="${pr == rangeValue}">
                                                <c:set var="checked" value="true"/>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                    <div class="form-check">
                                        <input class="form-check-input"
                                               type="checkbox"
                                               name="priceRange"
                                               value="${rangeValue}"
                                               id="price-${st.index}"
                                            ${checked ? 'checked' : ''}>
                                        <label class="form-check-label" for="price-${st.index}">
                                                ${priceRange.label}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Brand Filter -->
                            <h6 class="fw-bold mb-0 text-primary">Thương hiệu</h6>

                            <div class="mb-3 filter-scroll">
                                <c:forEach items="${brands}" var="b">

                                    <c:set var="checked" value="false"/>
                                    <c:if test="${paramValues.brandId != null}">
                                        <c:forEach items="${paramValues.brandId}" var="cid">
                                            <c:if test="${cid == b.id}">
                                                <c:set var="checked" value="true"/>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                    <div class="form-check">
                                        <input class="form-check-input"
                                               type="checkbox"
                                               name="brandId"
                                               value="${b.id}"
                                               id="brand-${b.id}"
                                            ${checked ? 'checked' : ''}>

                                        <label class="form-check-label d-flex justify-content-between w-100"
                                               for="cat-${b.id}">
                                            <span>${b.name}</span>
                                            <span class="text-muted">(${b.productCount})</span>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>

                            <c:if test="${param.sort != null}">
                                <input type="hidden" name="sort" value="${param.sort}">
                            </c:if>

                            <div class ="d-flex justify-content-between align-items-center gap-3">
                                <button type="submit"
                                        class="btn btn-sm btn-primary w-100">
                                    Áp dụng
                                </button>
                                <a href="${pageContext.request.contextPath}/products"
                                   class="btn btn-sm btn-outline-secondary w-100">
                                    Bỏ lọc
                                </a>
                            </div>
                        </form>

                    </div>
                </div>
            </aside>


            <c:set var="sortQuery" value=""/>

            <c:if test="${param.sort != null}">
                <c:set var="sortQuery" value="&sort=${param.sort}"/>
            </c:if>


            <c:set var="filterQuery" value=""/>

            <c:if test="${paramValues.brandId != null}">
                <c:forEach items="${paramValues.brandId}" var="cid">
                    <c:set var="filterQuery" value="${filterQuery}&brandId=${cid}"/>
                </c:forEach>
            </c:if>

            <!-- Category -->
            <c:if test="${paramValues.categoryId != null}">
                <c:forEach items="${paramValues.categoryId}" var="id">
                    <c:set var="filterQuery" value="${filterQuery}&categoryId=${id}"/>
                </c:forEach>
            </c:if>

            <!-- Price Range -->
            <c:if test="${paramValues.priceRange != null}">
                <c:forEach items="${paramValues.priceRange}" var="pr">
                    <c:set var="filterQuery" value="${filterQuery}&priceRange=${pr}"/>
                </c:forEach>
            </c:if>

            <c:set var="fullFilterSortQuery" value="${filterQuery}${sortQuery}"/>


            <!-- Products List Section -->
            <section class="col-md-9">
                <div class="d-flex align-items-center justify-content-between flex-nowrap mb-4">
                    <span class="mx-2">Có ${totalItems} sản phẩm</span>
                    <div class="hstack gap-1">
                        <label>Sắp xếp theo:  </label>
                        <div class="dropdown">
                            <c:set var="sortLabel" value="Sản phẩm mới"/>

                            <c:choose>
                                <c:when test="${param.sort == 'discount'}">
                                    <c:set var="sortLabel" value="Hàng khuyến mãi"/>
                                </c:when>
                                <c:when test="${param.sort == 'name_asc'}">
                                    <c:set var="sortLabel" value="Tên A-Z"/>
                                </c:when>
                                <c:when test="${param.sort == 'name_desc'}">
                                    <c:set var="sortLabel" value="Tên Z-A"/>
                                </c:when>
                                <c:when test="${param.sort == 'price_asc'}">
                                    <c:set var="sortLabel" value="Giá tăng dần"/>
                                </c:when>
                                <c:when test="${param.sort == 'price_desc'}">
                                    <c:set var="sortLabel" value="Giá giảm dần"/>
                                </c:when>
                            </c:choose>

                            <button class="btn sort-btn dropdown-toggle"
                                    type="button"
                                    id="sortDropdown"
                                    data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                ${sortLabel}
                            </button>

                            <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                                <li><a class="dropdown-item" data-value="new" data-label="Sản phẩm mới" href="?page=1${filterQuery}&sort=new">Sản phẩm mới</a></li>
                                <li><a class="dropdown-item" data-value="discount" data-label="Hàng khuyến mãi" href="?page=1${filterQuery}&sort=discount">Hàng khuyến mãi</a></li>
                                <li><a class="dropdown-item" data-value="name_asc" data-label="Tên A-Z" href="?page=1${filterQuery}&sort=name_asc">Tên A-Z</a></li>
                                <li><a class="dropdown-item" data-value="name_desc" data-label="Tên Z-A" href="?page=1${filterQuery}&sort=name_desc">Tên Z-A</a></li>
                                <li><a class="dropdown-item" data-value="price_desc" data-label="Giá giảm dần" href="?page=1${filterQuery}&sort=price_desc">Giá giảm dần</a></li>
                                <li><a class="dropdown-item" data-value="price_asc" data-label="Giá tăng dần" href="?page=1${filterQuery}&sort=price_asc">Giá tăng dần</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- products -->
                <div id="productContainer" class="row g-4">
                    <c:forEach items="${products}" var="product">
                        <div class="col-sm-6 col-lg-4">
                            <div class="card h-100 position-relative">
                                <!-- Badge giảm giá -->
                                <c:if test="${product.discountPercent > 0}">
                                    <span class="badge bg-danger position-absolute top-0 end-0 m-2 fs-6">
                                        -${product.discountPercent}%
                                    </span>
                                </c:if>

                                <img src="${product.imgPath}"
                                     class="card-img-top p-3 cursor-pointer"
                                     alt="${product.name}"
                                     role="button"
                                     onclick="window.location.href='${pageContext.request.contextPath}/products/${product.id}'">

                                <div class="card-body d-flex flex-column">
                                    <p class="text-muted small mb-1">${product.category}</p>
                                    <h5 class="card-title text-truncate">${product.name}</h5>

                                    <!-- Giá -->
                                    <div class="mb-3">
                                        <c:if test="${product.discountPercent > 0}">
                                            <!-- Giá giảm -->
                                            <span class="text-danger fw-bold fs-5">
                                                <fmt:formatNumber value="${product.finalPrice}" type="currency"
                                                                  currencyCode="VND"/>
                                            </span>
                                            <!-- Giá gốc -->
                                            <span class="text-muted text-decoration-line-through me-2">
                                                <fmt:formatNumber value="${product.originPrice}" type="currency"
                                                                  currencyCode="VND"/>
                                            </span>
                                        </c:if>
                                        <c:if test="${product.discountPercent == 0}">
                                            <!-- Chỉ giá gốc nếu không giảm -->
                                            <span class="text-danger fw-bold fs-5">
                                                <fmt:formatNumber value="${product.originPrice}" type="currency"
                                                                  currencyCode="VND"/>
                                            </span>
                                        </c:if>
                                    </div>

                                    <div class="action-buttons d-flex justify-content-between align-items-center gap-3">
                                        <button type="button" class="btn-add-cart" data-id="${product.id}">
                                            Thêm Vào Giỏ Hàng
                                        </button>

                                        <button type="button"
                                                class="wishlist-icon ${product.wishlisted ? 'active' : ''}"
                                                data-id="${product.id}">
                                            <i class="bi ${product.wishlisted ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                        </button>
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
                            <a class="page-link text-primary"
                               href="?page=${currentPage - 1}${fullFilterSortQuery}"
                               aria-label="Previous">
                                &laquo;
                            </a>
                        </li>

                        <c:set var="startPage" value="${currentPage - 3}"/>
                        <c:set var="endPage" value="${currentPage + 3}"/>

                        <c:if test="${startPage < 1}">
                            <c:set var="endPage" value="${endPage + (1 - startPage)}"/>
                            <c:set var="startPage" value="1"/>
                        </c:if>
                        <c:if test="${endPage > totalPages}">
                            <c:set var="startPage" value="${startPage - (endPage - totalPages)}"/>
                            <c:set var="endPage" value="${totalPages}"/>
                        </c:if>
                        <c:if test="${startPage < 1}">
                            <c:set var="startPage" value="1"/>
                        </c:if>

                        <!-- First page -->
                        <c:if test="${startPage > 1}">
                            <li class="page-item">
                                <a class="page-link text-primary" href="?page=1${fullFilterSortQuery}">1</a>
                            </li>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>

                        <!-- Middle pages -->
                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link ${i == currentPage ? '' : 'text-primary'}"
                                   href="?page=${i}${fullFilterSortQuery}">${i}</a>
                            </li>
                        </c:forEach>

                        <!-- Last page -->
                        <c:if test="${endPage < totalPages}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                            <li class="page-item">
                                <a class="page-link text-primary" href="?page=${totalPages}${fullFilterSortQuery}">${totalPages}</a>
                            </li>
                        </c:if>

                        <!-- Next -->
                        <li class="page-item text-primary ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link text-primary" href="?page=${currentPage + 1}${fullFilterSortQuery}"
                               aria-label="Next">&raquo;</a>
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

<script>
    var buttons = document.getElementsByClassName("btn-add-cart");

    for (var i = 0; i < buttons.length; i++) {
        buttons[i].onclick = function () {

            var productId = this.getAttribute("data-id");

            fetch("${pageContext.request.contextPath}/cart", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "productId=" + productId + "&quantity=1"

            }).then(function (response) {
                return response.json();

            }).then(function (quantityData) {
                var totalQuantity = quantityData.totalQuantity;

                var cartText = "Giỏ hàng";

                if (totalQuantity > 0) {
                    cartText = "Giỏ hàng (" + totalQuantity + ")";
                }

                document.getElementById("cart-count").innerText = cartText;

                alert("Đã thêm sản phẩm vào giỏ!");
            });
        };
    }

    var wishlistButtons = document.getElementsByClassName("wishlist-icon");

    for (var i = 0; i < wishlistButtons.length; i++) {
        wishlistButtons[i].onclick = function () {
            var button = this;
            var productId = this.getAttribute("data-id");
            var icon = this.querySelector("i");

            fetch("${pageContext.request.contextPath}/wish-list", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "productId=" + productId
            }).then(function (res) {
                if (res.status === 401) {
                    window.location.href = '${pageContext.request.contextPath}/login';
                    return;
                }
                if (res.ok) {
                    return res.json();
                }
            }).then(function (data) {
                if (!data) return;

                if (data.wishlisted) {
                    icon.classList.remove("bi-heart");
                    icon.classList.add("bi-heart-fill");
                    button.classList.add("active");
                } else {
                    icon.classList.remove("bi-heart-fill");
                    icon.classList.add("bi-heart");
                    button.classList.remove("active");
                }
            });
        };
    }


</script>
</body>
</html>