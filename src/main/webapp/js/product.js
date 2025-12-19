
const gridBtn = document.getElementById("btnGrid");
const listBtn = document.getElementById("btnList");
const container = document.getElementById("productContainer");

function switchToGrid() {
    container.classList.remove("list-view");
    gridBtn.classList.add("active");
    listBtn.classList.remove("active");
}

function switchToLine() {
    container.classList.add("list-view");
    listBtn.classList.add("active");
    gridBtn.classList.remove("active");
}

(function(){
    const btn = document.getElementById('sortBtn');
    document.querySelectorAll('.dropdown-menu .dropdown-item').forEach(item => {
        item.addEventListener('click', function() {
        btn.textContent = this.textContent.trim();
        });
    });
})();