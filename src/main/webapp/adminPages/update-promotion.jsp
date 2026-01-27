<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Sự Kiện</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>

</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>


<main class="main-content">
    <!-- Modal Thêm/Sửa Event -->
    <div calss="container-event" style="margin: 40px">
        <div>
            <a href="${pageContext.request.contextPath}/admin/promotions"
               class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>

            <h2>Cập nhật promotion</h2>
        </div>

        <form id="eventForm"
              action="${pageContext.request.contextPath}/admin/new-promotions"
              method="post">
            <input hidden="hidden" value="${promotion.id}" name="id">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Tên Promotion *</label>
                    <input type="text" class="form-control" name="promotionName" required value="${promotion.name}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Số tiền tối đa được giảm</label>
                    <input type="text" class="form-control" name="discountPrice" required
                           placeholder="VD: 70.000" value="${promotion.discountPrice}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Phần Trăm Giảm</label>
                    <input type="text" class="form-control" name="discountPercent" required
                           placeholder="VD: 70%" value="${promotion.discountPercent}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Hết Hạn *</label>
                    <input type="date"
                           class="form-control"
                           name="expiryDate"
                           required
                           value="${date}">

                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Trạng Thái *</label>
                    <select class="form-select" name="status" required>
                        <option value="true"
                        ${promotion.active == true ? "selected" : ""}>
                            Đang hoạt động
                        </option>

                        <option value="false"
                        ${promotion.active == false ? "selected" : ""}>
                            Ngưng hoạt động
                        </option>
                    </select>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Chọn Events</label>
                    <select class="form-select" name="eventId" required>

                        <c:forEach items="${events}" var="event">
                            <option value="${event.id}"
                                ${event.id == promotion.eventId ? "selected" : ""}>
                                    ${event.name}
                            </option>
                        </c:forEach>

                    </select>
                </div>


            </div>

            <div class="modal-footer">
                <button type="reset" class="btn btn-secondary">Hủy</button>
                <button type="submit" class="btn btn-primary">Lưu</button>
            </div>
        </form>

        <%--    </div>--%>
</main>
<script>
    function showSuccessToast(mess) {
        // Sử dụng Bootstrap Toast hoặc alert
        const toastHtml = `
        <div class="position-fixed top-0 end-0 p-3" style="z-index: 10000">
            <div class="toast show bg-success text-white" role="alert">
                <div class="toast-header bg-success text-white">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <strong class="me-auto">Success</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">
                    ${mess}
                </div>
            </div>
        </div>
    `;
        document.body.insertAdjacentHTML('beforeend', toastHtml);

        // Auto remove sau 3 giây
        setTimeout(() => {
            document.querySelector('.toast').remove();
        }, 3000);
    }

    const form = document.getElementById("eventForm");

    form.addEventListener("submit", function (e) {
        e.preventDefault(); // chặn submit mặc định

        let isValid = true;

        const promotionName = form.promotionName.value.trim();
        const discountPrice = form.discountPrice.value.trim();
        const discountPercent = form.discountPercent.value.trim();
        const expiryDate = form.expiryDate.value;
        const status = form.status.value;
        const eventId = form.eventId.value;

        // Reset lỗi cũ
        document.querySelectorAll(".error-text").forEach(el => el.remove());

        // Hàm show lỗi
        function showError(input, message) {
            const small = document.createElement("small");
            small.className = "text-danger error-text";
            small.innerText = message;
            input.parentElement.appendChild(small);
            isValid = false;
        }

        // 1. Tên promotion
        if (promotionName.length < 3) {
            showError(form.promotionName, "Tên promotion tối thiểu 3 ký tự");
        }

        // 2. Số tiền giảm (số hoặc số thập phân)
        if (!/^\d+(\.\d+)?$/.test(discountPrice)) {
            showError(form.discountPrice, "Chỉ được nhập số (VD: 70000 hoặc 70000.5)");
        }


        // 3. % giảm (0 - 100, cho phép số thập phân)
        if (!/^(100(\.0+)?|(\d{1,2})(\.\d+)?)$/.test(discountPercent)) {
            showError(form.discountPercent, "Nhập % hợp lệ (0 - 100, VD: 10, 10.5)");
        }


        // // 4. Ngày hết hạn
        // const today = new Date().toISOString().split("T")[0];
        // if (expiryDate <= today) {
        //     showError(form.expiryDate, "Ngày hết hạn phải lớn hơn hôm nay");
        // }

        // 5. Event
        if (!eventId) {
            showError(form.eventId, "Vui lòng chọn event");
        }

        // Nếu hợp lệ thì submit
        if (isValid) {
            showSuccessToast("Thêm promotion thành công 🎉");
            form.submit();
        }
    });
</script>
<script src="js/index.js"></script>
<%--<script src="${pageContext.request.contextPath}/adminPages/js/notification.js"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
