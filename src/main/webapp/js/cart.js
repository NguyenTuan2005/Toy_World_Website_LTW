let alert = document.getElementById("alert");

function showAlert(message) {
    alert.classList.remove("d-none");
    alert.textContent = message;
    setTimeout(()=> alert.classList.add('d-none'), 3000);
}

function showConfirm(message) {
    return new Promise(resolve => {
        const modalEl = document.getElementById("confirmModal");
        const messageEl = document.getElementById("confirmMessage");
        const btnOk = document.getElementById("confirmOk");
        const btnCancel = document.getElementById("confirmCancel");

        messageEl.textContent = message;

        const modal = new bootstrap.Modal(modalEl);
        modal.show();

        const cleanUp = (result) => {
            btnOk.removeEventListener("click", onOk);
            btnCancel.removeEventListener("click", onCancel);
            modal.hide();
            resolve(result);
        };

        const onOk = () => cleanUp(true);
        const onCancel = () => cleanUp(false);

        btnOk.addEventListener("click", onOk);
        btnCancel.addEventListener("click", onCancel);
    });
}

async function removeItem(productId) {
    const confirmed = await showConfirm('Bạn có chắc muốn xóa sản phẩm này?');
    if (!confirmed) return;

    fetch(contextPath + "/cart-remove", {
        method: 'POST',
        headers: {
            "Content-Type": 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({ productId: productId })
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById(productId).remove();
                updateCartSummary(data);
            }
            else {showAlert(data.message);}
        })
        .catch(error => showAlert(error.message));
}

function updateQty(productId, quantity) {
    fetch(contextPath + "/cart-update", {
        method: 'POST',
        headers: {
            "Content-Type": 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({ productId: productId, quantity: quantity })
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                updateCartSummary(data);
                const product = document.getElementById(productId);
                const quantityInput = product.querySelector('#quantity');
                quantityInput.value = quantity;
            }
            else {showAlert(data.message);}
        })
        .catch(error => showAlert(error.message))
}

function updateCartSummary(data) {
    const totalItemsEl = document.getElementById('totalItems');
    if (totalItemsEl) {
        totalItemsEl.textContent = `${data.totalQuantity} Sản phẩm`;
    }

    document.getElementById('subtotal').textContent = formatCurrency(data.totalCost);

    document.getElementById('total').textContent = formatCurrency(data.totalPrice);

    const headerCart = document.getElementById('cart-count');
    const text = headerCart.textContent;
    if (data.totalQuantity === 0) {
        headerCart.textContent = text.replace(/\(\s*\d+\s*\)/, '').trim();
    } else {
        headerCart.textContent = text.replace(/\(\s*\d+\s*\)/, `(${data.totalQuantity})`);
    }
}

function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}