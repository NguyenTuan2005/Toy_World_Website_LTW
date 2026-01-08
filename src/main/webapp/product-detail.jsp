<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name}</title>

    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <jsp:include page="/common/head.jsp"/>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/root.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product-details.css">
    <style>

    </style>

</head>

<body>
<!-- header -->
<jsp:include page="/common/header.jsp"/>

<div class="container my-5">
    <div class="row">
        <!-- Product Images Section -->
        <div class="col-md-6">
            <div class="product-image-main position-relative">
                <img id="mainImage"
                     src="${product.imagePaths.get(0)}"
                     alt="${product.name}"
                     class="img-fluid"
                     data-bs-toggle="modal"
                     data-bs-target="#imageModal"
                     style="cursor: zoom-in;">
            </div>

            <div class="thumbnail-container">
                <c:forEach items="${product.imagePaths}" var="img" varStatus="status">
                    <div class="thumbnail ${status.first ? 'active' : ''}"
                         data-image="${img}">
                        <img src="${img}" alt="Thumbnail ${status.index + 1}">
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Modal zoom ảnh sản phẩm -->
        <div class="modal fade" id="imageModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content modal-content border border-1 shadow-sm">
                    <div class="modal-body text-center">
                        <img id="modalImage" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>


        <!-- Product Info Section -->
        <div class="col-md-6">
            <div class="product-info">
                <div class="d-flex align-items-center justify-content-between">
                    <h4 class="product-title mb-0">${product.name}</h4>

                    <i class="bi bi-heart wishlist-icon fs-2"
                       data-product-id="${product.id}"
                       title="Thêm vào danh sách yêu thích"></i>
                </div>

                <div class="brand-badge my-2">
                    Thương hiệu: <a href="#" class="text-decoration-none">${product.brandName}</a>
                </div>

                <div class="price-section my-3">
                    <span class="brand-badge me-2">Giá Bán: </span>
                    <c:if test="${product.promotionId != null}">
                        <span class="price-current">
                        <fmt:formatNumber value="${product.discountPrice}" type="currency" currencyCode="VND"/>
                        </span>
                        <span class="price-original">
                            <fmt:formatNumber value="${product.originalPrice}" type="currency" currencyCode="VND"/>
                        </span>
                        <span class="discount-badge">
                            -<fmt:formatNumber value="${product.discountPercent}" maxFractionDigits="0"/>%
                        </span>
                    </c:if>

                    <c:if test="${product.promotionId == null}">
                        <span class="price-current">
                        <fmt:formatNumber value="${product.originalPrice}" type="currency" currencyCode="VND"/>
                        </span>
                    </c:if>

                </div>

                <ul class="features-list">
                    <li>Hàng chính hãng</li>
                    <li>Miễn phí giao hàng toàn quốc cho đơn hàng từ 500k</li>
                    <li>Giao hàng nội bộ 4-6 tiếng</li>
                    <li>Mở hộp và kiểm tra hàng trước khi nhận.</li>
                </ul>

                <div class="quantity-selector">
                    <strong>Số lượng</strong>
                    <div class="quantity-input">
                        <button type="button" id="decreaseQty">-</button>
                        <input type="number" id="quantity" value="1" min="1">
                        <button type="button" id="increaseQty">+</button>
                    </div>
                </div>

                <button class="btn-add-cart">Thêm Vào Giỏ Hàng</button>

                <c:choose>
                    <c:when test="${not empty product.restInfo}">
                        <c:forEach items="${product.restInfo}" var="entry">
                            <div class="spec-row">
                                <div class="spec-label">${entry.key}</div>
                                <div class="spec-value">${entry.value}</div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>Chưa có thông tin chi tiết</p>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>
</div>

<!-- Product Description Section -->
<div class="row mt-4">
    <div class="col-12">
        <div class="product-description">
            <hr class="desc-line">
            <br>
            <h4 class="fs-5 ms-2">Mô tả sản phẩm</h4>
            <div class="description-content" id="desc">
                <span class="fs-4 pb-2">${product.name}</span>
                <p>
                    ${product.description}
                </p>
            </div>
        </div>
    </div>
</div>

