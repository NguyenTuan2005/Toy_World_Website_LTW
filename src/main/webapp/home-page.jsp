<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>TOY WORLD - THẾ GIỚI ĐỒ CHƠI</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
        <jsp:include page="/common/head.jsp" />
        <link rel="stylesheet" href="css/home-page.css">
    </head>
    <body>
        <main>
            <jsp:include page="/common/header.jsp" />

            <div
            class="top-bar"
            role="navigation"
            aria-label="Breadcrumb and page header"
            >
            <div class="container">
              <nav
                class="breadcrumb"
                aria-label="Breadcrumb"
                style="margin-left: -1px"
              >
                <a href="home-page.html" aria-label="Trang Chủ">Trang Chủ</a>
                <svg
                  class="crumb-sep"
                  viewBox="0 0 24 24"
                  fill="none"
                  aria-hidden="true"
                >
                  <path
                    d="M9 6l6 6-6 6"
                    stroke="#8b8b8b"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
                <a href="home-page.html" aria-label="" style="width: 200px"></a>
              </nav>
            </div>
            </div>

            <div class="flex-grow-1">
              <!-- image slicer -->
              <section class="section-image-slider container-lg">
                <div id="imageCarousel" class="carousel slide" data-bs-ride="carousel">
                  <div class="carousel-indicators">
                    <button
                      type="button"
                      data-bs-target="#imageCarousel"
                      data-bs-slide-to="0"
                      class="active"
                    ></button>
                    <button
                      type="button"
                      data-bs-target="#imageCarousel"
                      data-bs-slide-to="1"
                    ></button>
                    <button
                      type="button"
                      data-bs-target="#imageCarousel"
                      data-bs-slide-to="2"
                    ></button>
                    <button
                      type="button"
                      data-bs-target="#imageCarousel"
                      data-bs-slide-to="3"
                    ></button>
                    <button
                      type="button"
                      data-bs-target="#imageCarousel"
                      data-bs-slide-to="4"
                    ></button>
                  </div>

                  <div class="carousel-inner">
                    <div class="carousel-item active">
                      <img
                        src="https://www.mykingdom.com.vn/cdn/shop/files/1._1280x496_0995ab58-0305-4974-9d00-81ca4c0c5b58.png?v=1760340080&width=535"
                        class="d-block w-100"
                        alt="Lego mega sale"
                      />
                    </div>
                    <div class="carousel-item">
                      <img
                        src="assets/images/banners/halloween-party-deal.png"
                        class="d-block w-100"
                        alt="Halloween Party Deal"
                      />
                    </div>
                    <div class="carousel-item">
                      <img
                        src="assets/images/banners/buy-1-get-2.png"
                        class="d-block w-100"
                        alt="Buy once get twice"
                      />
                    </div>
                    <div class="carousel-item">
                      <img
                        src="assets/images/banners/new-product.png"
                        class="d-block w-100"
                        alt="New toys"
                      />
                    </div>
                    <div class="carousel-item">
                      <img
                        src="assets/images/banners/super-sale-rain.png"
                        class="d-block w-100"
                        alt="Super sale rain"
                      />
                    </div>
                  </div>

                  <button
                    class="carousel-control-prev d-none d-md-flex"
                    type="button"
                    data-bs-target="#imageCarousel"
                    data-bs-slide="prev"
                  >
                    <i class="bi bi-caret-left-fill"></i>
                  </button>
                  <button
                    class="carousel-control-next d-none d-md-flex"
                    type="button"
                    data-bs-target="#imageCarousel"
                    data-bs-slide="next"
                  >
                    <i class="bi bi-caret-right-fill"></i>
                  </button>
                </div>
              </section>

              <!-- Lego -->
              <section class="lego container-lg">
                <h2 class="title inline-richtext">LEGO Mega Sale 2025</h2>

                <div class="center">
                  <a
                    href="product.html"
                    class="view-more-button"
                    aria-labe1="Xem toàn bộ sản phẩm trong bộ sưu tập LEGO_MEGA_SALE"
                    >Xem thêm <i class="bi bi-caret-right-fill"></i
                  ></a>
                </div>

                <!-- products -->
                <div class="container">
                  <div
                    id="legoCarousel"
                    class="carousel slide pt-2"
                    data-bs-ride="false"
                  >
                    <div class="carousel-inner">
                      <!-- Slide 1 -->
                      <div class="carousel-item active">
                        <div class="row g-4">
                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">-30%</span>
                              <img
                                src="assets/images/products/Kylo-Ren-helmet.png"
                                alt="Kylo-Ren-helmet"
                                class="product-image"
                              />
                              <div class="product-brand">
                                LEGO STAR WARS<span class="product-sku ps-3"
                                  >SKU:75415</span
                                >
                              </div>
                              <h3 class="product-title">
                                Đồ Chơi Lắp Ráp Mũ Giáp Kylo Ren LEGO STAR WARS 75415
                                (529 chi tiết)
                              </h3>
                              <div class="price-section">
                                <span class="current-price">1.350.300 Đ</span>
                                <span class="original-price">1.929.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>

                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">-30%</span>
                              <img
                                src="assets/images/products/Kawasaki-Ninja-H2.png"
                                alt="Kawasaki-Ninja-H2"
                                class="product-image"
                              />
                              <div class="product-brand">
                                LEGO TECHNIC<span class="product-sku ps-3"
                                  >SKU:42170</span
                                >
                              </div>
                              <h3 class="product-title">
                                Đồ chơi lắp ráp Xe thể thao Kawasaki Ninja H2®R
                                LEGO TECHNIC 42170
                              </h3>
                              <div class="price-section">
                                <span class="current-price">1.350.300 Đ</span>
                                <span class="original-price">1.929.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>

                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">-30%</span>
                              <img
                                src="assets/images/products/great-wave-Kanagawa.png"
                                alt="LEGO great-wave-Kanagawa"
                                class="product-image"
                              />
                              <div class="product-brand">
                                LEGO ART
                                <span class="product-sku ps-3">SKU:42207</span>
                              </div>
                              <h3 class="product-title">
                                Đồ Chơi Lắp Ráp Sóng Lừng Ngoài Khơi Kanagawa LEGO
                                ADULTS 31208
                              </h3>
                              <div class="price-section">
                                <span class="current-price">2.969.300 Đ</span>
                                <span class="original-price">4.099.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- Slide 2 -->
                      <div class="carousel-item">
                        <div class="row g-4">
                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">-30%</span>
                              <img
                                src="assets/images/products/Spanish-Garden.png"
                                alt="LEGO ADULTS Spanish-Garden"
                                class="product-image"
                              />
                              <div class="product-brand">
                                LEGO ADULTS
                                <span class="product-sku ps-3">SKU:10359</span>
                              </div>
                              <h3 class="product-title">
                                Đồ Chơi Lắp Ráp Khu Vườn Tây Ban Nha LEGO ADULTS 10359
                              </h3>
                              <div class="price-section">
                                <span class="current-price">3.170.300 Đ</span>
                                <span class="original-price">4.529.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>

                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">-25%</span>
                              <img
                                src="assets/images/products/Tantive-IV-battleship.png"
                                alt="LEGO STAR WARS Tantive-IV-battleship"
                                class="product-image"
                              />
                              <div class="product-brand">
                                LEGO STAR WARS
                                <span class="product-sku ps-3">SKU:75376</span>
                              </div>
                              <h3 class="product-title">
                                Đồ chơi lắp ráp Chiến hạm Tantive IV LEGO STAR WARS
                                75376
                              </h3>
                              <div class="price-section">
                                <span class="current-price">6.550.000 Đ</span>
                                <span class="original-price">8.400.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>

                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">-20%</span>
                              <img
                                src="assets/images/products/gara-f1-lego-city.png"
                                alt="LEGO Friends"
                                class="product-image"
                              />
                              <div class="product-brand">
                                LEGO CITY
                                <span class="product-sku ps-3">SKU:60444</span>
                              </div>
                              <h3 class="product-title">
                                Đồ Chơi Lắp Ráp Gara F1 LEGO CITY 60444
                              </h3>
                              <div class="price-section">
                                <span class="current-price">1.920.000 Đ</span>
                                <span class="original-price">2.400.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Controls -->
                    <button
                      class="carousel-control-prev"
                      type="button"
                      data-bs-target="#legoCarousel"
                      data-bs-slide="prev"
                    >
                      <i class="bi bi-caret-left-fill"></i>
                    </button>
                    <button
                      class="carousel-control-next"
                      type="button"
                      data-bs-target="#legoCarousel"
                      data-bs-slide="next"
                    >
                      <i class="bi bi-caret-right-fill"></i>
                    </button>
                  </div>
                </div>
              </section>

              <!-- new product -->
              <section class="container-lg">
                <h2 class="title inline-richtext">Hàng Mới Về - Bé Thích Mê</h2>

                <div class="center">
                  <a
                    href="product.html"
                    class="view-more-button"
                    aria-labe1="Xem toàn bộ sản phẩm trong bộ sưu tập LEGO_MEGA_SALE"
                    >Xem thêm <i class="bi bi-caret-right-fill"></i
                  ></a>
                </div>

                <!-- products -->
                <div class="container">
                  <div
                    id="newProductCarousel"
                    class="carousel slide pt-2"
                    data-bs-ride="false"
                  >
                    <div class="carousel-inner">
                      <!-- Slide 1 -->
                      <div class="carousel-item active">
                        <div class="row g-4">
                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">new</span>
                              <img
                                src="https://www.mykingdom.com.vn/cdn/shop/files/80-601300_c9eafcb5-8875-48a6-a68c-2724d40f59dd.jpg?v=1761196025&width=823"
                                alt="bus-toy"
                                class="product-image"
                              />
                              <div class="product-brand">
                                LEAPFROG
                                <span class="product-sku ps-3">SKU:31161</span>
                              </div>
                              <h3 class="product-title">
                                Xe bus vui học LEAPFROG 80-601300
                              </h3>
                              <div class="price-section">
                                <span class="current-price">750.300 Đ</span>
                                <span class="original-price">929.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>

                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">new</span>
                              <img
                                src="https://www.mykingdom.com.vn/cdn/shop/files/mo-hinh-sieu-anh-hung-spiderman-30cm-e7333.jpg?v=1721183849&width=823"
                                alt="spiderman"
                                class="product-image"
                              />
                              <div class="product-brand">
                                SPIDERMAN
                                <span class="product-sku ps-3">SKU:7333</span>
                              </div>
                              <h3 class="product-title">
                                Mô hình siêu anh hùng Spiderman 30cm SPIDERMAN E7333
                              </h3>
                              <div class="price-section">
                                <span class="current-price">150.300 Đ</span>
                                <span class="original-price">229.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>

                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">new</span>
                              <img
                                src="https://www.mykingdom.com.vn/cdn/shop/products/f1259_1_cadf6241-7f0c-4f2f-9ccd-c8a6379a479f.jpg?v=1751253945&width=990"
                                alt="playdoh"
                                class="product-image"
                              />
                              <div class="product-brand">
                                PLAYDOH
                                <span class="product-sku ps-3">SKU:42207</span>
                              </div>
                              <h3 class="product-title">
                                Nha khoa dễ thương phiên bản 65 năm PLAYDOH F1259
                              </h3>
                              <div class="price-section">
                                <span class="current-price">169.300 Đ</span>
                                <span class="original-price">399.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- Slide 2 -->
                      <div class="carousel-item">
                        <div class="row g-4">
                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">new</span>
                              <img
                                src="https://www.mykingdom.com.vn/cdn/shop/files/f50a3a95a6ed390e7ea87648944b67c0.jpg?v=1718246351&width=990"
                                alt="hotwheels"
                                class="product-image"
                              />
                              <div class="product-brand">
                                HOT WHEELS
                                <span class="product-sku ps-3">SKU:30303</span>
                              </div>
                              <h3 class="product-title">
                                Trạm vận chuyển 3 lốp xe xoay vòng Hot Wheels HOT WHEELS HDP02
                              </h3>
                              <div class="price-section">
                                <span class="current-price">3.170.300 Đ</span>
                                <span class="original-price">4.529.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>

                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">new</span>
                              <img
                                src="https://www.mykingdom.com.vn/cdn/shop/products/8852rb_1__1.jpg?v=1685096880&width=990"
                                alt="Rubik"
                                class="product-image"
                              />
                              <div class="product-brand">
                                SPIN GAMES
                                <span class="product-sku ps-3">SKU:8852</span>
                              </div>
                              <h3 class="product-title">
                                Đồ Chơi Rubik's 3x3 SPIN GAMES 8852RB
                              </h3>
                              <div class="price-section">
                                <span class="current-price">550.000 Đ</span>
                                <span class="original-price">800.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>

                          <div class="col-md-4">
                            <div class="product-card">
                              <span class="discount-badge">new</span>
                              <img
                                src="https://www.mykingdom.com.vn/cdn/shop/files/HCF33_36eb2574-71d1-424a-a7c2-433352a6bff3.jpg?v=1752452425&width=990"
                                alt="maytinhdochoi"
                                class="product-image"
                              />
                              <div class="product-brand">
                                FISHER PRICE MATTEL
                                <span class="product-sku ps-3">SKU:21338</span>
                              </div>
                              <h3 class="product-title">
                                Đồ chơi vui học máy tính xách tay có đèn và nhạc FISHER PRICE MATTEL HCF33
                              </h3>
                              <div class="price-section">
                                <span class="current-price">620.000 Đ</span>
                                <span class="original-price">910.000 Đ</span>
                              </div>
                              <div
                                class="action-buttons d-flex justify-content-between align-items-center gap-2"
                              >
                                <button class="btn btn-add-cart">
                                  Thêm Vào Giỏ Hàng
                                </button>
                                <button class="btn btn-wishlist">
                                  <i class="bi bi-heart"></i>
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Controls -->
                    <button
                      class="carousel-control-prev"
                      type="button"
                      data-bs-target="#newProductCarousel"
                      data-bs-slide="prev"
                    >
                      <i class="bi bi-caret-left-fill"></i>
                    </button>
                    <button
                      class="carousel-control-next"
                      type="button"
                      data-bs-target="#newProductCarousel"
                      data-bs-slide="next"
                    >
                      <i class="bi bi-caret-right-fill"></i>
                    </button>
                  </div>
                </div>
              </section>

              <!-- hot categories -->
              <section class="hot-categories container-lg">
                <h2 class="title inline-richtext mb-3">DANH MỤC HOT</h2>
                <div class="hot-items row g-3 mt-3">
                  <div class="col-6 col-md-3">
                    <div class="item position-relative">
                      <a href="#" class="d-block">
                        <img
                          src="assets/images/categories/halloween-party-lego-sets.png"
                          class="img-fluid w-100 rounded"
                          alt="Lego Halloween"
                        />
                      </a>

                      <span
                        class="position-absolute bottom-0 start-0 m-2 px-2 py-1 bg-dark bg-opacity-75 text-white rounded small"
                      >
                        Lego Halloween
                      </span>

                      <a
                        href="#"
                        class="btn btn-white position-absolute bottom-0 end-0 m-2 rounded-circle"
                      >
                        <i class="bi bi-arrow-right"></i>
                      </a>
                    </div>
                  </div>

                  <div class="col-6 col-md-3">
                    <div class="item position-relative">
                      <a href="#" class="d-block">
                        <img
                          src="assets/images/categories/intellectual-development.png"
                          class="img-fluid w-100 rounded"
                          alt="Đồ chơi phát triển trí tuệ"
                        />
                      </a>

                      <span
                        class="position-absolute bottom-0 start-0 m-2 px-2 py-1 bg-dark bg-opacity-75 text-white rounded small"
                      >
                        Phát Triển Trí Tuệ
                      </span>

                      <a
                        href="#"
                        class="btn btn-white position-absolute bottom-0 end-0 m-2 rounded-circle"
                      >
                        <i class="bi bi-arrow-right"></i>
                      </a>
                    </div>
                  </div>

                  <div class="col-6 col-md-3">
                    <div class="item position-relative">
                      <a href="#" class="d-block">
                        <img
                          src="assets/images/categories/kitchen-toys.png"
                          class="img-fluid w-100 rounded"
                          alt="Đồ chơi nhà bếp"
                        />
                      </a>

                      <span
                        class="position-absolute bottom-0 start-0 m-2 px-2 py-1 bg-dark bg-opacity-75 text-white rounded small"
                      >
                        Đồ Chơi Nhà Bếp
                      </span>

                      <a
                        href="#"
                        class="btn btn-white position-absolute bottom-0 end-0 m-2 rounded-circle"
                      >
                        <i class="bi bi-arrow-right"></i>
                      </a>
                    </div>
                  </div>

                  <div class="col-6 col-md-3">
                    <div class="item position-relative">
                      <a href="#" class="d-block">
                        <img
                          src="assets/images/categories/supercar-toys.png"
                          class="img-fluid w-100 rounded"
                          alt="Siêu xe đồ chơi"
                        />
                      </a>

                      <span
                        class="position-absolute bottom-0 start-0 m-2 px-2 py-1 bg-dark bg-opacity-75 text-white rounded small"
                      >
                        Siêu Xe Cho Bé
                      </span>

                      <a
                        href="#"
                        class="btn btn-white position-absolute bottom-0 end-0 m-2 rounded-circle"
                      >
                        <i class="bi bi-arrow-right"></i>
                      </a>
                    </div>
                  </div>
                </div>
              </section>

              <!-- Age -->
              <section>
                <div class="age container-lg">
                  <h2 class="title">Độ Tuổi</h2>
                  <div class="row justify-content-center g-4">
                    <div class="col-6 col-sm-4 col-md-2">
                      <div class="age-item">
                        <img
                          src="https://www.mykingdom.com.vn/cdn/shop/files/0-12_thang_117f6b5e-c1fd-48f3-af93-b6ade424058a_296x.png?v=1762138070"
                          alt="0-12 Tháng"
                        />
                      </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                      <div class="age-item">
                        <img
                          src="https://www.mykingdom.com.vn/cdn/shop/files/1-3_tu_i_0f8a12f7-7247-49f6-b23d-11a311dbf737_296x.png?v=1761933696"
                          alt="1-3 Tuổi"
                        />
                      </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                      <div class="age-item">
                        <img
                          src="https://www.mykingdom.com.vn/cdn/shop/files/3-6_tu_i_c57c5996-d605-4990-a6a6-56375d189393_296x.png?v=1761933696"
                          alt="3-6 Tuổi"
                        />
                      </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                      <div class="age-item">
                        <img
                          src="https://www.mykingdom.com.vn/cdn/shop/files/6-12_tu_i_d8f18a7b-b342-4725-983e-f44aedda50b2_296x.png?v=1761933696"
                          alt="6-12 Tuổi"
                        />
                      </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                      <div class="age-item">
                        <img
                          src="https://www.mykingdom.com.vn/cdn/shop/files/12_tu_i_bb7e9383-6b73-46b6-bf3b-f2fe6a7b5e09_296x.png?v=1761933696"
                          alt="12+ Tuổi"
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </section>

              <!-- hot deals -->
              <section>
                <div class="container-lg">
                  <h3 class="deal-section fw-bold title">Săn Deal Giá Sốc</h3>

                  <div class="deal-container">
                    <a href="#" class="deal-card">
                      <img
                        src="https://www.mykingdom.com.vn/cdn/shop/files/600_x_600_8fceeeda-89ca-49fc-9ebe-07fe29b855f7_296x.jpg?v=1761932777"
                        alt="Deal 1"
                      />
                    </a>

                    <a href="#" class="deal-card">
                      <img
                        src="https://www.mykingdom.com.vn/cdn/shop/files/600x600px_06ab5fdb-587a-4d18-a90c-88aa7fea1962_296x.jpg?v=1762528194"
                        alt="Deal 2"
                      />
                    </a>

                    <a href="#" class="deal-card">
                      <img
                        src="https://www.mykingdom.com.vn/cdn/shop/files/600_x_600_296x.png?v=1761880226"
                        alt="Deal 3"
                      />
                    </a>

                    <a href="#" class="deal-card">
                      <img
                        src="https://www.mykingdom.com.vn/cdn/shop/files/SAN_SALE_GIA_S_C_296x.png?v=1760339441"
                        alt="Deal 4"
                      />
                    </a>

                    <a href="#" class="deal-card">
                      <img
                        src="https://www.mykingdom.com.vn/cdn/shop/files/600x600px_dccc0e89-e287-4b13-a068-31a2247b3132_296x.jpg?v=1756656371"
                        alt="Deal 5"
                      />
                    </a>

                    <a href="#" class="deal-card">
                      <img
                        src="https://www.mykingdom.com.vn/cdn/shop/files/4._600x600_2f7c5dca-a989-4c65-b6b2-53ad50e05bbd_296x.png?v=1762421902"
                        alt="Deal 6"
                      />
                    </a>
                  </div>
                </div>
              </section>

              <section></section>
            </div>

            <jsp:include page="/common/footer.jsp" />
        </main>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</html>