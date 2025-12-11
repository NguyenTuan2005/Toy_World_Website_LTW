<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Quản trị - Quản Lý Bài Viết</title>

    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    />
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"
    />
    <link rel="stylesheet" href="css/handbook.css"/>
    <link rel="stylesheet" href="css/index.css"/>
    <link rel="stylesheet" href="../css/root.css"/>
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý thương hiệu</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="search-wrapper">
                        <i class="fas fa-search search-icon"></i>
                        <input
                                type="text"
                                class="search-input"
                                placeholder="Tìm theo tên thương hiệu..."
                        />
                    </div>
                </div>
                <div class="col-md-6 text-end mt-3 mt-md-0">
                    <button class="btn-add fw-medium px-4 py-2 text-decoration-none" data-bs-toggle="modal" data-bs-target="#brandModal">
                        <i class="fas fa-plus"></i> Thêm thương hiệu
                    </button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <table class="table">
                <thead>
                <tr>
                    <th>Ảnh Logo</th>
                    <th>Tên Thương Hiệu</th>
                    <th>Số Lượng Sản Phẩm</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><img
                            src="https://www.mykingdom.com.vn/cdn/shop/files/LEGO_SEASONS_AND_OCCASIONS.png?v=1760351932"
                            alt="Ninjago" class="img-thumbnail">
                    </td>
                    <td>Ninjago</td>
                    <td>125</td>
                    <td class="text-nowrap"><span class="badge bg-success">Hoạt động</span></td>
                    <td>15/01/2024</td>
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
                    <td><img
                            src="https://www.mykingdom.com.vn/cdn/shop/files/LEGO_SEASONS_AND_OCCASIONS.png?v=1760351932"
                            alt="Ninjago" class="img-thumbnail">
                    </td>
                    <td>Ninjago</td>
                    <td>125</td>
                    <td class="text-nowrap"><span class="badge bg-danger">Tạm Khóa</span></td>
                    <td>15/01/2024</td>
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
                <p class="mb-0">Hiện thị 2 trong 100 Thương hiệu</p>

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

    <div class="modal fade" id="brandModal" tabindex="-1" aria-labelledby="brandModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="brandModalLabel">Thêm thương hiệu</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="brandName" class="form-label">Tên thương hiệu</label>
                            <input type="text" class="form-control" id="brandName" placeholder="Nhập tên thương hiệu">
                        </div>
                        <div class="mb-3">
                            <label for="brandLogo" class="form-label">Logo thương hiệu</label>
                            <input type="file" class="form-control" id="brandLogo" accept="image/*">
                        </div>
                        <div class="mb-3 form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="brandStatus" checked>
                            <label class="form-check-label" for="brandStatus">
                                Hoạt động
                            </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Lưu</button>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
