<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Khuyến mãi</title>
    <jsp:include page="/common/head.jsp" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/root.css"/>
    <link rel="stylesheet" href="css/promotion.css">
    <link rel="stylesheet" href="css/header.css">

</head>
<body>
<main class="px-0">

    <jsp:include page="/common/header.jsp" />

    <!-- Banner -->
    <div class="container-fluid mb-5">
        <img src="${banner}"
             alt="Banner khuyến mãi"
             class="rounded w-100 object-fit-fill" style="height: 50vh">
    </div>

    <div class="container-fluid">


        <c:forEach var="entry" items="${promotions}">
            <!-- key -->
            <c:set var="promotion" value="${entry.key}" />
            <!-- value -->
            <c:set var="products" value="${entry.value}" />


            <c:if test="${not empty products}">
                <section class="bg-primary rounded p-3 mb-5">
                    <h2 class="mb-4 fw-bold text-uppercase text-white">
                            ${promotion.name}
                    </h2>

                    <div class="position-relative">

                        <!-- PREV -->
                        <button class="d-none d-lg-flex position-absolute top-50 start-0 translate-middle-y z-1
                       btn btn-light rounded-circle shadow"
                                style="width:40px;height:40px"
                                onclick="slideLeft(this)">
                            <i class="fas fa-chevron-left"></i>
                        </button>

                        <!-- WRAPPER -->
                        <div class="product-slider d-flex gap-3 overflow-hidden px-5">

                            <c:forEach var="priceRange" items="${products}">
                                <div class="card border-0 shadow-sm flex-shrink-0 product-card">
                                    <div class="position-relative">
                                    <span class="badge bg-danger position-absolute top-0 end-0 m-2">
                                        -${promotion.discountPercent}%
                                    </span>
                                        <img src="${priceRange.firstImg}"
                                             class="card-img-top p-3"
                                             style="cursor:pointer"
                                             role="button" onclick="window.location.href='${pageContext.request.contextPath}/products/${priceRange.id}'"
                                        >
                                    </div>

                                    <div class="card-body">
                                        <h6 class="card-title text-truncate mb-2">
                                                ${priceRange.name}
                                        </h6>

                                        <div class="d-flex align-items-center mb-3">
                                            <span class="fw-bold text-danger fs-5">
                                                <fmt:formatNumber value="${priceRange.discountPrice}" type="number"/>
                                            </span>
                                                        <span class="text-decoration-line-through text-muted ms-auto">
                                                <fmt:formatNumber value="${priceRange.originalPrice}" type="number"/>
                                            </span>
                                        </div>

                                        <div class="action-buttons d-flex justify-content-between align-items-center gap-2">
                                            <button type="button" class="btn-add-cart" data-id="${priceRange.id}">
                                                Thêm Vào Giỏ Hàng
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>

                        <!-- NEXT -->
                        <button class="d-none d-lg-flex position-absolute top-50 end-0 translate-middle-y z-1
                       btn btn-light rounded-circle shadow"
                                style="width:40px;height:40px"
                                onclick="slideRight(this)">
                            <i class="fas fa-chevron-right"></i>
                        </button>

                    </div>
                </section>
                <hr>
            </c:if>
        </c:forEach>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <!-- Toast notification -->
<%--    <div class="toast-container position-fixed top-0 end-0 p-3">--%>
<%--        <div id="addingCartToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">--%>
<%--            <div class="d-flex p-1">--%>
<%--                <div class="toast-body">--%>
<%--                    <i class="fa-solid fa-circle-check"></i>--%>
<%--                    Thêm vào giỏ hàng thành công!!!--%>
<%--                </div>--%>
<%--                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
</main>

<%--notification--%>
<div class="toast-container position-fixed end-0 p-3" style = "top: 110px">
    <div id="addCartToast" class="toast align-items-center text-bg-success border-0"
         role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-delay="5000">
        <div class="d-flex">
            <div class="toast-body">
                <i class="bi bi-basket2-fill me-2"></i>
                Đã thêm sản phẩm vào giỏ hàng
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>

<div class="toast-container position-fixed end-0 p-3" style = "top: 110px">
    <div id="errorToast" class="toast align-items-center text-bg-danger border-0"
         role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-delay="5000">
        <div class="d-flex">
            <div class="toast-body" id="errorToastMsg">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <span id="errorText">Lỗi</span>
            </div>
            <button type="button"
                    class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>

<style>
    .product-card {
        width: 220px;
        min-width: 220px;
    }
</style>


<style>
    /*udpate add to cart*/
    .btn-add-cart {
        flex: 1 1 auto;
        white-space: nowrap;
        background: #d51b1b;
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


</style>


<script src="js/index.js"></script>
<script>
    const CARD_WIDTH = 220 + 16; // width + gap
    const VISIBLE_ITEMS = 5;

    function getSlider(btn) {
        // tìm slider gần nhất trong section đó
        return btn.closest('.position-relative')
            .querySelector('.product-slider');
    }

    function slideRight(btn) {
        const slider = getSlider(btn);
        slider.scrollBy({
            left: CARD_WIDTH * VISIBLE_ITEMS,
            behavior: 'smooth'
        });
    }

    function slideLeft(btn) {
        const slider = getSlider(btn);
        slider.scrollBy({
            left: -CARD_WIDTH * VISIBLE_ITEMS,
            behavior: 'smooth'
        });
    }
</script>




<script>

    let currentIndexLego = 0;

    const productsLego = document.querySelectorAll('.product-status-s');
    const totalProductsLego = productsLego.length;

    function renderProductsForLego() {
        // Ẩn tất cả
        productsLego.forEach(p => p.classList.add('d-none'));

        // Hiện 3 sản phẩm theo currentIndex
        for (let i = currentIndexLego; i < currentIndexLego + ITEMS_PER_PAGE; i++) {
            if (products[i]) {
                productsLego[i].classList.remove('d-none');
                console.log(i+" load for lego")
            }
        }
    }

    function nextProductsForLego() {
        if (currentIndexLego + ITEMS_PER_PAGE < totalProductsLego) {
            currentIndexLego += ITEMS_PER_PAGE;
            renderProductsForLego();
        }
    }

    function prevProductsForLego() {
        if (currentIndexLego - ITEMS_PER_PAGE >= 0) {
            currentIndexLego -= ITEMS_PER_PAGE;
            renderProductsForLego();
        }
    }

    // Init khi load trang
    document.addEventListener('DOMContentLoaded', renderProductsForLego);
</script>

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
            })
                .then(function (response) {
                    return response.json();
                })
                .then(function (data) {

                    if (data.error) {
                        document.getElementById("errorText").innerText = data.error;

                        var errorToast =
                            new bootstrap.Toast(document.getElementById("errorToast"));

                        errorToast.show();
                        return;
                    }

                    var totalQuantity = data.totalQuantity;

                    var cartText = "Giỏ hàng";

                    if (totalQuantity > 0) {
                        cartText = "Giỏ hàng (" + totalQuantity + ")";
                    }

                    document.getElementById("cart-count").innerText = cartText;

                    var successToast =
                        new bootstrap.Toast(document.getElementById("addCartToast"));

                    successToast.show();
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



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>