let alert = document.getElementById("alert");

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
            if (data.success) {location.reload();}
            else {
                alert.classList.remove("d-none");
                alert.textContent = data.message;
            }
        })
        .catch(error => {
            alert.classList.remove("d-none");
            alert.textContent = error.message;
        });
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
            if (data.success) {location.reload();}
            else {
                alert.classList.remove("d-none");
                alert.textContent = data.message;
            }
        })
        .catch(error => {
            alert.classList.remove("d-none");
            alert.textContent = error.message;
        })
}