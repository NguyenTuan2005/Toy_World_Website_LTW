<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ký Điện Tử Cho Đơn Hàng </title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp"/>
    <link rel="stylesheet" href="css/my-shopping-cart.css"/>
    <fmt:setLocale value="vi_VN"/>
</head>
<body>
<jsp:include page="/common/header.jsp"/>
<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">
            <h3>Tạo chữ ký điện tử cho đơn hàng</h3>
        </div>

        <div class="card-body">

            <h5>Thông tin đơn hàng</h5>

            <table class="table table-bordered">
                <tr>
                    <th>Mã đơn hàng</th>
                    <td>${order.id}</td>
                </tr>

                <tr>
                    <th>Tên khách hàng</th>
                    <td>${userFullName}</td>
                </tr>

                <tr>
                    <th>Tổng tiền</th>
                    <td>${order.totalPrice} VNĐ</td>
                </tr>

                <tr>
                    <th>Trạng thái</th>
                    <td>${order.orderStatus}</td>
                </tr>
            </table>

            <hr>

            <h5>Danh sách sản phẩm</h5>

            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                </tr>
                </thead>

                <tbody>

                <c:forEach items="${order.items}" var="item">

                    <tr>
                        <td>${item.productName}</td>
                        <td>${item.quantity}</td>
                        <td>${item.price}</td>
                    </tr>

                </c:forEach>

                </tbody>
            </table>

            <hr>

            <h5>Bước 1: Tải Payload để ký</h5>

            <a href="${pageContext.request.contextPath}/dowload-order-payload?orderId=${order.id}"
               class="btn btn-success">
                Tải Payload
            </a>

            <p class="text-muted mt-2">
                Tải file payload và sử dụng công cụ ký điện tử bằng Private Key của bạn.
            </p>

            <hr>

            <h5>Bước 2: Upload chữ ký điện tử</h5>

            <form action="${pageContext.request.contextPath}/verify-signature"
                  method="post"
                  enctype="multipart/form-data">

                <input type="hidden"
                       name="orderId"
                       value="${order.id}"/>

                <div class="mb-3">

                    <label class="form-label">
                        Chọn file chữ ký (.sig)
                    </label>

                    <input type="file"
                           name="signatureFile"
                           class="form-control"
                           accept=".sig"
                           required>

                </div>

                <button type="submit"
                        class="btn btn-primary">
                    Xác nhận chữ ký
                </button>

            </form>

            <hr>

            <div class="alert alert-info">

                <strong>Quy trình:</strong>

                <ol class="mb-0 mt-2">
                    <li>Tải Payload của đơn hàng.</li>
                    <li>Dùng công cụ ký điện tử với Private Key.</li>
                    <li>Nhận file chữ ký (.sig).</li>
                    <li>Upload chữ ký để hệ thống xác thực.</li>
                    <li>Nếu hợp lệ, bạn sẽ được chuyển sang trang thanh toán.</li>
                </ol>

            </div>

        </div>

    </div>

</div>
<jsp:include page="/common/footer.jsp"/>

</body>
</html>