<div class="container  my-4 p-3 rounded">
    <div class="row text-center justify-content-center">
        <div class="col-6 col-md-3 mb-3">
            <img src="https://cdn.shopify.com/s/files/1/0917/5207/1482/files/trust_badge_update_1.webp?v=1761109355"
                 alt="Sản phẩm chính hãng" class="img-fluid mb-2" style="max-height: 120px;">
            <p class="fw-semibold mb-0">Sản phẩm <span class="text-nowrap">chính hãng 100%</span></p>
        </div>

        <div class="col-6 col-md-3 mb-3">
            <img src="https://cdn.shopify.com/s/files/1/0917/5207/1482/files/trust_badge_update_2.webp?v=1761109355"
                 alt="Nhựa an toàn" class="img-fluid mb-2" style="max-height: 120px;">
            <p class="fw-semibold mb-0">Nhựa an toàn <span class="text-nowrap">cho trẻ em</span></p>
        </div>

        <div class="col-6 col-md-3 mb-3">
            <img src="https://cdn.shopify.com/s/files/1/0917/5207/1482/files/trust_badge_update_3.webp?v=1761109355"
                 alt="Miễn phí giao hàng" class="img-fluid mb-2" style="max-height: 120px;">
            <p class="fw-semibold mb-0">Miễn phí giao hàng <span class="text-nowrap">đơn từ 500K</span></p>
        </div>

        <div class="col-6 col-md-3 mb-3">
            <img src="https://cdn.shopify.com/s/files/1/0917/5207/1482/files/trust_badge_update_4.webp?v=1761109355"
                 alt="Giao hàng hỏa tốc" class="img-fluid mb-2" style="max-height: 120px;">
            <p class="fw-semibold mb-0">Giao hàng <span class="text-nowrap">hỏa tốc 4 tiếng</span></p>
        </div>
    </div>
</div>

<%--User comments--%>
<div class=" container  my-4 p-3 mt-4 bg-white border rounded shadow-sm">

    <h4 class="mb-3">Bình luận</h4>

    <!-- Ô thêm bình luận -->
    <c:if test="${not empty sessionScope.currentUser}">
        <form action="${pageContext.request.contextPath}/comment/create" method="post" id="comment-form">
            <input type="hidden" name="productId" value="${product.id}"/>
            <div class="mb-4">
                <label class="form-label fw-semibold">Thêm bình luận</label>

                <div class="d-flex">
                    <img src="https://cdn-icons-png.freepik.com/512/12886/12886347.png"
                         class="rounded-circle me-3"
                         width="45" height="45"/>

                    <textarea name="content"
                              class="form-control"
                              rows="3"
                              placeholder="Viết bình luận của bạn..."
                              required></textarea>
                </div>

                <div class="text-end mt-2">
                    <button type="submit" class="btn btn-primary btn-sm">
                        Gửi bình luận
                    </button>
                </div>
            </div>
        </form>
    </c:if>

    <c:if test="${empty sessionScope.currentUser}">
        <p class="text-muted">Vui lòng đăng nhập để bình luận.</p>
    </c:if>


    <hr/>

    <!-- Danh sách bình luận -->
    <div class="mt-3" id="commentSection">

        <c:forEach items="${product.comments}" var="comment" varStatus="status">
            <div class="d-flex mb-3 comment-item
        <c:if test='${status.index >= 2}'>d-none extra-comment</c:if>">

                <img src="https://cdn-icons-png.freepik.com/512/12886/12886347.png"
                     class="rounded-circle me-3" width="40" height="40"/>

                <div class="bg-light p-3 rounded w-100">
                    <strong>${comment.userName}</strong>
                    <p class="mb-1">${comment.content}</p>
                    <small class="text-muted">${comment.createdAtToString}</small>
                </div>
            </div>
        </c:forEach>


        <c:if test="${product.comments.size() > 2}">
            <div class="text-end mt-2">
                <button class="btn btn-outline-primary btn-sm"
                        id="btnShowMore"
                        onclick="showMoreComments()">
                    Xem thêm
                </button>
            </div>
        </c:if>
    </div>


</div>

<jsp:include page="/common/footer.jsp"/>

<script src="js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/product-detail.js"></script>
<script>
    function showMoreComments() {
        const hiddenComments = document.querySelectorAll('.extra-comment');
        hiddenComments.forEach(c => c.classList.remove('d-none'));

        document.getElementById('btnShowMore').style.display = 'none';
    }

    document.getElementById('imageModal')
        .addEventListener('show.bs.modal', function (e) {
            document.getElementById('modalImage').src =
                e.relatedTarget.src;
        });
</script>

</body>
</html>