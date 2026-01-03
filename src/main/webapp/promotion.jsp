<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Khuyến mãi</title>

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

                            <c:forEach var="p" items="${products}">
                                <div class="card border-0 shadow-sm flex-shrink-0 product-card">
                                    <div class="position-relative">
                                    <span class="badge bg-danger position-absolute top-0 end-0 m-2">
                                        -${promotion.discountPercent}%
                                    </span>
                                        <img src="${p.firstImg}"
                                             class="card-img-top p-3"
                                             style="cursor:pointer"
                                             role="button" onclick="window.location.href='${pageContext.request.contextPath}/products/${p.id}'">
                                    </div>

                                    <div class="card-body">
                                        <h6 class="card-title text-truncate mb-2">
                                                ${p.name}
                                        </h6>

                                        <div class="d-flex align-items-center mb-3">
                                            <span class="fw-bold text-danger fs-5">
                                                <fmt:formatNumber value="${p.discountPrice}" type="number"/>
                                            </span>
                                                        <span class="text-decoration-line-through text-muted ms-auto">
                                                <fmt:formatNumber value="${p.originalPrice}" type="number"/>
                                            </span>
                                        </div>

                                        <div class="action-buttons d-flex justify-content-between align-items-center gap-2">
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="productId" value="${p.id}" />
                                                <input type="hidden" name="quantity" value="1" />
                                                <button type="submit"  class="btn btn-danger w-100 text-wrap py-2">
                                                    Thêm Vào Giỏ Hàng
                                                </button>
                                            </form>
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
    <div class="toast-container position-fixed top-0 end-0 p-3">
        <div id="addingCartToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex p-1">
                <div class="toast-body">
                    <i class="fa-solid fa-circle-check"></i>
                    Thêm vào giỏ hàng thành công!!!
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
</main>

<style>
    .product-card {
        width: 220px;
        min-width: 220px;
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



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>