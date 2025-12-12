<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản Trị - Bản nháp</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="css/post-handbook.css"/>
    <link rel="stylesheet" href="../css/root.css">

    <style>
        .card {
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: scale(1.02);
        }

        .add-card {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
            min-height: 250px;
            border: 2px dashed #aaa;
            border-radius: 15px;
            color: #666;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .add-card:hover {
            background: #f8f9fa;
            color: #000;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding-top: 120px;
            padding-bottom: 20px;
            background-color: #ffffff;
        }

        .badge {
            background-color: #e8d9e5;
            color: #901297;
            border-radius: 8px;
            padding: 4px 10px;
            font-weight: 500;
        }
    </style>
</head>

<body>
<div class="header">
    <div class="header-content">
        <h1>Bản nháp của bạn</h1>
        <div class="header-buttons">
            <a href="handbooks.jsp" class="btn btn-add">
                <i class="bi bi-arrow-left me-2"></i> Quay lại
            </a>
        </div>
    </div>
</div>

<div class="container">
    <div class="row g-4">
        <!-- Cột thêm mới -->
        <a
                href="post-handbook.jsp"
                class="image-upload col-md-4 d-flex flex-column align-items-center justify-content-center"
                style="cursor: pointer; color: #cf102d; text-decoration: none;"
        >
            <i class="bi bi-plus-circle fs-1 mb-2"></i>
            <span class="fs-5">Thêm mới bài viết</span>
        </a>

        <!-- Bài viết 1 -->
        <div class="col-md-4">
            <div class="card shadow-sm">
                <img
                        src="https://www.mykingdom.com.vn/cdn/shop/articles/lego-xmas_c98d4a73-8a0b-449c-81a1-b85e595ab1fc.jpg?v=1762928950"
                        class="card-img-top"
                        alt="LEGO Sale"
                />
                <div class="card-body">
                    <h5 class="card-title">
                        LEGO Xmas Sale 40% – Quà Giáng Sinh lý tưởng cho bạn
                    </h5>
                    <p class="text-muted small mb-2">12.11.2025 - BTV Nguyễn Yến</p>
                    <p class="card-text">
                        Chào đón mùa Giáng Sinh, MyKingdom giới thiệu chương trình
                        khuyến mãi hấp dẫn LEGO XMAS với giảm đến 40%...
                    </p>
                    <div class="d-flex justify-content-between">
                        <a href="#" class="text-danger fw-semibold">Xem thêm</a>

                        <span class="badge-published">Bản nháp</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bài viết 2 -->
        <div class="col-md-4">
            <div class="card shadow-sm">
                <img
                        src="https://www.mykingdom.com.vn/cdn/shop/articles/do-choi-phan-xa-cho-be_d5318d9a-2c93-4185-8999-0aa6bcaa6ad5.jpg?v=1762231299"
                        class="card-img-top"
                        alt="Jinx macro"
                />
                <div class="card-body">
                    <h5 class="card-title">
                        Trò chơi luyện phản xạ cho bé: Vừa vui vừa thông minh!
                    </h5>
                    <p class="text-muted small mb-2">13.11.2025 - BTV Nguyễn Yến</p>
                    <p class="card-text">
                        Ngày nay, ba mẹ thường chọn đồ chơi phản xạ cho bé để giúp bé
                        rèn luyện khả năng phản ứng nhanh nhạy cũng như khả năng...
                    </p>
                    <div class="d-flex justify-content-between">
                        <a href="#" class="text-danger fw-semibold">Xem thêm</a>

                        <span class="badge-published">Bản nháp</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
