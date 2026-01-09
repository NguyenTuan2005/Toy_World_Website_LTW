<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <title>Giỏ Hàng Của Bạn</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp" />
    <link rel="stylesheet" href="css/my-shopping-cart.css" />
    <fmt:setLocale value="vi_VN"/>
  </head>
  <body>
    <jsp:include page="/common/header.jsp" />

    <div class="top-bar" role="navigation" aria-label="Breadcrumb and page header">
        <div class="container">
            <nav class="breadcrumb" aria-label="Breadcrumb" style="margin-left: -1px; ">
                <a href="${pageContext.request.contextPath}/home" aria-label="Trang Chủ">Trang Chủ</a>
                <svg class="crumb-sep" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                    <path d="M9 6l6 6-6 6" stroke="#8b8b8b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <a href="${pageContext.request.contextPath}/cart" aria-label="Dạy Con Thông Minh" style="width: 235px; color:#444;">Giỏ Hàng</a>
            </nav>
        </div>
    </div>

    <c:set var="cart" value="${sessionScope.cart}" />

    <c:choose>
      <c:when test="${not empty error}">
        <div id="alert" class="alert alert-danger text-center mb-4" role="alert">
            ${error}
        </div>
      </c:when>
      <c:otherwise>
        <div id="alert" class="alert alert-danger text-center mb-4 d-none" role="alert"></div>
      </c:otherwise>
    </c:choose>

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

              <div class="continue-shopping">
                <a href="${pageContext.request.contextPath}/home" class="continue-shopping">
                  <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                </a>
              </div>
            </div>

            <!-- Product Item -->
            <c:forEach var="cartItem" items="${cart.cartItems}">
              <div id="${cartItem.cartProductDTO.productId}" class="product-item">
                <img
                  src="${cartItem.cartProductDTO.imgPath}"
                  alt="${cartItem.cartProductDTO.name}"
                  class="product-image"
                />
                <div class="product-details">
                  <div class="hstack align-items-start">
                    <div class="product-title text-wrap" title="${cartItem.cartProductDTO.name}">
                        ${cartItem.cartProductDTO.name}
                    </div>
                    <button class="ms-auto mt-0 remove-btn" title="Xóa" onclick="removeItem(${cartItem.cartProductDTO.productId})"><i class="fa fa-trash"></i></button>
                  </div>
                  <div class="quantity-control">
                    <span class="quantity-label">Số lượng</span>
                    <button class="quantity-btn" onclick="updateQty(${cartItem.cartProductDTO.productId}, parseInt(this.parentElement.querySelector('#quantity').value) - 1)">
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
                    <button class="quantity-btn" onclick="updateQty(${cartItem.cartProductDTO.productId}, parseInt(this.parentElement.querySelector('#quantity').value) + 1)">
                      +
                    </button>
                  </div>

                  <div
                    class="product-price d-flex justify-content-between align-items-center mt-3"
                  >
                    <small>Giá sản phẩm: </small>
                    <span id="itemPrice">
                      <fmt:formatNumber value="${cartItem.cartProductDTO.price}" type="currency" currencyCode="VND"/>
                    </span>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>

        <!--Order Summary -->
        <div class="col-lg-4">
          <div class="summary-section">
            <c:if test="${not empty cart.cartItems}">
              <div class="total-items hstack justify-content-between">
                <span>Tổng số: </span>
                <span id="totalItems">${cart.totalQuantity} Sản phẩm</span>
              </div>
              <hr>
            </c:if>
            <div class="summary-row">
              <span>Tiền hàng hoá</span>
              <span id="subtotal">
                <c:choose>
                  <c:when test="${not empty cart.cartItems}">
                    <fmt:formatNumber value="${cart.totalCost}" type="currency" currencyCode="VND"/>
                  </c:when>
                  <c:otherwise>
                    <fmt:formatNumber value="0" type="currency" currencyCode="VND"/>
                  </c:otherwise>
                </c:choose>
              </span>
            </div>
            <div class="summary-row discount">
              <span>Giảm giá</span>
                <c:choose>
                  <c:when test="${not empty cart.cartItems and cart.totalPromotion != 0}">
                    <span style ="color: #cf102d;">
                      - <fmt:formatNumber value="${cart.totalPromotion}" type="currency" currencyCode="VND"/>
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span>
                      <fmt:formatNumber value="0" type="currency" currencyCode="VND"/>
                    </span>
                  </c:otherwise>
                </c:choose>
            </div>
            <div class="summary-row total">
              <span>Tổng cộng</span>
              <span id="total" class="amount">
                <c:choose>
                  <c:when test="${not empty cart.cartItems}">
                    <fmt:formatNumber value="${cart.totalPrice}" type="currency" currencyCode="VND"/>
                  </c:when>
                  <c:otherwise>
                    <fmt:formatNumber value="0" type="currency" currencyCode="VND"/>
                  </c:otherwise>
                </c:choose>
              </span>
            </div>

            <div class="terms-checkbox">
              <input type="checkbox" id="terms" checked />
              <label for="terms">
                Tôi đã đọc và đồng ý với <strong class="text-danger">Chính sách bảo mật</strong> và
                <strong class="text-danger">Điều kiện thanh toán</strong>
              </label>
            </div>

            <c:choose>
              <c:when test="${not empty cart.cartItems}">
                <a href="${pageContext.request.contextPath}/checkout">
                  <button class="checkout-btn">
                    Thanh toán ngay
                  </button>
                </a>
              </c:when>
              <c:otherwise>
                <button id="emptyCartBtn" class="checkout-btn" >
                  Thanh toán ngay
                </button>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>

    <!-- Confirm Modal -->
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

          <div class="modal-header">
            <h5 class="modal-title">Xác nhận</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>

          <div class="modal-body" id="confirmMessage">
          </div>

          <div class="modal-footer">
            <button type="button" class="btn btn-sm btn-outline-secondary" id="confirmCancel">
              Hủy
            </button>
            <button type="button" class="btn btn-sm btn-danger" id="confirmOk">
              Xóa
            </button>
          </div>

        </div>
      </div>
    </div>


    <jsp:include page="/common/footer.jsp" />
    <script>
      const contextPath = '${pageContext.request.contextPath}';
      const emptyCartBtn = document.getElementById('emptyCartBtn');
      if (emptyCartBtn) {
        emptyCartBtn.addEventListener('click', () => showAlert('Giỏ hàng trống'));
      }
    </script>
    <script src="js/cart.js"></script>
  </body>
</html>
