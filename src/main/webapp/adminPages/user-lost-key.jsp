<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<fmt:setLocale value="vi_VN"/>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Người Dùng</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
</head>
<style>
    .stats-card.primary .stats-icon {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }

    .stats-card.success .stats-icon {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
    }

    .stats-card.warning .stats-icon {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
    }

    .stats-card.info .stats-icon {
        background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        color: white;
    }


    .search-box input {
        padding-left: 2.5rem;
        border-radius: 8px;
        border: 1px solid #dee2e6;
    }
</style>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>


<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý người dùng mất key</h1>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <table class="table table-bordered table-striped">
            <thead>
            <tr>
                <th>User ID</th>
                <th>Public Key ID</th>
                <th>Email</th>
                <th>Họ tên</th>
                <th>Ngày tạo</th>
                <th>Ngày báo mất</th>
                <th>Trạng thái</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="item" items="${losts}">
                <tr>
                    <td>${item.userId}</td>
                    <td>${item.publicKeyId}</td>
                    <td>${item.email}</td>
                    <td>${item.fullName}</td>
                    <td>${item.createdAt}</td>
                    <td>${item.lostAt}</td>
                    <td>${item.lost}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>


</main>

<script src="js/index.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
