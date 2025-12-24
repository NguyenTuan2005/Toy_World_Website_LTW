<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Giới thiệu & Liên hệ</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/header.css" />
    <link rel="stylesheet" href="css/root.css" />
</head>
<body>
    <jsp:include page="/common/header.jsp" />
    <main>
        <div class="container mt-5">
            <!-- Phần Giới thiệu -->
            <section class="mb-5">
                <h2 class="text-center mb-4 fw-bold text-primary">Giới thiệu</h2>

                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <p class="lead text-center mb-4">
                            Chào mừng bạn đến với <strong>ToyWorld</strong> - Thế giới đồ chơi dành cho mọi lứa tuổi!
                        </p>

                        <p class="mb-3">
                            ToyWorld là thương hiệu đồ chơi uy tín hàng đầu tại Việt Nam, được thành lập với sứ mệnh mang đến niềm vui và trải nghiệm học tập tuyệt vời cho trẻ em. Chúng tôi tự hào cung cấp hàng ngàn sản phẩm đồ chơi chất lượng cao, an toàn và phù hợp với từng độ tuổi phát triển của bé.
                        </p>

                        <p class="mb-3">
                            Với hơn 10 năm kinh nghiệm trong ngành đồ chơi trẻ em, ToyWorld hiểu rõ tầm quan trọng của việc chọn lựa đồ chơi phù hợp để phát triển tư duy, sáng tạo và kỹ năng xã hội cho trẻ. Từ những món đồ chơi giáo dục thông minh, đồ chơi vận động ngoài trời, đến những bộ sưu tập nhân vật hoạt hình được yêu thích - tất cả đều được lựa chọn kỹ lưỡng từ các thương hiệu nổi tiếng thế giới.
                        </p>

                        <p class="mb-3">
                            Tại ToyWorld, chúng tôi cam kết mang đến cho khách hàng những sản phẩm chính hãng 100%, được kiểm định về chất lượng và an toàn theo tiêu chuẩn quốc tế. Đội ngũ tư vấn viên nhiệt tình của chúng tôi luôn sẵn sàng hỗ trợ bạn tìm kiếm món đồ chơi hoàn hảo cho con yêu của mình.
                        </p>

                        <p class="mb-4">
                            Hãy để ToyWorld đồng hành cùng bạn trong hành trình nuôi dưỡng tuổi thơ tươi đẹp và phát triển toàn diện cho các bé. Bởi vì mỗi đứa trẻ đều xứng đáng có một thế giới đồ chơi tuyệt vời!
                        </p>

                        <div class="text-center">
                            <p class="fw-bold text-primary fs-5 mb-0">
                                ToyWorld - Nơi ước mơ trở thành hiện thực!
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Phần Liên hệ -->
            <section class="mb-5">

                <!-- Card thông tin liên hệ và bản đồ -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body p-4">
                        <div class="row">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <h5 class="fw-bold mb-3">Thông tin liên hệ</h5>
                                <div class="mb-3">
                                    <i class="fa fa-location-crosshairs me-1"></i>
                                    <strong>Địa chỉ:</strong>
                                    <p class="ms-4 mb-0">Khu phố 33, Phường Linh Xuân, Tp.HCM</p>
                                </div>
                                <div class="mb-3">
                                    <i class="fa fa-phone me-1"></i>
                                    <strong>Điện thoại:</strong>
                                    <p class="ms-4 mb-0">
                                        <a href="tel:(84-28)-38966780" class="text-decoration-none text-dark">(84-28)-38966780</a>
                                    </p>
                                </div>
                                <div class="mb-3">
                                    <i class="fa fa-envelope me-1"></i>
                                    <strong>Email:</strong>
                                    <p class="ms-4 mb-0">
                                        <a href="mailto:contact@toyworld.vn" class="text-decoration-none text-dark">hotro@toyworld.com</a>
                                    </p>
                                </div>
                                <div class="mb-0">
                                    <i class="fa fa-clock me-1"></i>
                                    <strong>Giờ làm việc:</strong>
                                    <p class="ms-4 mb-2">Thứ 2 - Thứ 7: 8:00 - 17:00</p>
                                    <p class="ms-4 mb-0">Chủ nhật: 8:00 - 12:00</p>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <h5 class="fw-bold mb-3">Vị trí cửa hàng</h5>
                                <div class="ratio ratio-4x3">
                                    <iframe
                                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.2977736668314!2d106.75782631533556!3d10.86803209226144!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175270ef81ecab5%3A0x56a3dd6c8db130e1!2zUGjGsOG7nW5nIExpbmggWHXDom4sIFRo4bunIMSQ4bupYywgVGjDoG5oIHBo4buRIEjhu5MgQ2jDrSBNaW5oLCBWaeG7h3QgTmFt!5e0!3m2!1svi!2s!4v1234567890123!5m2!1svi!2s"
                                            style="border:0;"
                                            allowfullscreen=""
                                            loading="lazy"
                                            referrerpolicy="no-referrer-when-downgrade">
                                    </iframe>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Form liên hệ -->

            </section>
        </div>

    </main>

    <jsp:include page="/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>