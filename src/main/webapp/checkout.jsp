<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <title>Thanh Toán - Toy World</title>
    <<link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp" />
    <link rel="stylesheet" href="css/checkout.css" />
    <style>
      .navbar {
        padding: 0 !important;
      }
    </style>
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

    <div class="container mt-4">
      <div class="row">
        <!-- Left Column - Forms -->
        <div class="col-lg-7">
          <!-- Account Info -->
          <div
            class="account-info-header mb-4 bg-white rounded d-flex justify-content-between align-items-center"
          >
            <div class="d-flex align-items-center">
              <span class="fw-bold me-2 rounded-circle">AB</span>
              <span>abc123@gmail.com</span>
            </div>
            <button
              class="btn btn-link text-dark p-0"
              style="font-size: 1.5rem; text-decoration: none"
            >
              ⋮
            </button>
          </div>

          <!-- Delivery Section -->
          <div class="form-section">
            <h2 class="section-title">Giao hàng</h2>
            <p class="section-subtitle">
              Địa chỉ này cũng sẽ được dùng làm địa chỉ thanh toán cho đơn hàng
              này.
            </p>

            <!-- Location Selects -->
            <div class="row mb-3">
              <div class="col-md-6">
                <select class="form-select">
                  <option>Tỉnh/TP</option>
                </select>
              </div>
              <div class="col-md-6">
                <select class="form-select">
                  <option>Quốc gia/Vùng</option>
                  <option selected>Việt Nam</option>
                </select>
              </div>
              
            </div>

  
      

            <!-- Name Fields -->
            <div class="row mb-3 py-2">
              <div class="col-md-6">
                <input type="text" class="form-control" placeholder="Tên" />
              </div>
              <div class="col-md-6">
                <input type="text" class="form-control" placeholder="Họ" />
              </div>
            </div>

            <!-- Address -->
            <div class="mb-3">
              <input
                type="text"
                class="form-control"
                placeholder="Số nhà, tên đường"
              />
            </div>

            <!-- Phone -->
            <div class="mb-3">
              <input type="tel" class="form-control" placeholder="Điện thoại" />
            </div>
          </div>

          <!-- Shipping Method -->
          <div class="form-section">
            <h2 class="section-title">Phương thức vận chuyển</h2>

            <div class="shipping-method selected">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <strong>VTA Tiêu Chuẩn (miễn phí)</strong>
                  <div class="text-muted small">
                    Nội thành (1-3 ngày), ngoại thành (3-5 ngày), biên lấn (5-7
                    ngày)
                  </div>
                </div>
                <span class="badge">MIỄN PHÍ</span>
              </div>
            </div>

            <div class="form-check">
              <input class="form-check-input" type="checkbox" id="vat" />
              <label class="form-check-label" for="vat">
                Yêu cầu xuất thông tin VAT
              </label>
            </div>

            <div class="alert alert-info mt-3">
              <i class="fas fa-info-circle"></i>
              Theo quy định: Theo quy định, Toy World chỉ xuất hóa đơn trong
              ngày nhập hàng. Quý khách cần hóa đơn vui lòng cung cấp thông tin
              trước khi hoàn tất thanh toán.
            </div>

            <!-- Notes -->
            <div class="mt-3">
              <textarea
                class="form-control"
                rows="3"
                placeholder="Ghi chú / Notes"
              ></textarea>
            </div>
          </div>

          <!-- Payment Method -->
          <div class="form-section">
            <div class="payment-container" style="max-width: 900px">
              <!-- payment method 1 -->
              <div class="payment-option active" id="payment1">
                <div class="payment-header" onclick="selectPayment('payment1')">
                  <div class="radio-circle"></div>
                  <div class="payment-content">
                    <div
                      class="d-flex justify-content-between align-items-start flex-wrap gap-2"
                    >
                      <div>
                        <h3 class="payment-title">
                          Cổng thanh toán Online ZaloPay
                        </h3>
                        <p class="payment-subtitle">
                          (Visa, Master, JCB, QR, thẻ ATM)
                        </p>
                      </div>
                      <div class="payment-logos">
                        <img
                          src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/200px-Mastercard-logo.svg.png"
                          alt="Mastercard"
                        />
                        <img
                          src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/JCB_logo.svg/200px-JCB_logo.svg.png"
                          alt="JCB"
                        />
                        <img
                          src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/200px-Visa_Inc._logo.svg.png"
                          alt="Visa"
                        />
                        <span class="plus-badge">+2</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="payment-details">
                  <div class="payment-info-box">
                    <svg class="browser-icon" viewBox="0 0 100 80" fill="none">
                      <rect
                        x="10"
                        y="15"
                        width="80"
                        height="50"
                        rx="3"
                        stroke="currentColor"
                        stroke-width="2"
                        fill="white"
                      />
                      <line
                        x1="10"
                        y1="25"
                        x2="90"
                        y2="25"
                        stroke="currentColor"
                        stroke-width="2"
                      />
                      <circle cx="17" cy="20" r="2" fill="currentColor" />
                      <circle cx="24" cy="20" r="2" fill="currentColor" />
                      <circle cx="31" cy="20" r="2" fill="currentColor" />
                      <path
                        d="M60 40 L75 40 M75 40 L70 35 M75 40 L70 45"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>

                    <p class="payment-info-text">
                      Sau khi nhấp vào "<strong>Thanh toán ngay</strong>", bạn
                      sẽ được chuyển hướng đến Cổng thanh toán Online ZaloPay
                      (Visa, Master, JCB, QR, thẻ ATM) để hoàn tất việc mua hàng
                      một cách an toàn.
                    </p>
                  </div>
                </div>
              </div>

              <!-- payment method 2 -->
              <div class="payment-option" id="payment2">
                <div class="payment-header" onclick="selectPayment('payment2')">
                  <div class="radio-circle"></div>
                  <div class="payment-content">
                    <h3 class="payment-title">
                      Thanh toán khi nhận hàng (COD)
                    </h3>
                  </div>
                </div>
              </div>
            </div>

            <button class="btn-checkout">Thanh toán ngay</button>

            <div class="footer-links text-center">
              <a href="#">Chính sách hoàn tiền</a>
              <a href="#">Vận chuyển</a>
              <a href="#">Chính sách quyền riêng tư</a>
              <a href="#">Điều khoản dịch vụ</a>
              <a href="#">Liên hệ</a>
            </div>
          </div>
        </div>

        <!-- Right Column - Order Summary -->
        <div class="col-lg-5">
          <div class="order-summary">
            <!-- Product Item -->
            <div class="product-item">
              <div style="position: relative">
                <img
                  src="assets/images/products/crane-man-bruder.png"
                  class="product-image"
                  alt="Product"
                />
                <div class="product-badge">1</div>
              </div>
              <div class="product-info">
                <div class="product-name">
                  Đồ chơi mô hình xe tỉ lệ 1 6 xe cần cẩu Man TGA BRUDER
                </div>
                <div class="product-code">Mã sản phẩm: 02754</div>
              </div>
              <div class="product-price">1.259.300 đ</div>
            </div>

            <!-- Discount Code -->
            <div class="d-flex gap-3 mt-3">

              <div class="discount-code">
                <div class="voucher-mini p-3 d-flex align-items-center">
                  <div class="voucher-icon me-3">
                    <i class="bi bi-gift"></i>
                  </div>
                  <div>
                    <h6 class="fw-bold mb-1">Giảm 16%</h6>
                    <p class="text-muted small mb-0 text-nowrap">
                     tối đa 500K đ
                    </p>
                  </div>
                </div>
              </div>
         
            </div>

            <!-- Summary -->
            <div class="summary-row">
              <span>Tổng tiền hàng</span>
              <span>1.259.300 đ</span>
            </div>
            <div class="summary-row">
              <span>Phiếu giảm giá</span>
              <span style ="color: #cf102d;">-500.000 đ</span>
            </div>
            <div class="summary-row summary-total">
              <span>Tổng tiền</span>
              <span class="total-amount">VNĐ 739.300 đ</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="/common/footer.jsp" />
    <script>
      function selectPayment(paymentId) {
        document.querySelectorAll(".payment-option").forEach((option) => {
          option.classList.remove("active");
        });

        document.getElementById(paymentId).classList.add("active");
      }
    </script>
  </body>
</html>
