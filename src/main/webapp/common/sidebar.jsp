<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
        :root {
            --sidebar-width: 280px;
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

        .main-content {
            margin-left: var(--sidebar-width);
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #dc3545, #b02a37);
        }
    </style>

<div class="sidebar bg-white shadow">
    <!-- Header -->
    <div class="p-4 text-center border-bottom border-danger">
        <img src="${pageContext.request.contextPath}/ToyWorldLogo.png" alt="Toy World Logo" class="img-fluid">
    </div>

    <!-- Menu -->
    <ul class="list-unstyled py-3">
        <li class="px-3 mb-1">
            <a href="dashboard.jsp" class="menu-link active d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-home"></i></span>
                <span class="flex-grow-1">Dashboard</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="statistics.jsp" class="menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-chart-line"></i></span>
                <span class="flex-grow-1">Thống kê doanh thu</span>
            </a>
        </li>

        <p class="text-secondary text-uppercase small fw-bold px-4 mt-3 mb-2" style="font-size: 0.7rem; letter-spacing: 1px;">Quản lý</p>

        <li class="px-3 mb-1">
            <a href="users.jsp" class="menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-users"></i></span>
                <span class="flex-grow-1">Quản lý người dùng</span>
                <span class="badge bg-danger rounded-pill">12</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="products.jsp" class="menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-box-open"></i></span>
                <span class="flex-grow-1">Quản lý sản phẩm</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="orders.jsp" class="menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-shopping-cart"></i></span>
                <span class="flex-grow-1">Quản lý đơn hàng</span>
                <span class="badge bg-danger rounded-pill">5</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="brands.jsp" class="menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-tag"></i></span>
                <span class="flex-grow-1">Quản lý thương hiệu</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="events.jsp" class="menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-calendar-alt"></i></span>
                <span class="flex-grow-1">Quản lý sự kiện</span>
            </a>
        </li>

        <li class="px-3 mb-1">
            <a href="handbooks.jsp" class="menu-link d-flex align-items-center text-danger text-decoration-none p-3 rounded-3 fw-medium transition-all">
                <span class="me-3 fs-5"><i class="fas fa-newspaper"></i></span>
                <span class="flex-grow-1">Quản lý bài viết</span>
            </a>
        </li>
    </ul>

    <!-- Footer -->
    <div class="position-absolute bottom-0 start-0 end-0 p-3 border-top border-danger bg-light">
        <div class="d-flex align-items-center gap-2">
            <div class="user-avatar rounded-circle d-flex align-items-center justify-content-center text-white fw-bold">A</div>
            <div class="flex-grow-1">
                <p class="text-danger fw-semibold mb-0 small">Admin</p>
                <p class="text-secondary mb-0" style="font-size: 0.75rem;">Quản trị viên</p>
            </div>
            <a href="logout.jsp" class="text-danger" title="Đăng xuất">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const currentPage = window.location.pathname.split('/').pop();
        document.querySelectorAll('.menu-link').forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === currentPage) {
                link.classList.add('active', 'bg-danger', 'bg-opacity-10');
            }
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>