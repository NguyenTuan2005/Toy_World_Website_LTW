// Quantity selector
const quantityInput = document.getElementById('quantity');
const decreaseBtn = document.getElementById('decreaseQty');
const increaseBtn = document.getElementById('increaseQty');

decreaseBtn.addEventListener('click', () => {
    if (quantityInput.value > 1) {
        quantityInput.value = parseInt(quantityInput.value) - 1;
    }
});

increaseBtn.addEventListener('click', () => {
    quantityInput.value = parseInt(quantityInput.value) + 1;
});

// Thumbnail image switching
const mainImage = document.getElementById('mainImage');
const thumbnails = document.querySelectorAll('.thumbnail');

thumbnails.forEach((thumb, index) => {
    thumb.addEventListener('click', () => {
        thumbnails.forEach(t => t.classList.remove('active'));
        thumb.classList.add('active');
        const newImageSrc = thumb.getAttribute('data-image');
        mainImage.src = newImageSrc;
    });
});


// ZOOM IMAGE
const modal = document.getElementById('imageModal');
const modalImg = document.getElementById('modalImage');
const closeBtn = document.querySelector('.close-btn');

document.getElementById('mainImage').addEventListener('click', () => {
    modal.style.display = 'flex';
    modalImg.src = document.getElementById('mainImage').src;
});

// Đóng modal
closeBtn.addEventListener('click', () => modal.style.display = 'none');
modal.addEventListener('click', (e) => {
    if (e.target === modal) modal.style.display = 'none';
});
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') modal.style.display = 'none';
});

// comments
function showMoreComments() {
    const hiddenComments = document.querySelectorAll('.extra-comment');
    hiddenComments.forEach(c => c.classList.remove('d-none'));

    document.getElementById('btnShowMore').style.display = 'none';
}

document.getElementById('imageModal')
    .addEventListener('show.bs.modal', function (e) {
        document.getElementById('modalImage').src =
            e.relatedTarget.src;
    });

// Related products
function scrollRelated(direction) {
    const container = document.getElementById('relatedScroll');
    const itemWidth = container.querySelector('.product-item').offsetWidth + 16;

    container.scrollBy({
        left: direction * itemWidth,
        behavior: 'smooth'
    });
}
