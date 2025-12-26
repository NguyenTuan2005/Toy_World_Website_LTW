const form = document.getElementById("signupForm");
const email = document.getElementById("email");
const phone = document.getElementById("phone");
const pass = document.getElementById("password");
const confirm = document.getElementById("confirmPassword");

const emailError = document.getElementById("emailError");
const phoneError = document.getElementById("phoneError");
const passError = document.getElementById("passwordError");
const confirmError = document.getElementById("confirmError");

function handleSignUpEvent(e) {
    e.preventDefault();

    emailError.classList.add('d-none');
    phoneError.classList.add('d-none');
    passError.classList.add('d-none');
    confirmError.classList.add('d-none');

    email.classList.remove('is-invalid', 'is-valid');
    phone.classList.remove('is-invalid', 'is-valid');
    pass.classList.remove('is-invalid', 'is-valid');
    confirm.classList.remove('is-invalid', 'is-valid');

    let isValid = true;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email.value.trim() || !emailRegex.test(email.value)) {
        emailError.classList.remove('d-none');
        email.classList.add('is-invalid');
        isValid = false;
    } else {
        email.classList.add('is-valid');
    }

    const phoneRegex = /^(0)[0-9]{9,10}$/;
    if (!phone.value.trim() || !phoneRegex.test(phone.value)) {
        phoneError.classList.remove('d-none');
        phone.classList.add('is-invalid');
        isValid = false;
    } else {
        phone.classList.add('is-valid');
    }

    let passFailure = true
    const passRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    if (!pass.value || !passRegex.test(pass.value)) {
        passError.classList.remove('d-none');
        pass.classList.add('is-invalid');
        isValid = false;
    } else {
        passFailure = false;
        pass.classList.add('is-valid');
    }

    if (passFailure || !confirm.value || pass.value !== confirm.value) {
        confirmError.classList.remove('d-none');
        confirm.classList.add('is-invalid');
        isValid = false;
    } else {
        confirm.classList.add('is-valid');
    }

    if (isValid) {
        form.submit();
    }

    return false;
}