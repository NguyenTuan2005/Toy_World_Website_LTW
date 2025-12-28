<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

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

            <div class="top-bar" role="navigation"   aria-label="Breadcrumb and page header" >
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
                <a href="${pageContext.request.contextPath}/products" aria-label="" style="width: 200px"></a>
              </nav>
            </div>
            </div>

            <div class="flex-grow-1">
              <!-- image slicer -->
              <section class="section-image-slider container-lg">
                <div id="imageCarousel" class="carousel slide pt-4" data-bs-ride="carousel">
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
                      <c:forEach var="banner" items="${banners}">
                        <div class="carousel-item active">
                          <img src="${banner}"
                                  class="d-block w-100"
                                  alt="Lego mega sale"
                          />
                        </div>
                      </c:forEach>
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
              <c:if test="${not empty signatureProducts}">
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
                    <div id="legoCarousel" class="carousel  pt-2"  data-bs-ride="false">
                      <div class="carousel-inner">
                        <!-- Slide 1 -->
                        <div class="carousel-item active">
                          <div class="row g-4">


                            <c:forEach var="p" items="${signatureProducts}" varStatus="counter" >
                              <div id ="${counter.count}" class="col-md-4 product-status-s  cursor-pointer"  >
                                <div class="product-card">
                                  <span class="discount-badge">
                                    <fmt:formatNumber value="${p.discountPercent / 100}" type="percent"/>
                                  </span>
                                  <img     src="${not empty p.imageUrl ? p.imageUrl : 'https://tse1.mm.bing.net/th/id/OIP.68XqK3UF8kLZR8p1JXq8ZAAAAA?cb=ucfimg2&ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3'}"    alt="Kylo-Ren-helmet" class="product-image" />
                                  <div class="product-brand">
                                      ${p.brandName}
                                    <span class="product-sku ps-3"></span
                                    >
                                  </div>
                                  <h3 title="${p.name}" class="product-title text-truncate "> ${p.name}
                                  </h3>
                                  <div class="price-section">
                                    <span class="current-price">
                                          <fmt:formatNumber value="${p.currentPrice}" type="currency" currencyCode="VND"/>
                                    </span>
                                    <span class="original-price">
                                            <fmt:formatNumber value="${p.originalPrice}" type="currency" currencyCode="VND"/>
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
                                    <button class="btn btn-wishlist">
                                      <i class="bi bi-heart"></i>
                                    </button>
                                  </div>
                                </div>
                              </div>

                            </c:forEach>

                          </div>
                        </div>
                      </div>




                      <button class="carousel-control-prev"  type="button"   onclick="prevProductsForLego()">
                        <i class="bi bi-caret-left-fill"></i>
                      </button>
                      <button  class="carousel-control-next" type="button" onclick="nextProductsForLego()">
                        <i class="bi bi-caret-right-fill"></i>
                      </button>
                    </div>
                  </div>
                </section>

              </c:if>


              <c:if test="${not empty newProductsInMonth}">
                <!-- new product -->
                <section class="container-lg">

                  <h2 class="title d-flex align-items-center justify-content-center gap-2 text-center">
                    Sản phẩm mới về - Bé thích mê
                  </h2>

                  <div class="center">
                    <a href="product.html" class="view-more-button"  aria-labe1="Xem toàn bộ sản phẩm trong bộ sưu tập LEGO_MEGA_SALE">Xem thêm <i class="bi bi-caret-right-fill"></i></a>
                  </div>

                  <!-- products -->
                  <div class="container">
                    <div id="new-product" class="carousel  pt-2"  data-bs-ride="false">
                      <div class="carousel-inner">
                        <!-- Slide 1 -->
                        <div class="carousel-item active">
                          <div class="row g-4">


                            <c:forEach var="p" items="${newProductsInMonth}" varStatus="counter">
                              <div id ="${counter.count}" class="col-md-4 product-status  cursor-pointer"  >
                                <div class="product-card">
                                  <span class="discount-badge">
                                    <fmt:formatNumber value="${p.discountPercent / 100}" type="percent"/>
                                  </span>
                                  <img     src="${not empty p.imageUrl ? p.imageUrl : 'https://tse1.mm.bing.net/th/id/OIP.68XqK3UF8kLZR8p1JXq8ZAAAAA?cb=ucfimg2&ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3'}"    alt="Kylo-Ren-helmet" class="product-image" />
                                  <div class="product-brand">
                                      ${p.brandName}
                                    <span class="product-sku ps-3"></span
                                    >
                                  </div>
                                  <h3 title="${p.name}" class="product-title text-truncate "> ${p.name}
                                  </h3>
                                  <div class="price-section">
                                    <span class="current-price">
                                          <fmt:formatNumber value="${p.currentPrice}" type="currency" currencyCode="VND"/>
                                    </span>
                                    <span class="original-price">
                                            <fmt:formatNumber value="${p.originalPrice}" type="currency" currencyCode="VND"/>
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
                                    <button class="btn btn-wishlist">
                                      <i class="bi bi-heart"></i>
                                    </button>
                                  </div>
                                </div>
                              </div>

                            </c:forEach>

                          </div>
                        </div>
                      </div>


                      <button class="carousel-control-prev"  type="button"   onclick="prevProducts()">
                        <i class="bi bi-caret-left-fill"></i>
                      </button>
                      <button  class="carousel-control-next" type="button" onclick="nextProducts()">
                        <i class="bi bi-caret-right-fill"></i>
                      </button>
                    </div>
                  </div>

                </section>
              </c:if>

            </div>

            <jsp:include page="/common/footer.jsp" />
        </main>
    </body>

    <script>
      const ITEMS_PER_PAGE = 3;
      let currentIndex = 0;

      const products = document.querySelectorAll('.product-status');
      const totalProducts = products.length;

      function renderProducts() {
        // Ẩn tất cả
        products.forEach(p => p.classList.add('d-none'));

        // Hiện 3 sản phẩm theo currentIndex
        for (let i = currentIndex; i < currentIndex + ITEMS_PER_PAGE; i++) {
          if (products[i]) {
            products[i].classList.remove('d-none');
            console.log(i+"load for new products")
          }
        }
      }

      function nextProducts() {
        if (currentIndex + ITEMS_PER_PAGE < totalProducts) {
          currentIndex += ITEMS_PER_PAGE;
          renderProducts();
        }
      }

      function prevProducts() {
        if (currentIndex - ITEMS_PER_PAGE >= 0) {
          currentIndex -= ITEMS_PER_PAGE;
          renderProducts();
        }
      }

      // Init khi load trang
      document.addEventListener('DOMContentLoaded', renderProducts);
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




    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</html>