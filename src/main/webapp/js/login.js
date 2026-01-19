function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

function clearErrors() {
    document.querySelectorAll('.error-message').forEach(function(el) {
        el.textContent = '';
    });
    document.querySelectorAll('.form-control').forEach(function(el) {
        el.classList.remove('is-invalid');
    });
}

document.getElementById('loginFormElement').addEventListener('submit', function(e) {
    e.preventDefault();
    clearErrors();

    let isValid = true;
    const email = document.getElementById('loginEmail');
    const password = document.getElementById('loginPassword');

    if (!email.value.trim()) {
        document.getElementById('loginEmailError').textContent = 'Vui lòng nhập email';
        email.classList.add('is-invalid');
        isValid = false;
    } else if (!validateEmail(email.value)) {
        document.getElementById('loginEmailError').textContent = 'Email không hợp lệ';
        email.classList.add('is-invalid');
        isValid = false;
    }

    if (!password.value.trim()) {
        document.getElementById('loginPasswordError').textContent = 'Vui lòng nhập mật khẩu';
        password.classList.add('is-invalid');
        isValid = false;
    }

    if (isValid) {
        window.location.href = '/archive/home-page.html';
        // fetch here
    }
});

document.getElementById('forgotPasswordFormElement').addEventListener('submit', function(e) {
    e.preventDefault();
    clearErrors();

    const email = document.getElementById('forgotEmail');
    let isValid = true;

    if (!email.value.trim()) {
        document.getElementById('forgotEmailError').textContent = 'Vui lòng nhập email';
        email.classList.add('is-invalid');
        isValid = false;
    } else if (!validateEmail(email.value)) {
        document.getElementById('forgotEmailError').textContent = 'Email không hợp lệ';
        email.classList.add('is-invalid');
        isValid = false;
    }

    if (isValid) {
        document.getElementById('resetPasswordForm').style.display = 'block';
        this.parentElement.style.display = 'none';
    }
});