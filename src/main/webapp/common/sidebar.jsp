<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String active = (String) request.getAttribute("activeTab");
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
        :root {
            --sidebar-width: 280px;
        }

        .main-content {
            margin-left: var(--sidebar-width);
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: #f8f9fa;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: #dee2e6;
            border-radius: 10px;
        }

        .menu-link {
            position: relative;
            overflow: hidden;
        }

        .menu-link::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background: #dc3545;
            transform: scaleY(0);
            transition: transform 0.3s ease;
        }

        .menu-link:hover::before,
        .menu-link.active::before {
            transform: scaleY(1);
        }

        .menu-link:hover,
        .menu-link.active {
            background: #f8d7da !important;
            transform: translateX(5px);
        }
    </style>

<div class="sidebar bg-white shadow">
    <!-- Header -->
    <div class="text-center border-bottom border-danger" style ="padding: 31px">
        <a href="${pageContext.request.contextPath}/home">
            <img src="${pageContext.request.contextPath}/assets/ToyWorldLogo.png" alt="Toy World Logo" class="img-fluid">
        </a>
    </div>

    <!-- Menu -->
    <ul class="list-unstyled py-3">
        <li class="px-3 mb-1">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="<%= "dashboard".equals(active) ? "active" : "" %> menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-home"></i></span>
                <span class="flex-grow-1">Dashboard</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="${pageContext.request.contextPath}/admin/statistics" class="<%= "statistics".equals(active) ? "active" : "" %> menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-chart-line"></i></span>
                <span class="flex-grow-1">Thống kê doanh thu</span>
            </a>
        </li>

        <p class="text-secondary text-uppercase small fw-bold px-4 mt-3 mb-2" style="font-size: 0.7rem; letter-spacing: 1px;">Quản lý</p>

        <li class="px-3 mb-1">
            <a href="${pageContext.request.contextPath}/admin/users" class="<%= "users".equals(active) ? "active" : "" %> menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-users"></i></span>
                <span class="flex-grow-1">Quản lý người dùng</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="${pageContext.request.contextPath}/admin/products" class="<%= "products".equals(active) ? "active" : "" %> menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-box-open"></i></span>
                <span class="flex-grow-1">Quản lý sản phẩm</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="${pageContext.request.contextPath}/admin/orders" class="<%= "orders".equals(active) ? "active" : "" %> menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-shopping-cart"></i></span>
                <span class="flex-grow-1">Quản lý đơn hàng</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="${pageContext.request.contextPath}/admin/brands" class="<%= "brands".equals(active) ? "active" : "" %> menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-tag"></i></span>
                <span class="flex-grow-1">Quản lý thương hiệu</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="${pageContext.request.contextPath}/admin/events" class="<%= "events".equals(active) ? "active" : "" %> menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-calendar-alt"></i></span>
                <span class="flex-grow-1">Quản lý sự kiện</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="${pageContext.request.contextPath}/admin/handbooks" class="<%= "handbooks".equals(active) ? "active" : "" %> menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-newspaper"></i></span>
                <span class="flex-grow-1">Quản lý bài viết</span>
            </a>
        </li>
    </ul>

    <!-- Footer -->
    <div class="position-absolute bottom-0 start-0 end-0 p-3 border-top border-danger bg-light">
        <div class="d-flex align-items-center gap-2">
            <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' fill='%23f1f5f9'/%3E%3Ccircle cx='16' cy='12' r='4' fill='%2394a3b8'/%3E%3Cpath d='M16 18c-5 0-7 2.5-7 4v1h14v-1c0-1.5-2-4-7-4z' fill='%2394a3b8'/%3E%3C/svg%3E"
                 class="customer-avatar"
                 alt="Default Avatar"
                 style="width: 50px; height: 50px; border-radius: 50%; border: 1px solid #e2e8f0;"
            />
            <div class="flex-grow-1">
                <p class="text-danger fw-semibold mb-0 small">Admin</p>
                <p class="text-secondary mb-0" style="font-size: 0.75rem;">${sessionScope.currentUser.lastName} ${sessionScope.currentUser.firstName}</p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>