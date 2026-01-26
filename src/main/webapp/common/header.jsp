<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<header class="bg-white shadow-sm">
    <div class="container-fluid py-2 root-red-background">
        <div class="d-flex align-items-center justify-content-center flex-wrap">
            <!-- Logo -->
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/home">
                    <img src="${pageContext.request.contextPath}/assets/ToyWorldLogo.png"
                         alt="ToyWorld Logo"
                         class="img-fluid"
                         style="width: 200px; height: 50px;"/>
                </a>
            </div>

            <!-- Search bar -->
            <form action="${pageContext.request.contextPath}/products" method="get"
                  class="flex-grow-1 mx-4" style="max-width: 420px;">
                <div class="input-group shadow-sm rounded-pill overflow-hidden">
                    <span class="input-group-text bg-white border-0 ps-3">
                        <i class="bi bi-search text-primary"></i>
                    </span>

                    <input type="text"
                           class="form-control border-0 ps-1"
                           name="keyword"
                           value="${fn:escapeXml(param.keyword)}"
                           placeholder="Tìm kiếm sản phẩm (lắp ráp, mô hình, ba lô...)">

                </div>
            </form>


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

                    <%--tài khoản--%>
                    <c:if test="${sessionScope.currentUser != null}">
                        <button class="btn d-flex align-items-center"
                                onclick="window.location.href='${pageContext.request.contextPath}/account/profile'">
                            <i class="bi bi-person-circle me-2"></i>
                            <div>${sessionScope.currentUser.firstName}</div>
                        </button>
                    </c:if>

                    <!-- Cart -->
                    <button class="btn d-flex align-items-center"
                            onclick="window.location.href='${pageContext.request.contextPath}/cart'">
                        <i class="bi bi-basket2-fill me-2"></i>

                        <span id="cart-count">Giỏ hàng
                            <c:if test="${sessionScope.cart != null && sessionScope.cart.totalQuantity > 0}">
                                (${sessionScope.cart.totalQuantity})
                            </c:if>
                        </span>
                    </button>
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

                    <ul class="navbar-nav fw-bold text-uppercase gap-4">
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

                        <li class="nav-item mx-2">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/brand">
                                Thương hiệu
                            </a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/handbook">Cẩm nang</a>
                        </li>
                        <li class="nav-item mx-2">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/contact">
                                Giới thiệu
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</header>
