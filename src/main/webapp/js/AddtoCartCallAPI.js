

function addToCart(productId) {
    fetch('/cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `productId=${productId}&quantity=1`
    })
        .then(res => {
            if (res.ok) {
                alert('Đã thêm vào giỏ hàng');
            }
        });
}
