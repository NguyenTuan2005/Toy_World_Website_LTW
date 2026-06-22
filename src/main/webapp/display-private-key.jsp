<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Giới thiệu & Liên hệ</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">
    <jsp:include page="/common/head.jsp"/>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/header.css" />
    <link rel="stylesheet" href="css/root.css" />
</head>
<body>
<jsp:include page="/common/header.jsp" />

<main>
    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">

                <!-- MODE DÁN TEXT -->
                <div id="textContainer">
                    <label for="privateKey" class="form-label fw-semibold">
                        Nội dung Private Key
                    </label>

                    <textarea
                            class="form-control"
                            id="privateKey"
                            name="privateKey"
                            rows="10"
                            placeholder="Dán Public Key vào đây..."
                            required>${privateKey}</textarea>

                    <button
                            type="button"
                            class="btn btn-primary save-btn"
                            onclick="copyPrivateKey()">
                        <i class="fas fa-copy me-1"></i>
                        Copy
                    </button>
                    <button
                            type="button"
                            class="btn btn-primary save-btn"
                            onclick="downloadPrivateKey()">
                        <i class="fas fa-copy me-1"></i>
                        download
                    </button>
                </div>
                <script>
                    function downloadPrivateKey() {
                        const keyContent = `${privateKey}`;

                        const blob = new Blob([keyContent], {
                            type: "application/octet-stream"
                        });

                        const url = URL.createObjectURL(blob);

                        const a = document.createElement("a");
                        a.href = url;
                        a.download = "private-key.key";
                        a.click();

                        URL.revokeObjectURL(url);
                    };
                </script>

                <script>
                    function copyPrivateKey() {
                        const textarea = document.getElementById("privateKey");

                        navigator.clipboard.writeText(textarea.value)
                            .then(() => {
                                alert("Đã copy Public Key thành công!");
                            })
                            .catch(err => {
                                console.error(err);
                                alert("Copy thất bại!");
                            });
                    }
                </script>

            </div>
        </div>
    </div>
</main>

<jsp:include page="/common/footer.jsp" />
</body>
</html>