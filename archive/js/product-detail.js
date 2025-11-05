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

// Heart icon toggle
const heartIcon = document.querySelector('.heart-icon');
heartIcon.addEventListener('click', () => {
    heartIcon.classList.toggle('far');
    heartIcon.classList.toggle('fas');
});

// Description toggle
const toggleBtn = document.getElementById('toggleBtn');
const moreText = document.getElementById('moreText');
const shortText = document.getElementById('shortText');

toggleBtn.addEventListener('click', () => {
    if (moreText.style.display === 'none') {
        moreText.style.display = 'inline';
        shortText.style.display = 'none';
        toggleBtn.textContent = 'Thu gọn';
    } else {
        moreText.style.display = 'none';
        shortText.style.display = 'inline';
        toggleBtn.textContent = 'Xem thêm';
    }
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