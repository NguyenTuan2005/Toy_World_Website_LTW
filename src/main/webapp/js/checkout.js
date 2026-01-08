function selectPayment(paymentId) {
    document.querySelectorAll(".payment-option").forEach((option) => {
        option.classList.remove("active");
    });

    document.getElementById(paymentId).classList.add("active");
}

let alert = document.getElementById("alert");
const form = document.getElementById("checkoutForm");
const province = document.getElementById('province');
const firstName = document.getElementById('firstName');
const lastName = document.getElementById('lastName');
const address = document.getElementById('address');
const phone = document.getElementById('phone');

function showAlert(message) {
    alert.classList.remove("d-none");
    alert.textContent = message;
    setTimeout(()=> alert.classList.add('d-none'), 3000);
    alert.scrollIntoView({ behavior: 'smooth', block: 'center' });
}

function checkout(e) {
    e.preventDefault();
    const selectedPayment = document.querySelector(".payment-option.active");

    if (!selectedPayment) {
        showAlert("Vui lòng chọn phương thức thanh toán");
        return;
    }

    [province, firstName, lastName, address, phone].forEach(field => {
        field.classList.remove('is-invalid', 'is-valid');
    });

    let isValid = true;

    if (!province.value) {
        province.classList.add('is-invalid');
        isValid = false;
    } else {
        province.classList.add('is-valid');
    }

    if (!firstName.value.trim()) {
        firstName.classList.add('is-invalid');
        isValid = false;
    } else {
        firstName.classList.add('is-valid');
    }

    if (!lastName.value.trim()) {
        lastName.classList.add('is-invalid');
        isValid = false;
    } else {
        lastName.classList.add('is-valid');
    }

    if (!address.value.trim()) {
        address.classList.add('is-invalid');
        isValid = false;
    } else {
        address.classList.add('is-valid');
    }

    const phoneRegex = /^(0)[0-9]{9,10}$/;
    if (!phone.value.trim() || !phoneRegex.test(phone.value)) {
        phone.classList.add('is-invalid');
        isValid = false;
    } else {
        phone.classList.add('is-valid');
    }

    if (!isValid) {
        showAlert("Vui lòng điền đầy đủ thông tin giao hàng");
        return;
    }

    const paymentInput = document.createElement('input');
    paymentInput.type = 'hidden';
    paymentInput.name = 'paymentMethod';
    paymentInput.value = selectedPayment.id;
    form.appendChild(paymentInput);

    form.submit();
}