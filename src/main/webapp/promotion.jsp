<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <!-- Section 1: Sale đồng giá 29k -->
        <section class="bg-primary rounded p-3 mb-5">
            <h2 class="mb-4 fw-bold text-uppercase text-white">
                Các đồ chơi đồng giá 29k
            </h2>
            <div class="position-relative overflow-x-hidden">
                <button class="d-none d-lg-block position-absolute top-50 z-1 bg-body-secondary border-0 shadow-sm rounded-circle"
                        style="transform: translateY(-50%); left: 5px; width: 40px; height: 40px; opacity: 0.75"
                        onmouseover="this.style.opacity='0.25'"
                        onmouseleave="this.style.opacity='0.75'"
                        onclick="prevSlide('wrapper')">
                    <i class="fas fa-chevron-left text-primary"></i>
                </button>

                <div class="wrapper overflow-x-auto d-flex gap-3 pb-3" id="wrapper">
                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-50%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/files/8a9c0b0f6ba70539f3c9700e9c71053b.jpg?v=1706865383&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Búp bê công chúa nhỏ">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Búp bê công chúa nhỏ</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">29.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">58.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-45%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/files/a028b5481d34e6c95d064d7a1b34eb90.jpg?v=1714721165&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Xe ô tô đồ chơi mini">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Xe ô tô đồ chơi mini</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">29.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">52.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-50%</span>
                            <img src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/lat-dat-bom-hoi-hinh-khung-long-intex-di-44669_2_fff66b5b-b31d-48d5-8ef9-d00d6f2e395a.jpg?v=1746696024&width=500"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Khủng long cao su mềm">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Khủng long cao su mềm</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">30.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">60.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-40%</span>
                            <img src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/bo-do-choi-lo-nuong-ha-ma-tim-sweet-heart-sh9079_3.png?v=1735637275&width=500"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Bộ đồ nấu ăn đồ chơi">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Bộ đồ nấu ăn đồ chơi</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">29.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">48.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-55%</span>
                            <img src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/AG2101007.jpg?v=1724298419&width=400"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Gấu bông siêu mềm">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Gấu bông siêu mềm</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">29.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">65.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-20%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/files/do-choi-cat-xe-ben-khong-lo-bx1311z.jpg?v=1720779214&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Đồ chơi cát - xe ben khổng lồ">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Đồ chơi cát - xe ben khổng lồ</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">29.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">39.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-15%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/files/bo-do-choi-gio-picnic-thuc-an-nhanh-sweet-heart-sh666-98_2.jpg?v=1725436212&width=1946"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Bộ Đồ Chơi Giỏ Picnic Thức Ăn Nhanh">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Bộ Đồ Chơi Giỏ Picnic Thức Ăn Nhanh</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">29.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">34.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>
                </div>

                <button class="d-none d-lg-block position-absolute top-50 z-1 bg-body-secondary border-0 shadow-sm rounded-circle"
                        style="transform: translateY(-50%); right: 5px; width: 40px; height: 40px; opacity: 0.75"
                        onmouseover="this.style.opacity='0.25'"
                        onmouseleave="this.style.opacity='0.75'"
                        onclick="nextSlide('wrapper')">
                    <i class="fas fa-chevron-right text-primary"></i>
                </button>
            </div>
        </section>

        <!-- Section 2: Giảm đến 50% -->
        <section class="bg-primary rounded p-3 mb-5">
            <h2 class="mb-4 fw-bold text-uppercase text-white">
                Đồ chơi giảm đến 50%
            </h2>
            <div class="position-relative overflow-x-hidden">
                <button class="d-none d-lg-block position-absolute top-50 z-1 bg-body-secondary border-0 shadow-sm rounded-circle"
                        style="transform: translateY(-50%); left: 5px; width: 40px; height: 40px; opacity: 0.75"
                        onmouseover="this.style.opacity='0.25'"
                        onmouseleave="this.style.opacity='0.75'"
                        onclick="prevSlide('wrapper2')">
                    <i class="fas fa-chevron-left text-primary"></i>
                </button>

                <div class="wrapper overflow-x-auto d-flex gap-3 pb-3" id="wrapper2">
                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-50%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/files/R96600-ORA.jpg?v=1715057804&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Xe điều khiển từ xa">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Xe điều khiển từ xa</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">225.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">450.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-50%</span>
                            <img src="https://cdn.shopify.com/s/files/1/0731/6514/4343/products/1-_5__1.jpg?v=1684975610&width=400"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Bộ xếp hình spiderman">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Bộ xếp hình spiderman</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">160.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">320.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-50%</span>
                            <img src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/X301003-RD-YE.jpg?v=1722396092&width=400"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
                                 alt="Đồng hồ trẻ em hoạt hình">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Đồng hồ trẻ em hoạt hình</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">100.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">200.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-50%</span>
                            <img src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/ba-lo-fancy-kitty-pinky-hong-clever-hippo-bk1232_1.jpg?v=1719463393&width=400"
                                 class="card-img-top"
                                 alt="Balo mèo dễ thương">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Balo mèo dễ thương</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">140.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">280.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-50%</span>
                            <img src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/combo-to-mau-va-sketchbook-aquatic-artist-deluxe-3c4g-12091_6.jpg?v=1742372595&width=400"
                                 class="card-img-top"
                                 alt="Bộ tô màu thiếu nhi">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Bộ tô màu thiếu nhi</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">110.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">220.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-50%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/products/vt003-1_1.jpg?v=1685103502&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
 onclick="window.location.href='product-detail.html'"
                                 alt="Đồ chơi bệ phóng máy bay phiên bản đèn Led (đỏ)">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Đồ chơi bệ phóng máy bay phiên bản đèn Led (đỏ)i</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">49.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">99.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-50%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/files/do-choi-bach-tuoc-biet-hat-sweetnfun-pab007_1.jpg?v=1743044736&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
 onclick="window.location.href='product-detail.html'"
                                 alt="Bạch tuộc biết hát SWEETNFUN PAB007">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Bạch tuộc biết hát SWEETNFUN PAB007</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">30.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">60.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>
                </div>

                <button class="d-none d-lg-block position-absolute top-50 z-1 bg-body-secondary border-0 shadow-sm rounded-circle"
                        style="transform: translateY(-50%); right: 5px; width: 40px; height: 40px; opacity: 0.75"
                        onmouseover="this.style.opacity='0.25'"
                        onmouseleave="this.style.opacity='0.75'"
                        onclick="nextSlide('wrapper2')">
                    <i class="fas fa-chevron-right text-primary"></i>
                </button>
            </div>
        </section>

        <!-- Section 3: Giảm giá 20% tháng này -->
        <section class="bg-primary rounded p-3 mb-5">
            <h2 class="mb-4 fw-bold text-uppercase text-white">
                Giảm giá 20% tháng này
            </h2>
            <div class="position-relative overflow-x-hidden">
                <button class="d-none d-lg-block position-absolute top-50 z-1 bg-body-secondary border-0 shadow-sm rounded-circle"
                        style="transform: translateY(-50%); left: 5px; width: 40px; height: 40px; opacity: 0.75"
                        onmouseover="this.style.opacity='0.25'"
                        onmouseleave="this.style.opacity='0.75'"
                        onclick="prevSlide('wrapper2')">
                    <i class="fas fa-chevron-left text-primary"></i>
                </button>

                <div class="wrapper overflow-x-auto d-flex gap-3 pb-3" id="wrapper3">
                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-20%</span>
                            <img src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/BLM1230-BLACK.jpg?v=1751298658&width=400"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
 onclick="window.location.href='product-detail.html'"
                                 alt="Balo học sinh siêu anh hùng">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Balo học sinh siêu anh hùng</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">304.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">380.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-20%</span>
                            <img src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/kinh-mat-gong-doi-mau-light-pink-7swilppk.png?v=1721292022&width=500"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
 onclick="window.location.href='product-detail.html'"
                                 alt="Kính mát siêu nhí đáng yêu">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Kính mát siêu nhí đáng yêu</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">96.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">120.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-20%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/files/mo-hinh-sieu-sao-cau-thu-messi-argentina-minix-11735_1.jpg?v=1750087781&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
 onclick="window.location.href='product-detail.html'"
                                 alt="Đồ Chơi Mô Hình Siêu Sao Cầu Thủ Messi">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Đồ Chơi Mô Hình Siêu Sao Cầu Thủ Messi</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">128.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">160.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-20%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/products/MT15088_9972_1.jpg?v=1684883238&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
 onclick="window.location.href='product-detail.html'"
                                 alt="Đồ chơi mô hình máy bay AV-8B Harrier II">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Đồ chơi mô hình máy bay AV-8B Harrier II</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">120.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">150.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-20%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/products/7131_7_ba19977e-95d5-4dfd-adb7-714e8b3fdaf4.jpg?v=1722397011&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
 onclick="window.location.href='product-detail.html'"
                                 alt="Khủng long phiến sừng chiến đấu Stegosaurus">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Khủng long phiến sừng chiến đấu Stegosaurus</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">200.000đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">250.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-20%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/files/do-choi-dien-thoai-cua-peppa-pig-1684687inf22.jpg?v=1721382120&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
 onclick="window.location.href='product-detail.html'"
                                 alt="Đồ chơi điện thoại của Peppa Pig">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Đồ chơi điện thoại của Peppa Pig</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">95.200đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">119.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm flex-shrink-0 w-sm-50 w-md-33 w-lg-auto">
                        <div class="position-relative">
                            <span class="badge bg-primary position-absolute top-0 end-0 m-2 fs-6">-20%</span>
                            <img src="https://www.mykingdom.com.vn/cdn/shop/files/xe-dao-dat-khong-lo-650567.png?v=1720001939&width=1206"
                                 class="card-img-top p-3"   onclick="window.location.href='product-detail.html'"
 onclick="window.location.href='product-detail.html'"
                                 alt="Xe đào đất khổng lồ">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate mb-2">Xe đào đất khổng lồ</h5>
                            <div class="hstack mb-3">
                                <span class="fs-4 fw-bold text-primary">71.200đ</span>
                                <span class="text-decoration-line-through text-muted ms-auto">89.000đ</span>
                            </div>
                            <button class="btn btn-primary w-100" onclick="addToCart()">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>
                </div>

                <button class="d-none d-lg-block position-absolute top-50 z-1 bg-body-secondary border-0 shadow-sm rounded-circle"
                        style="transform: translateY(-50%); right: 5px; width: 40px; height: 40px; opacity: 0.75"
                        onmouseover="this.style.opacity='0.25'"
                        onmouseleave="this.style.opacity='0.75'"
                        onclick="nextSlide('wrapper3')">
                    <i class="fas fa-chevron-right text-primary"></i>
                </button>
            </div>
        </section>
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


<script src="js/index.js"></script>
<script>
    function nextSlide(target) {
        const wrapper = document.getElementById(target);
        if (!wrapper) return;
        const first = wrapper.firstElementChild;
        if (!first) return;
        wrapper.appendChild(first);
    }

    function prevSlide(target) {
        const wrapper = document.getElementById(target);
        if (!wrapper) return;
        const last = wrapper.lastElementChild;
        if (!last) return;
        wrapper.insertBefore(last, wrapper.firstElementChild);
    }

    function addToCart() {
        const toast = new bootstrap.Toast(document.getElementById('addingCartToast'));
        toast.show();

        setTimeout(() => {
            this.reset();
        }, 500);
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>