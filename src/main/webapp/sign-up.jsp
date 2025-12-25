<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <title>Đăng ký</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp" />
    <link rel="stylesheet" href="css/sign-up.css"/>
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
              <a href="/sign-up" aria-label="Dạy Con Thông Minh" style="width: 235px; color:#444;">Đăng Ký</a>
           </nav>
        </div>
     </div>

     <div class="form-container">
        <h2>Đăng ký</h2>

        <c:if test="${not empty error}">
          <div id="serverError" class="alert alert-danger" role="alert">
            ${error}
          </div>
        </c:if>

        <form id="signupForm" onsubmit="return handleSignUpEvent(event)" method="post">
          <div class="row mb-3">
            <div class="col">
              <label for="firstName" class="form-label">Tên<span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="firstName" name="firstName" value="${param.firstName}" placeholder="Nhập tên" required>
            </div>
            <div class="col">
              <label for="lastName" class="form-label">Họ<span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="lastName" name="lastName" value="${param.lastName}" placeholder="Nhập họ" required>
            </div>
          </div>

          <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại<span class="text-danger">*</span></label>
            <input type="tel" class="form-control" id="phone" name="phone" value="${param.phone}" placeholder="Nhập số điện thoại" required
            oninput="document.getElementById('phoneError').classList.add('d-none'); this.classList.remove('is-invalid','is-valid');">
            <div id="phoneError" class="invalid-feedback d-none">
                Số điện thoại không hợp lệ.
            </div>
          </div>

          <div class="mb-3">
            <label for="gender" class="form-label">Giới tính<span class="text-danger">*</span></label>
            <select class="form-select" id="gender" name="gender" required>
              <option value="Nam" <c:if test="${param.gender == 'Nam'}">selected</c:if>>Nam</option>
              <option value="Nữ" <c:if test="${param.gender == 'Nữ'}">selected</c:if>>Nữ</option>
            </select>
          </div>

          <div class="mb-3">
            <label for="email" class="form-label">Email<span class="text-danger">*</span></label>
            <input type="email" class="form-control" id="email" name="email" value="${param.email}" placeholder="Nhập email" required
            oninput="document.getElementById('emailError').classList.add('d-none'); this.classList.remove('is-invalid','is-valid');">
            <div id="emailError" class="invalid-feedback d-none">
                Email không hợp lệ.
            </div>
          </div>

          <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu<span class="text-danger">*</span></label>
            <input type="password" class="form-control" id="password" name="password" value="${param.password}" placeholder="Nhập mật khẩu" required
            oninput="document.getElementById('passwordError').classList.add('d-none'); this.classList.remove('is-invalid','is-valid');">
            <div id="passwordError" class="invalid-feedback d-none">
                Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.
            </div>

        </div>

          <div class="mb-3">
            <label for="confirmPassword" class="form-label">Nhập lại mật khẩu<span class="text-danger">*</span></label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" value="${param.confirmPassword}" placeholder="Xác nhận mật khẩu" required
            oninput="document.getElementById('confirmError').classList.add('d-none'); this.classList.remove('is-invalid','is-valid');">
            <div id="confirmError" class="invalid-feedback d-none">
                Mật khẩu không khớp hoặc không hợp lệ, vui lòng kiểm tra lại.
            </div>
          </div>

          <div class="form-check mb-2">
            <input class="form-check-input custom-black" type="checkbox" id="agree" required>
            <label class="form-check-label" for="agree">
              Tôi đã đọc và đồng ý với Điều khoản sử dụng<span class="text-danger">*</span>
            </label>
          </div>

          <button type="submit" class="btn btn-register w-100">Đăng ký</button>
        </form>
     </div>
     <br>

    <jsp:include page="/common/footer.jsp" />
    <script src="/js/sign-up.js"></script>
</body>
</html>
