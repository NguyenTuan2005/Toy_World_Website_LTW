<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lưu Public Key</title>

    <link rel="icon" href="${pageContext.request.contextPath}/assets/ToyWorldFavicon.png">

    <jsp:include page="/common/head.jsp"/>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <link rel="stylesheet" href="css/header.css"/>
    <link rel="stylesheet" href="css/root.css"/>

    <style>
        .public-key-card {
            max-width: 900px;
            margin: auto;
            border: none;
            border-radius: 16px;
            overflow: hidden;
        }

        .public-key-header {
            background: #f8f9fa;
            padding: 20px 24px;
            border-bottom: 1px solid #e9ecef;
        }

        .public-key-body {
            padding: 30px;
        }

        .mode-switch {
            display: flex;
            justify-content: center;
            margin-bottom: 25px;
        }

        .mode-switch .btn {
            min-width: 180px;
            font-weight: 500;
        }

        .content-panel {
            border: 1px solid #dee2e6;
            border-radius: 14px;
            padding: 24px;
            background-color: #fff;
        }

        .form-control {
            border-radius: 10px;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 250px;
        }

        .save-btn {
            margin-top: 20px;
        }

        .latest-info {
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 8px;
        }

        .upload-box {
            padding: 15px;
            border: 2px dashed #ced4da;
            border-radius: 10px;
            background: #fafafa;
        }
    </style>
</head>

<body>

<jsp:include page="/common/header.jsp"/>

<main>
    <div class="container py-5">

        <div class="card shadow-sm public-key-card">

            <div class="public-key-header">
                <h4 class="mb-0">
                    <i class="fas fa-key me-2"></i>
                    Lưu Public Key
                </h4>

                <c:choose>
                    <c:when test="${empty latestCreate}">
                        <div class="latest-info">
                            Chưa có Public Key nào.
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="latest-info">
                            Public Key gần nhất được lưu vào:
                            <strong>${latestCreate}</strong>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="public-key-body">

                <div class="mode-switch">
                    <div class="btn-group" role="group">

                        <input type="radio"
                               class="btn-check"
                               name="inputMode"
                               id="textMode"
                               checked>

                        <label class="btn btn-outline-primary"
                               for="textMode">
                            <i class="fas fa-key me-2"></i>
                            Dán Public Key
                        </label>

                        <input type="radio"
                               class="btn-check"
                               name="inputMode"
                               id="fileMode">

                        <label class="btn btn-outline-primary"
                               for="fileMode">
                            <i class="fas fa-upload me-2"></i>
                            Upload File
                        </label>

                    </div>
                </div>

                <!-- MODE DÁN TEXT -->

                <div id="textContainer" class="content-panel">

                    <form action="${pageContext.request.contextPath}/public-key"
                          method="post">

                        <label for="publicKey"
                               class="form-label fw-semibold">
                            Nội dung Public Key
                        </label>

                        <textarea
                                class="form-control"
                                id="publicKey"
                                name="publicKey"
                                rows="10"
                                placeholder="Dán Public Key vào đây..."
                                required></textarea>

                        <div class="form-text mt-2">
                            Hãy kiểm tra kỹ và tránh sao chép khoảng trắng thừa ở đầu hoặc cuối nội dung.
                        </div>

                        <button type="submit"
                                class="btn btn-primary save-btn">
                            <i class="fas fa-save me-1"></i>
                            Lưu Public Key
                        </button>

                    </form>

                </div>

                <!-- MODE UPLOAD FILE -->

                <div id="fileContainer"
                     class="content-panel"
                     style="display: none;">

                    <form action="${pageContext.request.contextPath}/public-key-file"
                          method="post"
                          enctype="multipart/form-data">

                        <label for="publicKeyFile"
                               class="form-label fw-semibold">
                            Chọn file Public Key
                        </label>

                        <div class="upload-box">
                            <input type="file"
                                   class="form-control"
                                   id="publicKeyFile"
                                   name="publicKeyFile"
                                   accept=".pem,.pub,.txt"
                                   required>
                        </div>

                        <div class="form-text mt-2">
                            Hỗ trợ các định dạng: .txt
                        </div>

                        <button type="submit"
                                class="btn btn-primary save-btn">
                            <i class="fas fa-save me-1"></i>
                            Lưu Public Key
                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>
</main>

<script>
    const textMode = document.getElementById("textMode");
    const fileMode = document.getElementById("fileMode");

    const textContainer = document.getElementById("textContainer");
    const fileContainer = document.getElementById("fileContainer");

    textMode.addEventListener("change", function () {
        if (this.checked) {
            textContainer.style.display = "block";
            fileContainer.style.display = "none";
        }
    });

    fileMode.addEventListener("change", function () {
        if (this.checked) {
            textContainer.style.display = "none";
            fileContainer.style.display = "block";
        }
    });
</script>

<jsp:include page="/common/footer.jsp"/>

</body>
</html>