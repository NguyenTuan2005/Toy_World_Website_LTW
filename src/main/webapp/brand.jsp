<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <title>Thương Hiệu</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp" />
    <link rel="stylesheet" href="css/brand.css" />
  </head>
  <body>
    <jsp:include page="/common/header.jsp" />

    <div class="top-bar" role="navigation" aria-label="Breadcrumb and page header">
       <div class="container">
          <nav class="breadcrumb" aria-label="Breadcrumb" style="margin-left: -1px; ">
             <a href="home-page.html" aria-label="Trang Chủ">Trang Chủ</a>
             <svg class="crumb-sep" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M9 6l6 6-6 6" stroke="#8b8b8b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
             </svg>
             <!-- update tại đây -->
             <a href="brand.html" aria-label="Dạy Con Thông Minh" style="width: 200px; color:#444;">Thương Hiệu</a>
          </nav>
       </div>
    </div>

    <div class="container-fluid">
      <h1 class="title text-center mt-4">Tổng ${fn:length(brands)} Thương Hiệu</h1>

      <div class="filter-section">
        <button class="filter-btn all-btn active" onclick="filterBrands('all')">
          Tất Cả
        </button>
        <c:forEach var="entry" items="${groupedBrands}">
          <button class="filter-btn" onclick="filterBrands('${entry.key}')">${entry.key}</button>
        </c:forEach>
      </div>

      <div class="brands-container">
        <c:forEach var="entry" items="${groupedBrands}">
          <div class="brand-group" data-letter="${entry.key}">
          <div class="brand-letter">${entry.key}</div>
            <div class="brand-items">
              <c:forEach var="b" items="${entry.value}">
              <a href="${pageContext.request.contextPath}/products?brandId=${b.id}">
                <div class="brand-item">
                  <img
                    src="${b.imgPath}"
                    alt="${b.name}"
                    class="w-100 h-100 object-fit-cover"
                  />
                </div>
              </a>
              </c:forEach>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>

    <jsp:include page="/common/footer.jsp" />
  <script>
      function filterBrands(letter) {
          const groups = document.querySelectorAll('.brand-group');
          const buttons = document.querySelectorAll('.filter-btn');

          buttons.forEach(btn => btn.classList.remove('active'));
          event.target.classList.add('active');

          groups.forEach(group => {
              if (letter === 'all' || group.dataset.letter === letter) {
                  group.style.display = 'block';
              } else {
                  group.style.display = 'none';
              }
          });
      }
  </script>
  </body>
</html>
