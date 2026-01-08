<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<footer class="container-lg border-top py-3">
    <div class="row align-items-start">
        <div class="col">
            <div class="hstack gap-3">
                <img   src="${pageContext.request.contextPath}/assets/ToyWorldLogo.png" alt="Logo" onclick="window.location.href='home-page.html'" style="width: 200px; height: 50px">
                <div class="w-100">
                    <p class="mb-3 fw-bold">Tham gia ngay để nhận về tay thông tin ưu đãi và hữu ích</p>
                    <form id="footer-subscribe-form" onsubmit="return handleFooterSubscribe(event)" novalidate>
                        <div class="input-group">
                            <input id="footer-email" type="email" class="form-control" placeholder="Nhập email của bạn" required aria-describedby="footerEmailHelp">
                            <button class="btn btn-primary" type="submit">Đăng ký</button>
                        </div>
                        <small id="footerEmailHelp" class="form-text text-danger d-none">Vui lòng nhập email hợp lệ.</small>
                        <small id="footerEmailSuccess" class="form-text text-success d-none">Cảm ơn! Bạn đã đăng ký.</small>
                    </form>
                    <p class="mb-0"><small class="text-muted">Bạn có thể hủy đăng ký bất kỳ lúc nào!</small></p>
                </div>
            </div>
        </div>
        <div class="col-1 d-none d-md-block"></div>
        <div class="col-4 d-none d-md-block">
            <h3 class="mb-3 text-primary">Theo dõi chúng tôi</h3>
            <div class="social-links my-3">
                <a href="#" class="text-secondary me-3"><i class="fab fa-facebook-f fs-1"></i></a>
                <a href="#" class="text-secondary me-3"><i class="fab fa-instagram fs-1"></i></a>
                <a href="#" class="text-secondary me-3"><i class="fab fa-youtube fs-1"></i></a>
            </div>
        </div>
    </div>
    <hr class="text-primary fw-bold">
    <div class="accordion d-md-none" id="footerAccordion" style="--bs-accordion-border-width: 0;">
        <!-- Theo dõi chúng tôi -->
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingFollow">
                <button class="accordion-button px-0 collapsed text-primary fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFollow">
                    Theo dõi chúng tôi
                </button>
            </h2>
            <div id="collapseFollow" class="accordion-collapse collapse" data-bs-parent="#footerAccordion">
                <div class="accordion-body">
                    <a href="#" class="text-secondary me-3"><i class="fab fa-facebook-f fs-3"></i></a>
                    <a href="#" class="text-secondary me-3"><i class="fab fa-instagram fs-3"></i></a>
                    <a href="#" class="text-secondary me-3"><i class="fab fa-youtube fs-3"></i></a>
                </div>
            </div>
        </div>
        <!-- Thông tin liên hệ -->
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingContact">
                <button class="accordion-button px-0 collapsed text-primary fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseContact">
                    Thông tin liên hệ
                </button>
            </h2>
            <div id="collapseContact" class="accordion-collapse collapse" data-bs-parent="#footerAccordion">
                <div class="accordion-body text-secondary small">
                    <p class="mb-2"><i class="fas fa-location me-2"></i>Khu phố 33, Phường Linh Xuân, Tp.HCM</p>
                    <p class="mb-2"><i class="fas fa-phone me-2"></i>(84-28)-38966780</p>
                    <p class="mb-2"><i class="fas fa-envelope me-2"></i>hotro@toyworld.com</p>
                    <p class="mb-2"><i class="fas fa-clock me-2"></i>Thứ 2 - Thứ 7: 8:00 - 17:00</p>
                    <p class="mb-0"><i class="fas fa-clock me-2"></i>Chủ nhật: 8:00 - 12:00</p>
                </div>
            </div>
        </div>
        <!-- Chính sách -->
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingPolicy">
                <button class="accordion-button px-0 collapsed text-primary fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapsePolicy">
                    Điều khoản và chính sách
                </button>
            </h2>
            <div id="collapsePolicy" class="accordion-collapse collapse" data-bs-parent="#footerAccordion">
                <div class="accordion-body text-secondary small">
                    <p class="mb-2">Chính sách giao hàng</p>
                    <p class="mb-2">Chính sách bảo mật</p>
                    <p class="mb-2">Chính sách đổi trả hàng hóa</p>
                    <p class="mb-2">Chính sách thanh toán</p>
                    <p class="mb-2">Điều kiện & điều khoản thành viên</p>
                    <p class="mb-2">Chính sách trả góp</p>
                    <p class="mb-0">Hệ thống cửa hàng</p>
                </div>
            </div>
        </div>
        <!-- Cửa hàng đồ chơi -->
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingStore">
                <button class="accordion-button px-0 collapsed text-primary fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseStore">
                    Cửa hàng đồ chơi
                </button>
            </h2>
            <div id="collapseStore" class="accordion-collapse collapse" data-bs-parent="#footerAccordion">
                <div class="accordion-body text-center">
                    <img class="img-fluid rounded" src="https://tse4.mm.bing.net/th/id/OIP.vBDmvGvplU2NB4cj1SL7PgHaE7?rs=1&pid=ImgDetMain&o=7&rm=3" alt="Cửa hàng đồ chơi">
                </div>
            </div>
        </div>
    </div>
    <div class="row gap-3 d-none d-md-flex">
        <div class="col">
            <h4 class="mb-3 text-primary">Thông tin liên hệ</h4>
            <div class="contact-info text-secondary">
                <p class="mb-2"><i class="fas fa-location me-2"></i>Khu phố 33, Phường Linh Xuân, Tp.Hồ Chí Minh, Việt Nam</p>
                <p class="mb-2"><i class="fas fa-phone me-2"></i>(84-28)-38966780</p>
                <p class="mb-2"><i class="fas fa-envelope me-2"></i>hotro@toyworld.com</p>
                <div class="hstack gap-3 align-items-start">
                    <p class="mb-2"><i class="fas fa-clock me-2"></i>Thứ 2 - Thứ 7<br><span class="ms-4">8:00 - 17:00</span></p>
                    <p class="mb-0"><i class="fas fa-clock me-2"></i>Chủ nhật<br><span class="ms-4">8:00 - 12:00</span></p>
                </div>
            </div>
        </div>
        <div class="col-4">
            <h4 class="mb-3 text-primary">Điều khoản và chính sách</h4>
            <div class="contact-info text-secondary">
                <p class="mb-2">Chính sách giao hàng</p>
                <p class="mb-2">Chính sách bảo mật</p>
                <p class="mb-2">Chính sách bảo hành và đổi trả hàng hóa</p>
                <p class="mb-2">Chính sách thanh toán</p>
                <p class="mb-2">Điều kiện & Điều khoản thành viên</p>
                <p class="mb-2">Chính sách trả góp</p>
                <p class="mb-2">Hệ thống cửa hàng</p>
            </div>
        </div>
        <div class="col ">
            <h3 class="mb-3 text-primary">Cửa hàng đồ chơi</h3>
            <img class="img-fluid rounded" src="https://tse4.mm.bing.net/th/id/OIP.vBDmvGvplU2NB4cj1SL7PgHaE7?rs=1&pid=ImgDetMain&o=7&rm=3" alt="Cửa hàng đồ chơi">
        </div>
    </div>
    <hr>
    <div>
        <img src="assets/boCongThuong.svg" alt="Bộ Công Thương" class="mb-2">
        <p class="mb-0 text-muted">Công ty cổ phần Tuấn Hoàng Duy Số ĐKKD: 0235186426 do sở kế hoạch và đầu tư cấp ngày 29/10/2025</p>
        <p class="mb-0 text-muted">Địa chỉ: Khu phố 33, Phường Linh Xuân, Tp.Hồ Chí Minh, Việt Nam -  Điện thoại: (84-28)-38966780</p>
    </div>
</footer>
<script src="/js/index.js"></script>