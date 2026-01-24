<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setLocale value="vi_VN"/>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Đơn Hàng</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100">
<%--    delete--%>
    <c:if test="${not empty sessionScope.MSG_SUCCESS}">
        <div id="successToast"
             class="toast align-items-center text-bg-success border-0"
             role="alert"
             aria-live="assertive"
             aria-atomic="true"
             data-bs-delay="3000"
             data-bs-autohide="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="bi bi-check-circle-fill me-2"></i>
                        ${sessionScope.MSG_SUCCESS}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast"></button>
            </div>
        </div>
        <c:remove var="MSG_SUCCESS" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.MSG_ERROR}">
        <div id="errorToast"
             class="toast align-items-center text-bg-danger border-0"
             role="alert"
             aria-live="assertive"
             aria-atomic="true"
             data-bs-delay="3000"
             data-bs-autohide="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="bi bi-x-circle-fill me-2"></i>
                        ${sessionScope.MSG_ERROR}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast"></button>
            </div>
        </div>
        <c:remove var="MSG_ERROR" scope="session"/>
    </c:if>

</div>


<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý đơn hàng</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-3">

        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6 mt-3 mt-md-0">
                    <div class="search-wrapper">
                        <form method="get" class="search-wrapper d-flex">
                            <i class="bi bi-search search-icon"></i>

                            <input type="text" class="search-input" placeholder="Tìm theo mã đơn, tên, email, SĐT..."
                                   name="keyword" value="${fn:escapeXml(param.keyword)}"/>

                            <input type="hidden" name="sort"
                                   value="${empty param.sort ? 'newest' : param.sort}"/>

                            <button type="button"
                                    class="btn btn-link ms-2"
                                    title="Tải lại"
                                    onclick="window.location.href = '${pageContext.request.contextPath}/admin/orders'"
                                    style="border: solid 1px #d9dde2;">

                                <i class="bi bi-arrow-counterclockwise text-muted fs-3"></i>
                            </button>
                        </form>
                    </div>
                </div>
                <div class="col-md-6 d-flex justify-content-end align-items-center mt-3 mt-md-0">
                    <form class="text-align" method="get">
                        <i class="fas fa-filter filter-icon" style="color: #cf102d"></i>
                        <select class="status-select" name="sort" onchange="this.form.submit()">
                            <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Mới Nhất</option>
                            <option value="processing" ${param.sort == 'processing' ? 'selected' : ''}>Chuẩn Bị Hàng
                            </option>
                            <option value="shipping" ${param.sort == 'shipping' ? 'selected' : ''}>Đang Giao</option>
                            <option value="delivered" ${param.sort == 'delivered' ? 'selected' : ''}>Đã Giao</option>
                            <option value="cancelled" ${param.sort == 'cancelled' ? 'selected' : ''}>Đã Hủy</option>
                            <option value="paid" ${param.sort == 'paid' ? 'selected' : ''}>Đã Thanh Toán</option>
                            <option value="unpaid" ${param.sort == 'unpaid' ? 'selected' : ''}>Chưa Thanh Toán</option>
                            <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Giá trị giảm
                                dần
                            </option>
                            <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Giá trị tăng dần
                            </option>
                        </select>
                    </form>

                </div>
            </div>
        </div>
        <%--        data table--%>
        <div class="table-container">
            <table class="table">
                <thead>
                <tr>
                    <th>Mã Đơn</th>
                    <th>Ngày Đặt</th>
                    <th>Tên Khách Hàng</th>
                    <th>Số điện thoại</th>
                    <th>Email</th>
                    <th>Tổng tiền (VNĐ)</th>
                    <th>Thanh Toán</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${orders}" var="o">
                    <tr>
                        <td class="bold-title">#${o.id}</td>
                        <td>${o.createdAt}</td>
                        <td >${o.customerName}</td>
                        <td>${o.customerPhoneNumber}</td>
                        <td>${o.customerEmail}</td>
                        <td><fmt:formatNumber value="${o.totalPrice}" pattern="#,##0"/></td>

                        <td class="text-nowrap">
                            <c:choose>
                                <c:when test="${o.paymentStatus == 'CHUA_THANH_TOAN'}">
                                    <span class="badge bg-danger-subtle text-danger">
                                        Chưa thanh toán
                                    </span>
                                </c:when>

                                <c:when test="${o.paymentStatus == 'DA_THANH_TOAN'}">
                                    <span class="badge bg-success-subtle text-success">
                                        Đã thanh toán
                                    </span>
                                </c:when>

                                <c:when test="${o.paymentStatus == 'HOAN_TIEN'}">
                                    <span class="badge bg-dark-subtle text-dark">
                                        Hoàn tiền
                                    </span>
                                </c:when>
                            </c:choose>
                        </td>

                        <td class="text-nowrap">
                            <c:choose>
                                <c:when test="${o.orderStatus == 'CHUAN_BI_HANG'}">
                                    <span class="badge bg-primary-subtle text-primary">
                                        Chuẩn bị hàng
                                    </span>
                                </c:when>

                                <c:when test="${o.orderStatus == 'DANG_GIAO'}">
                                    <span class="badge bg-success-subtle text-success">
                                        Đang giao
                                    </span>
                                </c:when>

                                <c:when test="${o.orderStatus == 'DA_GIAO'}">
                                    <span class="badge bg-success-subtle text-success">
                                        Đã giao
                                    </span>
                                </c:when>

                                <c:when test="${o.orderStatus == 'DA_HUY'}">
                                    <span class="badge bg-danger-subtle text-danger">
                                        Đã hủy
                                    </span>
                                </c:when>
                            </c:choose>
                        </td>


                        <td>
                            <div class="d-flex gap-2">
                                <button class="btn btn-link text-primary text-decoration-none"
                                        onclick="location.href='${pageContext.request.contextPath}/admin/orders/view/${o.id}'">
                                    <i class="bi bi-eye-fill"></i>
                                </button>

                                <button class="btn btn-link text-success text-decoration-none"
                                        onclick="location.href='${pageContext.request.contextPath}/admin/orders/edit/${o.id}'">
                                    <i class="fas fa-edit"></i>
                                </button>

                                <button class="btn btn-link text-danger"
                                        data-bs-toggle="modal"
                                        data-bs-target="#deleteOrderModal"
                                        data-id="${o.id}">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>

            <hr class="mx-5"/>
            <div class="d-flex justify-content-between align-items-center m-3">
                <p class="mb-0">Hiển thị ${orders.size()} trong ${totalOrders} đơn hàng</p>
                <c:set var="sort" value="${empty param.sort ? 'newest' : param.sort}"/>

                <nav>
                    <ul class="pagination mb-0">

                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="?page=${currentPage - 1}&sort=${sort}">
                                &lt;
                            </a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&sort=${param.sort}">${i}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="?page=${currentPage + 1}&sort=${sort}">
                                &gt;
                            </a>
                        </li>

                    </ul>
                </nav>
            </div>
        </div>
    </div>


