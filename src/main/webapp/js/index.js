function handleFooterSubscribe(e) {
    e.preventDefault();
    const input = document.getElementById('footer-email');
    const error = document.getElementById('footerEmailHelp');
    const success = document.getElementById('footerEmailSuccess');
    const val = input.value.trim();
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    error.classList.add('d-none');
    success.classList.add('d-none');
    input.classList.remove('is-invalid', 'is-valid');

    if (!val || !re.test(val)) {
        error.classList.remove('d-none');
        input.classList.add('is-invalid');
        return false;
    }

    input.classList.add('is-valid');
    success.classList.remove('d-none');
    input.value = '';
    return false;
}