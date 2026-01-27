<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="now" class="java.util.Date"/>
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
</head>

<body>
<jsp:include page="/common/sidebar.jsp"></jsp:include>

<main class="main-content">
    <div class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="page-title">Quản lý sự kiện</h1>
                </div>
                <div class="nav col d-flex gap-2 justify-content-end">
                    <button class="nav-link btn-nav  fw-medium px-4 py-2 text-decoration-none"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/events'">
                        <i class="fas fa-calendar-check me-2"></i>Events
                    </button>

                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none active" type="button"
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/promotions'">
                        <i class="fas fa-percentage me-2"></i>Promotions
                    </button>


                    <button class="nav-link btn-nav fw-medium px-4 py-2 text-decoration-none "
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/events'">
                        <i class="fas fa-image me-2"></i>Banners
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-content">
        <script>
            document.getElementById("searchInput")
                .addEventListener("keydown", function (e) {
                    if (e.key === "Enter") {
                        e.preventDefault(); // tránh reload không mong muốn
                        document.getElementById("searchForm").submit();
                    }
                });
        </script>
        <!-- Promotions Tab -->
        <div class="tab-pane active fade show container mb-3"  id="promotions">
            <div class="filter-section">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="search-wrapper">
                            <form class="mb-0" id="searchForm"  action="${pageContext.request.contextPath}/admin/promotions" method="post">
                                <input
                                        type="text"
                                        id="searchInput"
                                        class="search-input"
                                        name="keyword"
                                        placeholder="Nhập  Tên"
                                />
                            </form>
                        </div>
                    </div>
                    <div class="col-md-6 d-flex align-items-center justify-content-end">
                        <c:if test="${find_promotions != null }">
                            <nav>
                                <ul class="pagination mb-0 me-2">
                                    <li class="page-item"><a  class="page-link" href="${pageContext.request.contextPath}/admin/promotions">Load lại bảng</a></li>
                                </ul>
                            </nav>
                        </c:if>
                        <a class="btn-add fw-medium px-4 py-2 text-decoration-none"  href="${pageContext.request.contextPath}/admin/new-promotions"
                                data-bs-target="#promotionModal">
                            <i class="fas fa-plus"></i> Thêm promotion
                        </a>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Mã</th>
                        <th>Tên promotion</th>
                        <th> % </th>
                        <th> Giảm tối đa </th>
                        <th>Thời hạn</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${promotions}" var="prom">
                        <tr>
                            <td class="bold-title" >${prom.id}</td>
                            <td  class="bold-title" >${prom.name}</td>
                            <td>
                                <span class="badge bg-success">  -${prom.discountPercent}%</span>
                            </td>
                            <td>
                                <span class="badge bg-success"> -<fmt:formatNumber value="${prom.discountPrice}" type="currency"/> </span>
                            </td>

                            <td>${prom.expiredAtFormatted}</td>
                            <td class="text-nowrap">
                                <c:choose>
                                    <c:when test="${prom.active}">
                                        <span class="badge bg-success">Hoạt động</span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="badge bg-danger">ẩn</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="d-flex gap-2">

                                    <button class="btn btn-link text-success text-decoration-none"   onclick="window.location.href='${pageContext.request.contextPath}/admin/update-promotions?promotionId=${prom.id}'">
                                        <i class="fas fa-edit"></i>
                                    </button>

                                    <form method="post" action="/childrentoyweb_war/admin/hidden-promotions"
                                          onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật không?');"
                                          class ="mb-0">
                                        <input type="hidden" name="promotionId" value="${prom.id}">
                                        <button class="btn btn-link text-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <hr class="mx-5"/>
                <div class="d-flex justify-content-between align-items-center m-3">
                    <p class="mb-0">
                        Hiển thị ${pageSize_promotion} trong ${totalElements_promotion} giam gia,
                        trang hiện tại ${currentPage_promotion },
                        tổng trang ${totalPages_promotion}
                    </p>

                    <nav>
                        <ul class="pagination mb-0">
                            <c:forEach var="i" begin="0" end="${totalPages_promotion - 1}" varStatus="st">

                                <c:choose>
                                    <c:when test="${st.index+1 == currentPage_promotion}">
                                        <li class="page-item active">
                                            <a class="page-link"
                                               href="${pageContext.request.contextPath}/admin/promotions?promotion-page=${st.index + 1}">
                                                    ${st.index + 1}
                                            </a>
                                        </li>
                                    </c:when>

                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="${pageContext.request.contextPath}/admin/promotions?promotion-page=${st.index + 1}">
                                                    ${st.index + 1}
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>





</main>
<script>
    function savePromotion() {
        const form = document.getElementById("promotionForm");
        const formData = new FormData(form);
        console.log("My Data: ")
        console.log(formData)
        fetch("/childrentoyweb_war/admin/promotions", {
            method: 'POST',
            credentials: "include",
            // headers: { 'Content-Type': 'application/json' },
            body: formData
        })
            .then(res => res.json())
            .then(data => {
                if(data.success){
                    alert("Tạo promotion thành công!");

                    // Đóng modal
                    const modal = bootstrap.Modal.getInstance(
                        document.getElementById("promotionModal")
                    );
                    modal.hide();

                    // TODO: reload table nếu cần
                    // loadPromotions();
                    console.log("bug :)))) ")

                }else{
                    alert(data.message);
                }
            })
            .catch(err => {
                console.error(err);
                alert("Lỗi server!");
            });
    }
</script>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
