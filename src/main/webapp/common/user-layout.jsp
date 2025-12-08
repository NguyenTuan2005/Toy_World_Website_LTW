<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="/common/head.jsp" />
    </head>
    <body>
        <main>
            <jsp:include page="/common/header.jsp" />
            <jsp:include page="${content}" />
            <jsp:include page="/common/footer.jsp" />
        </main>
    </body>
    <c:if test="${not empty pageJS}">
        <c:forEach var="js" items="${pageJS}">
            <script src="${js}"></script>
        </c:forEach>
    </c:if>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</html>
