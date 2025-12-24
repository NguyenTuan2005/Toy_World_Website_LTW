const editBtn = document.getElementById("btnEditAddress");
const form = document.getElementById("editAddressForm");
const saveBtn = document.getElementById("btnSaveAddress");
const cancelBtn = document.getElementById("btnCancelEdit");

editBtn.addEventListener("click", () => {
    form.style.display = "block";
    // Auto fill thông tin vào form
    document.getElementById("inputName").value = document.getElementById("displayName").innerText;
    document.getElementById("inputAddress").value = document.getElementById("displayAddress").innerText;
    document.getElementById("inputPhone").value = document.getElementById("displayPhone").innerText;
    document.getElementById("inputEmail").value = document.getElementById("displayEmail").innerText;
});

saveBtn.addEventListener("click", () => {
    document.getElementById("displayName").innerText = document.getElementById("inputName").value;
    document.getElementById("displayAddress").innerText = document.getElementById("inputAddress").value;
    document.getElementById("displayPhone").innerText = document.getElementById("inputPhone").value;
    document.getElementById("displayEmail").innerText = document.getElementById("inputEmail").value;

    form.style.display = "none"; // Ẩn form
});

cancelBtn.addEventListener("click", () => {
    form.style.display = "none"; // Đóng form nếu không muốn sửa nữa
});




function showSection(sectionId) {
    // lấy tất cả div có class="section"
    const sections = document.querySelectorAll(".section");

    // remove active tất cả
    sections.forEach(sec => sec.classList.remove("active"));

    // add active cho cái div được click
    document.getElementById(sectionId).classList.add("active");
}
