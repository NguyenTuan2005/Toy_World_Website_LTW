

document.getElementById("signupForm").addEventListener("submit", function(e) {
  e.preventDefault();
  const pass = document.getElementById("password");
  const confirm = document.getElementById("confirmPassword");
  const errorMsg = document.getElementById("confirmError");

  // Reset trạng thái cũ
  confirm.classList.remove("is-invalid");
  errorMsg.style.display = "none";

  if (pass.value !== confirm.value) {
    console.log("Mật khẩu không khớp!");
    confirm.classList.add("is-invalid"); // viền đỏ bootstrap
    errorMsg.style.display = "block";    // hiện thông báo
    return;
  }

  console.log("Thành công!");
});


// valid rest fields.
document.getElementById("signupForm").addEventListener("submit", function (e) {
  e.preventDefault();

  const email = document.getElementById("email");
  const phone = document.getElementById("phone");
  const pass = document.getElementById("password");
  const confirm = document.getElementById("confirmPassword");

  const emailError = document.getElementById("emailError");
  const phoneError = document.getElementById("phoneError");
  const passError = document.getElementById("passwordError");
  const confirmError = document.getElementById("confirmError");

  let isValid = true;

  // Ẩn hết lỗi cũ
  [emailError, phoneError, passError, confirmError].forEach((el) => {
    if (el) el.style.display = "none";
  });
  [email, phone, pass, confirm].forEach((el) => {
    el.classList.remove("is-invalid");
  });

  //  Validate email
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email.value)) {
    email.classList.add("is-invalid");
    emailError.style.display = "block";
    isValid = false;
  }

  //  Validate số điện thoại (VN: bắt đầu bằng 0 hoặc +84, 9–10 số)
  const phoneRegex = /^(0|\+84)[0-9]{9,10}$/;
  if (!phoneRegex.test(phone.value)) {
    phone.classList.add("is-invalid");
    phoneError.style.display = "block";
    isValid = false;
  }

  //  Validate mật khẩu mạnh
  const passRegex =
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
  if (!passRegex.test(pass.value)) {
    pass.classList.add("is-invalid");
    passError.style.display = "block";
    isValid = false;
  }

  //  Kiểm tra khớp mật khẩu
  if (pass.value !== confirm.value) {
    confirm.classList.add("is-invalid");
    confirmError.style.display = "block";
    isValid = false;
  }

  //  Nếu tất cả đều OK
  if (isValid) {
    console.log("Form hợp lệ  Gửi dữ liệu lên server...");
    // Submit form hoặc gọi API tại đây
  }
});
