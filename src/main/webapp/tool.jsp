<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Công cụ - Toy World</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <fmt:setLocale value="vi_VN"/>
    <style>
        .tool-feature {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
        }
        .tool-feature h5 {
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #333;
        }
        .tool-feature p {
            color: #666;
            margin-bottom: 0;
        }
        .download-section {
            background: #f8f9fa;
            padding: 3rem 0;
            text-align: center;
        }
    </style>
</head>
<body>
<jsp:include page="/common/header.jsp" />

<!-- Breadcrumb -->
<div class="top-bar" role="navigation" aria-label="Breadcrumb and page header">
    <div class="container">
        <nav class="breadcrumb" aria-label="Breadcrumb" style="margin-left: -1px;">
            <a href="${pageContext.request.contextPath}/home" aria-label="Trang Chủ">Trang Chủ</a>
            <svg class="crumb-sep" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M9 6l6 6-6 6" stroke="#8b8b8b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <a href="${pageContext.request.contextPath}/tool" aria-label="Công cụ" style="width: 235px; color:#444;">Công cụ</a>
        </nav>
    </div>
</div>

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

<!-- Main Content -->
<div class="container my-5">
    <!-- Introduction Section -->
    <section class="mb-5">
        <h2 class="text-center fw-bold mb-4">Giới thiệu Công cụ</h2>
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <p class="lead text-center mb-4">
                    Công cụ mã hóa của chúng tôi cung cấp một giải pháp an toàn và dễ sử dụng để tạo chữ ký điện tử.
                </p>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="mb-5">
        <div class="row">
            <div class="col-md-6">
                <div class="tool-feature">
                    <div>
                        <h5>Mã hóa Mạnh Mẽ</h5>
                        <p>Hỗ trợ các thuật toán DSA 2048-bit và cao hơn để đảm bảo an toàn tối đa cho dữ liệu của bạn.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="tool-feature">
                    <div>
                        <h5>Xử Lý Tệp và Văn Bản</h5>
                        <p>Mã hóa các tệp lớn hoặc nhập liệu từ văn bản trực tiếp với giao diện thân thiện.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="tool-feature">
                    <div>
                        <h5>Quản Lý Khóa Dễ Dàng</h5>
                        <p>Tạo, nhập khẩu, xuất và lưu trữ các khóa công khai/riêng tư một cách an toàn.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="tool-feature">
                    <div>
                        <h5>Ký Số Tài Liệu</h5>
                        <p>Xác thực tính chính thực và tính toàn vẹn của tài liệu bằng chữ ký số.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Download Section -->
    <section class="download-section">
        <h2 class="fw-bold mb-4">Tải Về Công Cụ</h2>
        <p class="mb-4" style="font-size: 1.1rem; color: #666;">
            Tải xuống phiên bản mới nhất của công cụ mã hóa bất đối xứng
        </p>
        <div>
            <a href="${pageContext.request.contextPath}/download-tool?os=window" class="download-btn text-primary">
                <i class="fas fa-download me-2"></i>Tải về (Windows)
            </a>
            <a href="${pageContext.request.contextPath}/download-tool?os=linux" class="download-btn text-primary ms-4">
                <i class="fas fa-download me-2"></i>Tải về (Linux)
            </a>
        </div>
    </section>

    <!-- Support Section -->
    <section class="mb-5">
        <h2 class="text-center fw-bold mb-4">Hỗ Trợ & Tài Liệu</h2>
        <div class="row">
            <div class="col-md-4 text-center mb-4">
                <div class="card border-0 h-100 shadow-sm">
                    <div class="card-body">
                        <i class="fas fa-book fa-2x text-primary mb-3"></i>
                        <h5 class="card-title fw-bold">Hướng Dẫn Sử Dụng</h5>
                        <p class="card-text">Tìm hiểu cách sử dụng công cụ với hướng dẫn chi tiết từng bước.</p>
                        <a href="${pageContext.request.contextPath}/handbook" class="btn btn-sm btn-primary">Xem Tài Liệu</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 text-center mb-4">
                <div class="card border-0 h-100 shadow-sm">
                    <div class="card-body">
                        <i class="fas fa-envelope fa-2x text-primary mb-3"></i>
                        <h5 class="card-title fw-bold">Liên Hệ</h5>
                        <p class="card-text">Có câu hỏi? Liên hệ với đội hỗ trợ của chúng tôi ngay.</p>
                        <a href="${pageContext.request.contextPath}/contact" class="btn btn-sm btn-primary">Liên Hệ Ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<jsp:include page="/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/sign-up.js"></script>
</body>
</html>
