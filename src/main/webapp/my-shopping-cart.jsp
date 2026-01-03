<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
  <head>
    <title>Giỏ Hàng Của Bạn</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp" />
    <link rel="stylesheet" href="css/my-shopping-cart.css" />
  </head>
  <body>
    <jsp:include page="/common/header.jsp" />

    <div class="top-bar" role="navigation" aria-label="Breadcrumb and page header">
        <div class="container">
            <nav class="breadcrumb" aria-label="Breadcrumb" style="margin-left: -1px; ">
                <a href="/home" aria-label="Trang Chủ">Trang Chủ</a>
                <svg class="crumb-sep" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                    <path d="M9 6l6 6-6 6" stroke="#8b8b8b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <a href="/cart" aria-label="Dạy Con Thông Minh" style="width: 235px; color:#444;">Giỏ Hàng</a>
            </nav>
        </div>
    </div>

    <div class="container py-4">
      <div class="row">
        <!--Cart Items -->
        <div class="col-lg-8">
          <div class="cart-container mb-md-5">
            <div
              class="cart-header d-flex justify-content-between align-items-center mb-1 px-2 pb-2"
            >
              <img
                src="${pageContext.request.contextPath}/assets/ToyWorldLogo.png"
                alt="Logo TOY WORLD"
                class="img-fluid"
                style="max-width: 100px"
              />
            </div>

            <!-- Product Item -->
            <c:forEach var="cartItem" items="${cart.cartItems}">
              <div class="product-item">
                <img
                  src="${cartItem.cartProductDTO.imgPath}"
                  alt="${cartItem.cartProductDTO.name}"
                  class="product-image"
                />
                <div class="product-details">
                  <div class="product-title">
                      ${cartItem.cartProductDTO.name}
                  </div>
                  <div class="quantity-control">
                    <span class="quantity-label">Số lượng</span>
                    <button class="quantity-btn" onclick="decreaseQty()">
                      −
                    </button>
                    <input
                      type="number"
                      class="quantity-input"
                      id="quantity"
                      value="${cartItem.quantity}"
                      min="1"
                      readonly
                    />
                    <button class="quantity-btn" onclick="increaseQty()">
                      +
                    </button>
                  </div>

                  <div
                    class="product-price d-flex justify-content-between align-items-center mt-3"
                  >
                    <button class="remove-btn" onclick="removeItem()">Xóa</button>
                    <span id="itemPrice">
                      <fmt:setLocale value="vi_VN"/>
                      <fmt:formatNumber value="${cartItem.cartProductDTO.price}" type="currency" currencyCode="VND"/>
                    </span>
                  </div>
                </div>
              </div>
            </c:forEach>

            <div class="total-items">
              Tổng cộng: <span id="totalItems">${cart.totalQuantity}</span> Sản phẩm
            </div>

            <div class="continue-shopping">
              <a href="/home" class="continue-shopping">
                <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
              </a>
            </div>
          </div>
        </div>

        <!--Order Summary -->
        <div class="col-lg-4">
          <div class="summary-section">
            <div class="summary-row">
              <span>Tiền hàng hoá</span>
              <span id="subtotal">
                <fmt:formatNumber value="${cart.totalCost}" type="currency" currencyCode="VND"/>
              </span>
            </div>
            <div class="summary-row discount">
              <span>Giảm giá</span>
              <span>0</span>
            </div>
            <div class="summary-row total">
              <span>Tổng cộng</span>
              <span class="amount"><span id="total">1.259.300</span> ₫</span>
            </div>

            <div class="terms-checkbox">
              <input type="checkbox" id="terms" checked />
              <label for="terms">
                Tôi đã đọc và đồng ý với <strong class="text-danger">Chính sách bảo mật</strong> và
                <strong class="text-danger">Điều kiện thanh toán</strong>
              </label>
            </div>

            <a href ="checkout.html">
              <button class ="checkout-btn">
                  Thanh toán ngay
              </button>
            </a>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="/common/footer.jsp" />
  </body>
</html>
