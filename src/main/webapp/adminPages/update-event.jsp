<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <style>
        .container-event {
            width: calc(100% - 280px);
        }

    </style>
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>


<main class="main-content">
    <!-- Modal Thêm/Sửa Event -->
    <div calss="container-event" style="margin: 40px">
        <div>
            <a href="${pageContext.request.contextPath}/admin/events"
               class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
            <h2>Cập nhật</h2>

        </div>
        <form id="eventForm"
              action="${pageContext.request.contextPath}/admin/update-events"
              method="post">
            <input hidden="hidden" value="${event.id}" name="id">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Tên Sự Kiện *</label>
                    <input type="text" class="form-control" name="eventName" value="${event.name}" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Loại Sự Kiện *</label>
                    <select class="form-select" name="eventType" required>
                        <option value="${event.typeEvent}">${event.typeEvent}</option>
                        <option value="Sale Event">Sale Event</option>
                        <option value="Festival">Festival</option>
                        <option value="Flash Sale">Flash Sale</option>
                        <option value="Special Event">Special Event</option>
                    </select>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Ngày Bắt Đầu *</label>
                    <input type="date"
                           class="form-control"
                           name="startDate"
                           value="${fn:substring(event.openedAt,0,10)}"
                           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Ngày Kết Thúc *</label>

                    <input type="date"
                           class="form-control"
                           name="endDate"
                           value="${fn:substring(event.closedAt,0,10)}"
                           required>
                </div>

                <div class="col-12 mb-3">
                    <label class="form-label">Mô Tả</label>
                    <textarea class="form-control" name="description" rows="3">${event.description}</textarea>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Trạng Thái *</label>
                    <select class="form-select" name="status" required>
                        <option value="true">Hien thi</option>
                        <option value="true">Hien thi</option>
                        <option value="false">An</option>
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

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
