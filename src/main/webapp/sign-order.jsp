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
    <style>
        .header-title {
            color: #041675;
            text-align: center;
            margin-bottom: 30px;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<jsp:include page="/common/header.jsp"/>

<c:choose>
    <c:when test="${not empty error}">
        <div id="alert" class="alert alert-danger text-center mb-4" role="alert">
                ${error}
        </div>
    </c:when>
    <c:otherwise>
        <div id="alert" class="alert alert-danger text-center mb-4 d-none" role="alert"></div>
    </c:otherwise>
</c:choose>

<div class="container mt-5">

    <h1 class="header-title">Tạo chữ ký điện tử cho đơn hàng</h1>

    <div class="card shadow">

        <div class="card-header bg-primary text-white">
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

            <h5>Bước 1: Tải file dữ liệu đơn hàng</h5>

            <p class="mt-2">
                Tải file này về máy và sử dụng công cụ ký điện tử bằng Private Key của bạn.
            </p>

            <a href="${pageContext.request.contextPath}/dowload-order-payload?orderId=${order.id}"
               class="btn btn-success">
                Tải file dữ liệu đơn hàng
            </a>

            <hr>

            <h5>Bước 2: Thực hiện ký điện tử</h5>

            <p class="mt-2">
                Sử dụng phần mềm chữ ký số để ký vào file vừa tải về. Nếu chưa có công cụ ký số, bạn có thể tải phần mềm hỗ trợ ký
                <a href="${pageContext.request.contextPath}/tool" class="alert-link font-weight-bold text-underline">tại đây</a>.
            </p>

            <div class="card bg-light p-3 border-0">
                <span class="text-muted d-block mb-1">Hướng dẫn:</span>
                <ul class="text-muted pl-3 mb-0" style="font-size: 16px;">
                    <li>Mở phần mềm ký số trên máy tính của bạn.</li>
                    <li>Chọn file dữ liệu đơn hàng vừa tải ở Bước 1.</li>
                    <li>Chọn Khóa bí mật (Private Key) và bấm <strong>Ký tên</strong>.</li>
                </ul>
            </div>

            <hr>

            <h5>Bước 3: Upload chữ ký điện tử để xác thực đơn hàng</h5>

            <form action="${pageContext.request.contextPath}/verify-signature"
                  method="post"
                  enctype="multipart/form-data">

                <input type="hidden"
                       name="orderId"
                       value="${order.id}"/>

                <div class="mb-3">

                    <label class="form-label">
                        Chọn file có chứa chữ ký
                    </label>

                    <input type="file"
                           name="signatureFile"
                           class="form-control"
                           accept=".txt"
                           required>

                </div>

                <button type="submit"
                        class="btn btn-primary">
                    Xác nhận chữ ký
                </button>
            </form>

            <div class="pb-3">
            </div>

        </div>

    </div>

</div>
<jsp:include page="/common/footer.jsp"/>

</body>
</html>
