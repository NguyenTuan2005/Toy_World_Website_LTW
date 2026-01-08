function selectPayment(paymentId) {
    document.querySelectorAll(".payment-option").forEach((option) => {
        option.classList.remove("active");
    });

    document.getElementById(paymentId).classList.add("active");
}