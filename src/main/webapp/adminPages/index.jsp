<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Dashboard</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="../css/root.css"/>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <aside id="sidebar" class="col-lg-2 col-md-3 bg-light text-primary min-vh-100 p-0">
            <div class="d-flex flex-column h-100">
                <div class="p-3 hstack border-bottom border-secondary">
                    <h4 class="mb-0 sidebar-header"><strong>Quản trị</strong></h4>
                    <button class="btn btn-outline-light btn-sm text-secondary sidebar-text ms-auto"
                            onclick="collapseSidebar()" id="collapseSidebar">
                        <i class="fas fa-chevron-left me-2"></i>
                    </button>
                    <button class="btn btn-outline-light btn-sm text-secondary d-none mx-auto" onclick="closeSidebar()"
                            id="closeSidebar">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <nav class="flex-grow-1">
                    <ul class="nav flex-column ">
                        <li class="nav-item">
                            <a class="nav-link text-primary px-3 py-3" href="dashboard.jsp">
                                <i class="fas fa-tachometer-alt me-2 sidebar-icon"></i>
                                <span class="sidebar-text">Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-primary px-3 py-3" href="statistics.jsp">
                                <i class="fas fa-chart-line me-2 sidebar-icon"></i>
                                <span class="sidebar-text">Thống kê doanh thu</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-primary px-3 py-3" href="users.jsp">
                                <i class="fas fa-users me-2 sidebar-icon"></i>
                                <span class="sidebar-text">Quản lý người dùng</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-primary px-3 py-3" href="products.jsp">
                                <i class="fas fa-box me-2 sidebar-icon"></i>
                                <span class="sidebar-text">Quản lý sản phẩm</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-primary px-3 py-3" href="orders/orders.jsp">
                                <i class="fas fa-shopping-cart me-2 sidebar-icon"></i>
                                <span class="sidebar-text">Quản lý đơn hàng</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-primary px-3 py-3" href="brands.html">
                                <i class="fas fa-tags me-2 sidebar-icon"></i>
                                <span class="sidebar-text">Quản lý thương hiệu</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-primary px-3 py-3" href="events.jsp">
                                <i class="fas fa-calendar-alt me-2 sidebar-icon"></i>
                                <span class="sidebar-text">Quản lý sự kiện</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-primary px-3 py-3" href="handbooks.jsp">
                                <i class="fas fa-newspaper me-2 sidebar-icon"></i>
                                <span class="sidebar-text">Quản lý bài viết</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </aside>

        <button class="btn btn-outline-secondary d-none fixed-top ms-3 mt-3 z-1 w-lg-3 w-md-5" onclick="openSidebar()"
                id="openSidebarBtn">
            <i class="fas fa-bars"></i>
        </button>

        <main class="col-md-9 col-lg-10" id="mainContent">

        </main>
    </div>
</div>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

