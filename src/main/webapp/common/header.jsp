<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header class="bg-white shadow-sm">
    <div class="container-fluid py-2 root-red-background">
       <div class="d-flex align-items-center justify-content-center flex-wrap">
          <!-- Logo -->
          <div class="d-flex align-items-center">
             <img
                src="${pageContext.request.contextPath}/assets/ToyWorldLogo.png"
                alt="Logo"
                class="img-fluid"
                onclick="window.location.href='home-page.html'"
                style="width: 170px; height: 50px"
                />
          </div>
          <!-- Logo -->
          <!-- Search bar -->
          <div class="flex-grow-1 mx-4" style="max-width: 470px">
             <div class="input-group">
                <span class="input-group-text bg-white border-end-0">
                <img
                   src="https://cdn-icons-png.flaticon.com/512/622/622669.png"
                   alt="Search"
                   width="18"
                   height="18"
                   />
                </span>
                <input
                   type="text"
                   class="form-control border-start-0"
                   placeholder="Nhập từ khóa để tìm kiếm (ví dụ: lắp ráp, mô hình, ba lô,...)"
                   />
             </div>
          </div>
          <style>

          </style>
          <!-- Account + Cart -->
          <div class="header-section text-center">
             <div class="d-flex justify-content-center align-items-center gap-4">
                <!-- Login -->
                <a class="btn d-flex align-items-center" href="login.html">
                   <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="currentColor"
                      class="bi bi-person-circle me-2"
                      viewBox="0 0 16 16"
                      >
                      <path d="M11 10a2 2 0 1 0-6 0 6 6 0 1 0 6 0z" />
                      <path
                         fill-rule="evenodd"
                         d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0zm0 1a7 7 0 1 1 0 14A7 7 0 0 1 8 1z"
                         />
                   </svg>
                   Đăng nhập
                </a>
                <!-- Cart -->
                <a class="btn d-flex align-items-center" href="my-shopping-cart.html">
                   <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="currentColor"
                      class="bi bi-cart3 me-2"
                      viewBox="0 0 16 16"
                      >
                      <path
                         d="M0 1.5A.5.5 0 0 1 .5 1h1a.5.5 0 0 1 .485.379L2.89 6H14.5a.5.5 0 0 1 .49.598l-1.5 7A.5.5 0 0 1 13 14H4a.5.5 0 0 1-.491-.408L1.01 2H.5a.5.5 0 0 1-.5-.5zm3.14 5l1.313 6h8.093l1.2-5.6H3.14z"
                         />
                      <path
                         d="M6 16a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"
                         />
                   </svg>
                   Giỏ hàng
                </a>
                <button
                   class="navbar-toggler d-md-block d-lg-none me-3"
                   type="button"
                   data-bs-toggle="collapse"
                   data-bs-target="#navbarContent"
                   aria-controls="navbarContent"
                   aria-expanded="false"
                   aria-label="Toggle navigation"
                   >
                <span class="navbar-toggler-icon"></span>
                </button>
             </div>
          </div>
       </div>
       <!-- Navbar -->
       <nav class="navbar navbar-expand-lg navbar-light root-red-background">
          <div
             class="container-fluid root-red-background d-flex align-items-center"
             >
             <!-- Menu - ẩn khi màn hình nhỏ -->
             <div
                class="collapse navbar-collapse justify-content-center"
                id="navbarContent"
                >
                <ul class="navbar-nav fw-bold text-uppercase gap-3">
                   <li class="nav-item mx-2">
                      <a
                         class="nav-link text-white d-flex align-items-center"
                         href="product.html"
                         >
                      Sản Phẩm
                      <img
                         src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/icon-lego.gif?v=1743483192"
                         class="ms-2"
                         width="28"
                         height="25"
                         />
                      </a>

                   </li>
                   <li class="nav-item mx-2">
                      <a
                         class="nav-link text-white d-flex align-items-center"
                         href="promotion.html"
                         >
                      Khuyến Mãi
                      <img
                         src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/Animation_-_1712303911997.gif?v=1712307455"
                         class="ms-2"
                         width="28"
                         height="25"
                         />
                      </a>
                   </li>
                   <li class="nav-item dropdown mx-2">
                      <a
                         class="nav-link  text-white"
                         href="vouchers.html"
                         >
                      Vouchers
                      </a>
                   </li>
                   <li class="nav-item mx-2">
                      <a class="nav-link text-white" href="brand.html">Thương hiệu</a>
                   </li>
                   <li class="nav-item mx-2">
                      <a class="nav-link text-white" href="handbook.html">Cẩm nang</a>
                   </li>
                      <li class="nav-item mx-2">
                      <a class="nav-link text-white" href="contact.html">Giới thiệu</a>
                   </li>
                </ul>
             </div>
          </div>
       </nav>
    </div>
</header>
