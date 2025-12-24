<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<header class="bg-white shadow-sm">
    <div class="container-fluid py-2 root-red-background">
        <div class="d-flex align-items-center justify-content-center flex-wrap">
            <!-- Logo -->
            <div class="d-flex align-items-center">
                <img
                        src="${pageContext.request.contextPath}/assets/ToyWorldLogo.png"
                        alt="Logo"
                        class="img-fluid"
                        onclick="window.location.href='${pageContext.request.contextPath}/'"
                        style="width: 190px; height: 50px"
                />
            </div>
            <!-- Logo -->
            <!-- Search bar -->
            <div class="flex-grow-1 mx-4" style="max-width: 470px">
                <div class="input-group">
                <span class="input-group-text bg-white border-end-0">
                <img
                        src="https://cdn-icons-png.flaticon.com/512/622/622669.png"
                        alt="Search"
                        width="18"
                        height="18"
                />
                </span>
                    <input
                            type="text"
                            class="form-control border-start-0"
                            placeholder="Nhập từ khóa để tìm kiếm (ví dụ: lắp ráp, mô hình, ba lô,...)"
                    />
                </div>
            </div>
            <style>

            </style>
            <!-- Account + Cart -->
            <div class="header-section text-center">
                <div class="d-flex justify-content-center align-items-center gap-4">
                    <!-- Login -->
                    <c:if test="${sessionScope.currentUser == null}">
                        <button class="btn d-flex align-items-center"
                                onclick="window.location.href='${pageContext.request.contextPath}/login'">
                            <i class="bi bi-person-circle me-2"></i>
                            Đăng nhập
                        </button>
                    </c:if>

                    <!-- Cart -->

                    <button class="btn d-flex align-items-center"
                            onclick="window.location.href='${pageContext.request.contextPath}/'">
                        <i class="bi bi-basket2-fill me-2"></i>
                        <c:if test="${sessionScope.cart != null}">
                            Giỏ hàng(${sessionScope.cart.totalQuantity})
                        </c:if>
                        <c:if test="${sessionScope.cart == null}">
                            Giỏ hàng
                        </c:if>
                    </button>

                    <%--                    tài khoản--%>
                    <c:if test="${sessionScope.currentUser != null}">
                        <button class="btn d-flex align-items-center"
                                onclick="window.location.href='${pageContext.request.contextPath}/account'">
                            <i class="bi bi-person-circle me-2"></i>
                            <div>%${sessionScope.currentUser.firstName}</div>
                        </button>
                    </c:if>


                </div>
            </div>
        </div>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light root-red-background">
            <div class="container-fluid root-red-background d-flex align-items-center">
                <!-- Menu - ẩn khi màn hình nhỏ -->
                <div
                        class="collapse navbar-collapse justify-content-center"
                        id="navbarContent">

                    <ul class="navbar-nav fw-bold text-uppercase gap-3">
                        <li class="nav-item mx-2">
                            <a
                                    class="nav-link text-white d-flex align-items-center"
                                    href="${pageContext.request.contextPath}/products"
                            >
                                Sản Phẩm
                                <img
                                        src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/icon-lego.gif?v=1743483192"
                                        class="ms-2"
                                        width="28"
                                        height="25"
                                />
                            </a>

                        </li>
                        <li class="nav-item mx-2">
                            <a
                                    class="nav-link text-white d-flex align-items-center"
                                    href="${pageContext.request.contextPath}/promotion"
                            >
                                Khuyến Mãi
                                <img
                                        src="https://cdn.shopify.com/s/files/1/0731/6514/4343/files/Animation_-_1712303911997.gif?v=1712307455"
                                        class="ms-2"
                                        width="28"
                                        height="25"
                                />
                            </a>
                        </li>
                        <li class="nav-item dropdown mx-2">
                            <a
                                    class="nav-link  text-white"
                                    href="vouchers.html"
                            >
                                Vouchers
                            </a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link text-white" href="brand.html">Thương hiệu</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link text-white" href="handbook.html">Cẩm nang</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link text-white" href="contact.html">Giới thiệu</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</header>
