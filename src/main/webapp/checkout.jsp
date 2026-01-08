<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <title>Thanh Toán - Toy World</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp" />
    <link rel="stylesheet" href="css/checkout.css" />
    <style>
      .navbar {
        padding: 0 !important;
      }
    </style>
    <fmt:setLocale value="vi_VN"/>
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
                <a href="/checkout" aria-label="Dạy Con Thông Minh" style="width: 200px; color:#444;">Thanh toán</a>
            </nav>
        </div>
    </div>

    <c:set var="user" value="${sessionScope.currentUser}"/>
    <c:set var="cart" value="${sessionScope.cart}"/>

    <div id="alert" class="alert alert-danger text-center d-none" role="alert">
        ${error}
    </div>

    <div class="container mt-4">
      <div class="row">
        <!-- Left Column - Forms -->
        <div class="col-lg-7">
          <!-- Account Info -->
          <div
            class="account-info-header mb-4 bg-white rounded d-flex justify-content-between align-items-center"
          >
            <div class="d-flex align-items-center">
              <span class="fw-bold me-2 rounded-circle">
                ${fn:substring(user.firstName, 0, 1)}
              </span>
              <span>${user.email}</span>
            </div>
          </div>

          <form id="checkoutForm" method="POST" action="${pageContext.request.contextPath}/checkout" onsubmit="return checkout(event)">
            <!-- Delivery Section -->
            <div class="form-section">
              <h2 class="section-title">Giao hàng</h2>
              <p class="section-subtitle">
                Địa chỉ này cũng sẽ được dùng làm địa chỉ thanh toán cho đơn hàng
                này.
              </p>

              <!-- Location Selects -->
              <div class="mb-3">
                <select id="province" class="form-select" name="province">
                  <option disabled>Tỉnh/TP</option>
                  <option>TPHCM</option>
                  <option>Lâm Đồng</option>
                  <option>Tiền Giang</option>
                  <option>Đồng Nai</option>
                  <c:if test="${not empty location}">
                    <option selected value="${location.province}"></option>
                  </c:if>
                </select>
              </div>

              <!-- Name Fields -->
              <div class="row mb-3 py-2">
                <div class="col-md-6">
                  <input id="firstName" type="text" class="form-control" placeholder="Tên" value="${user.firstName}" name="firstName"/>
                </div>
                <div class="col-md-6">
                  <input id="lastName" type="text" class="form-control" placeholder="Họ" value="${user.lastName}" name="lastName"/>
                </div>
              </div>

              <!-- Address -->
              <div class="mb-3">
                <input
                  id="address"
                  type="text"
                  class="form-control"
                  placeholder="Số nhà, tên đường"
                  value="${location.address}"
                  name="address"
                />
              </div>

              <!-- Phone -->
              <div class="mb-3">
                <input id="phone" type="tel" class="form-control" placeholder="Điện thoại" value="${user.phone}" name="phone"/>
              </div>

              <!-- Notes -->
              <div class="mt-3">
                <textarea
                        class="form-control"
                        rows="3"
                        placeholder="Ghi chú / Notes"
                        name="notes"
                ></textarea>
              </div>

              <div class="alert alert-info mt-3">
                <i class="fas fa-info-circle"></i>
                Theo quy định: Theo quy định, Toy World chỉ xuất hóa đơn trong
                ngày nhập hàng. Quý khách cần hóa đơn vui lòng cung cấp thông tin
                trước khi hoàn tất thanh toán.
              </div>
            </div>

            <!-- Payment Method -->
            <div class="form-section">
              <div class="payment-container" style="max-width: 900px">
                <c:forEach var="method" items="${paymentMethods}">
                  <div class="payment-option" id="${method.name}">
                    <div class="payment-header" onclick="selectPayment('${method.name}')">
                      <div class="radio-circle"></div>
                      <div class="payment-content">
                        <h3 class="payment-title">
                          ${method.name}
                        </h3>
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </div>

              <button class="btn-checkout" type="submit">Thanh toán ngay</button>
            </div>
          </form>
        </div>

        <!-- Right Column - Order Summary -->
        <div class="col-lg-5">
          <div class="order-summary">
            <!-- Product Item -->
            <c:forEach var="item" items="${cart.cartItems}">
              <div class="product-item">
                <div style="position: relative">
                  <img
                    src="${item.cartProductDTO.imgPath}"
                    class="product-image"
                    alt="${item.cartProductDTO.name}"
                  />
                  <div class="product-badge" >${item.quantity}</div>
                </div>
                <div class="product-info">
                  <div class="product-name">
                    ${item.cartProductDTO.name}
                  </div>
                </div>
                <div class="product-price">
                  <fmt:formatNumber value="${item.cartProductDTO.price}" type="currency" currencyCode="VND"/>
                </div>
              </div>
            </c:forEach>

            <!-- Summary -->
            <div class="summary-row">
              <span>Tổng tiền hàng</span>
              <span><fmt:formatNumber value="${cart.totalCost}" type="currency" currencyCode="VND"/></span>
            </div>
            <div class="summary-row">
              <span>Giảm giá</span>
              <c:choose>
                <c:when test="${cart.totalPromotion != 0}">
                  <span style ="color: #cf102d;">
                    - <fmt:formatNumber value="${cart.totalPromotion}" type="currency" currencyCode="VND"/>
                  </span>
                </c:when>
                <c:otherwise>
                  <span>
                    <fmt:formatNumber value="${cart.totalPromotion}" type="currency" currencyCode="VND"/>
                  </span>
                </c:otherwise>
              </c:choose>
            </div>
            <div class="summary-row summary-total">
              <span>Tổng tiền</span>
              <span class="total-amount">
                <fmt:formatNumber value="${cart.totalPrice}" type="currency" currencyCode="VND"/>
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="/common/footer.jsp" />
    <script src="js/checkout.js"></script>
  </body>
</html>