<%--modal --%>
    <div class="modal fade" id="deleteOrderModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/orders/delete" method="post">
                    <!-- id -->
                    <input type="hidden" name="orderId" id="deleteOrderId"/>

                    <div class="modal-header">
                        <h5 class="modal-title">Xác nhận xóa đơn hàng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <p>
                            Bạn có chắc chắn muốn <strong>xóa đơn hàng
                            <span id="deleteOrderText"></span></strong> không?
                        </p>
                        <p class="text-muted small">
                            Hành động này không thể hoàn tác.
                        </p>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Hủy
                        </button>
                        <button type="submit" class="btn btn-danger">
                            Xóa Đơn Hàng
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>


</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const deleteOrderModal = document.getElementById('deleteOrderModal');

    deleteOrderModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const orderId = button.getAttribute('data-id');

        document.getElementById('deleteOrderId').value = orderId;
        document.getElementById('deleteOrderText').innerText = '#' + orderId;
    });


    document.addEventListener("DOMContentLoaded", function () {
        const successToast = document.getElementById('successToast');
        const errorToast = document.getElementById('errorToast');

        if (successToast) {
            const toast = new bootstrap.Toast(successToast, {
                delay: 3000,
                autohide: true
            });
            toast.show();
        }

        if (errorToast) {
            const toast = new bootstrap.Toast(errorToast, {
                delay: 3000,
                autohide: true
            });
            toast.show();
        }
    });
</script>

</body>
</html>
