<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
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
    <link rel="stylesheet" href="css/product.css">
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
                        <div class="list-group mb-4 list-group-flush">
                            <a href="#" class="list-group-item list-group-item-action">Đồ chơi lắp ráp</a>
                            <a href="#" class="list-group-item list-group-item-action">Búp bê & Nhân vật</a>
                            <a href="#" class="list-group-item list-group-item-action">Xe đồ chơi</a>
                            <a href="#" class="list-group-item list-group-item-action">Đồ chơi giáo dục</a>
                            <a href="#" class="list-group-item list-group-item-action">Thú nhồi bông</a>
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
                        <h6 class="fw-bold mb-3">Thương hiệu</h6>
                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="brand1">
                                <label class="form-check-label" for="brand1">LEGO</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="brand2">
                                <label class="form-check-label" for="brand2">Barbie</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="brand3">
                                <label class="form-check-label" for="brand3">Hot Wheels</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="brand4">
                                <label class="form-check-label" for="brand4">Fisher-Price</label>
                            </div>
                        </div>
                    </div>
                </div>
            </aside>

            <!-- Products List Section -->
            <section class="col-md-9">
                <div class="d-flex align-items-center flex-nowrap mb-4">
                    <div class="hstack gap-1">
                        <label>Kiểu xem: </label>
                        <button id="btnGrid" class="btn btn-sm text-center gap-1 active" onclick="switchToGrid()">
                            <i class="fa fa-th"></i> Lưới
                        </button>

                        <button id="btnList" class="btn btn-sm text-center gap-1" onclick="switchToLine()">
                            <i class="fa fa-bars"></i> Dòng
                        </button>
                    </div>
                    <span class="text-muted mx-auto">Có 24 sản phẩm</span>
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
                    <!-- Product Card 1 -->

                    <c:forEach items="${products}" var="p">
                        <div class="col-sm-6 col-lg-4">
                            <div class="card h-100">
                                <img src="${productAssetMap.get(p.id).get(0)}"
                                     class="card-img-top p-3 cursor-pointer"
                                     alt="LEGO Classic"
                                     role="button" onclick="window.location.href='product-detail.html'">
                                <div class="card-body d-flex flex-column"
                                     onclick="window.location.href='product-detail.html'">
                                    <p class="text-muted small mb-1">
                                            ${categoryMap.get(p.categoryId)}
                                    </p>
                                    <h5 class="card-title text-truncate">${p.name}</h5>
                                    <div class="mb-3">
                                        <span class="text-danger fw-bold fs-5">
                                            <fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/>
                                        </span>
                                    </div>
                                    <button class="btn btn-primary w-100 mt-auto">
                                        <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>


                </div>

                <!-- Pagination Section -->
                <nav aria-label="Phân trang" class="mt-5">
                    <ul class="pagination justify-content-center gap-1">

                        <!-- Previous -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="?page=${currentPage - 1}"
                               aria-label="Previous">
                                &laquo;
                            </a>
                        </li>

                        <!-- Page numbers -->
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link ${i == currentPage ? '' : 'text-primary'}"
                                   href="?page=${i}">
                                        ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <!-- Next -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="?page=${currentPage + 1}"
                               aria-label="Next">
                                &raquo;
                            </a>
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
</body>
</html>