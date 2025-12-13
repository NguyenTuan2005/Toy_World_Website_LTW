<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Bài Viết</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/admin-base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminPages/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css"/>
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý bài viết</h1>
                </div>
                <div class="col-auto">
                    <a href="handbook-drafts.jsp" class="btn-add fw-medium px-4 py-2 text-decoration-none">
                        <i class="fas fa-plus me-2"></i>Thêm bài viết mới
                    </a>
                    <!-- <button class="btn btn-add">
                      <i class="fas fa-plus me-2"></i>Thêm bài viết mới
                    </button> -->
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-3">
        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="search-wrapper">
                        <i class="fas fa-search search-icon"></i>
                        <input
                                type="text"
                                class="search-input"
                                placeholder="Tìm theo tiêu đề hoặc tác giả ..."
                        />
                    </div>
                </div>
                <div class="col-md-6 text-end mt-3 mt-md-0">
                    <i
                            class="fas fa-filter filter-icon"
                            style="color: #cf102d"
                    ></i>
                    <select class="status-select">
                        <option>Tất cả trạng thái</option>
                        <option>Đã đăng</option>
                        <option>Bản nháp</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="table-container">
            <table class="table">
                <thead>
                <tr>
                    <th>Ảnh bìa</th>
                    <th>Tiêu đề</th>
                    <th>Tác giả</th>
                    <th>Danh Mục</th>
                    <th>Trạng thái</th>
                    <th>Lượt xem</th>
                    <th>Ngày đăng</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <img
                                src="https://www.mykingdom.com.vn/cdn/shop/files/header_banner_1280x496_c1a610e8-1a7a-4737-af85-609019a662af.jpg?v=1762528195&width=1200"
                                class="thumb-img w-75"
                                alt="thumbnail"
                        />
                    </td>
                    <td class="bold-title">
                        Europe toy fair - Lễ hội đồ chơi châu âu 2025 – Ưu đãi đến
                        40% tại Mykingdom
                    </td>
                    <td class="author-name">BTV Nguyễn Yến</td>
                    <td class="category-name">hotdeal</td>
                    <td class="text-nowrap">
                        <span class="badge bg-success">Đã Đăng</span>
                    </td>

                    <td>1200</td>
                    <td class="date-text">23/9/2025</td>
                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none">
                                <i class="fas fa-edit"></i>
                            </button>

                            <button class="btn btn-link text-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img
                                src="https://www.mykingdom.com.vn/cdn/shop/articles/do-choi-tri-tue-cho-be-6-9-tuoi_0c2a3283-b493-44f6-8e2d-db8803a38067.jpg?v=1761885332"
                                class="thumb-img w-75"
                                alt="thumbnail"
                        />
                    </td>
                    <td class="bold-title">
                        Top 5 đồ chơi trí tuệ cho bé 6 - 9 tuổi đáng mua 2025
                    </td>
                    <td class="author-name">BTV Nguyễn Yến</td>
                    <td class="category-name">Tu 6-9 tuoi</td>
                    <td class="text-nowrap">
                        <span class="badge bg-success">Đã Đăng</span>
                    </td>
                    <td>1200</td>
                    <td class="date-text">23/5/2025</td>
                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none">
                                <i class="fas fa-edit"></i>
                            </button>

                            <button class="btn btn-link text-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img
                                src="https://www.mykingdom.com.vn/cdn/shop/articles/tro-choi-luyen-phan-xa-cho-be_66055d2e-9b26-4bc3-b2d1-d8bebef7fff8.jpg?v=1761364615"
                                class="thumb-img w-75"
                                alt="thumbnail"
                        />
                    </td>
                    <td class="bold-title">
                        Trò chơi luyện phản xạ cho bé: Vừa vui vừa thông minh!
                    </td>
                    <td class="author-name">BTV Bình Dương</td>
                    <td class="category-name">mkd-blogs</td>
                    <td class="text-nowrap">
                        <span class="badge bg-warning">Bản nháp</span>
                    </td>
                    <td>1200</td>
                    <td class="date-text">1/8/2025</td>
                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none">
                                <i class="fas fa-edit"></i>
                            </button>

                            <button class="btn btn-link text-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img
                                src="https://www.mykingdom.com.vn/cdn/shop/articles/mykingdom-hoat-dong-chuc-mung-ngay-20-11_ad891727-10a0-4a14-98fe-bfe61281fafa.jpg?v=1762508072"
                                class="thumb-img w-75"
                                alt="thumbnail"
                        />
                    </td>
                    <td class="bold-title">
                        Những hoạt động chúc mừng ngày 20/11 dành cho trẻ mầm non
                    </td>
                    <td class="author-name">BTV Phương Nhi</td>
                    <td class="category-name">mkd-blogs</td>
                    <td class="text-nowrap">
                        <span class="badge bg-success">Đã Đăng</span>
                    </td>
                    <td>1200</td>
                    <td class="date-text">18/11/2025</td>
                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none">
                                <i class="fas fa-edit"></i>
                            </button>

                            <button class="btn btn-link text-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img
                                src="https://www.mykingdom.com.vn/cdn/shop/articles/mykingdom-qua-noel-cho-be-gai_fbe9580d-db03-439c-b066-001cc17385c3.jpg?v=1762508248"
                                class="thumb-img w-75"
                                alt="thumbnail"
                        />
                    </td>
                    <td class="bold-title">
                        Top 10 món quà Noel đáng yêu và ý nghĩa cho bé gái
                    </td>
                    <td class="author-name">BTV Nguyễn Yến</td>
                    <td class="category-name">noel</td>
                    <td class="text-nowrap">
                        <span class="badge bg-success">Đã Đăng</span>
                    </td>
                    <td>1200</td>
                    <td class="date-text">23/9/2025</td>
                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none">
                                <i class="fas fa-edit"></i>
                            </button>

                            <button class="btn btn-link text-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img
                                src="https://www.mykingdom.com.vn/cdn/shop/articles/hot-wheels-co-sac-nhon-khong_951dbe07-2825-43b5-bc09-51880c0b6a88.jpg?v=1762136684"
                                class="thumb-img w-75"
                                alt="thumbnail"
                        />
                    </td>
                    <td class="bold-title">
                        Hot Wheels có sắc nhọn không? Giải đáp thắc mắc phụ huynh
                    </td>
                    <td class="author-name">BTV Nguyễn Yến</td>
                    <td class="category-name">mkd-blog</td>
                    <td class="text-nowrap">
                        <span class="badge bg-success">Đã Đăng</span>
                    </td>
                    <td>1200</td>
                    <td class="date-text">23/1/2025</td>
                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-link text-primary text-decoration-none">
                                <i class="bi bi-eye-fill"></i>
                            </button>

                            <button class="btn btn-link text-success text-decoration-none">
                                <i class="fas fa-edit"></i>
                            </button>

                            <button class="btn btn-link text-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>

            <hr class="mx-5"/>
            <div
                    class="d-flex justify-content-between align-items-center m-3"
            >
                <p class="mb-0">Hiển thị 6 trong 100 bài viết</p>

                <nav>
                    <ul class="pagination mb-0">
                        <li class="page-item disabled">
                            <a class="page-link">|&lt;</a>
                        </li>
                        <li class="page-item disabled">
                            <a class="page-link">&lt;</a>
                        </li>

                        <li class="page-item active">
                            <a class="page-link">1</a>
                        </li>
                        <li class="page-item"><a class="page-link">2</a></li>
                        <li class="page-item"><a class="page-link">3</a></li>
                        <li class="page-item"><a class="page-link">4</a></li>
                        <li class="page-item"><a class="page-link">5</a></li>
                        <li class="page-item"><a class="page-link">…</a></li>
                        <li class="page-item"><a class="page-link">10</a></li>

                        <li class="page-item">
                            <a class="page-link">&gt;</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link">&gt;|</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>


</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
