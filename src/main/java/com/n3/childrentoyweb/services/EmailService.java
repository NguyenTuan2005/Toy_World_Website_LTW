package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.models.*;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.concurrent.*;

import static com.n3.childrentoyweb.dao.ApplicationProperties.*;

public class EmailService {
    private static EmailService instance;
    private ExecutorService executorService;

    private EmailService() {
        int corePoolSize = 3;
        int maxPoolSize = 10;
        long keepAliveTime = 60L;

        executorService = new ThreadPoolExecutor(
                corePoolSize,
                maxPoolSize,
                keepAliveTime,
                TimeUnit.SECONDS,
                new LinkedBlockingDeque<>()
        );
    }

    public static EmailService getInstance() {
        if (instance == null) {
            synchronized (EmailService.class) {
                if (instance == null) {
                    instance = new EmailService();
                }
            }
        }
        return instance;
    }

    public void sendOtpEmail(String email, String otp) {
        Session session = createMailSession();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Mã OTP Xác Thực - Toy World: " + otp);

            String htmlContent = String.format("""
            <html>
            <head>
            <style>
            body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }
            .container { max-width: 600px; margin: 0 auto; background-color: #ffffff; border: 1px #D51B1B; border-radius: 8px; padding: 30px; }
            h1 { color: #333333; margin-bottom: 10px; }
            h2 { color: #666666; font-weight: normal; margin-top: 0; margin-bottom: 20px; }
            hr { border: none; border-top: 1px solid #dddddd; margin: 20px 0; }
            .otp-box { background-color: #f8f9fa; border: 2px dashed; border-radius: 5px; padding: 20px; text-align: center; margin: 25px 0; }
            .otp-code { font-size: 32px; font-weight: bold; letter-spacing: 5px; color: #333333; margin: 0; }
            p { color: #555555; line-height: 1.6; margin: 10px 0; }
            .warning { color: #dc3545; font-weight: bold; }
            .footer { color: #999999; font-size: 12px; margin-top: 20px; text-align: center; }
            </style>
            </head>
            <body>
            <div class='container'>
            <h1>Xác thực tài khoản</h1>
            <h2>ToyWorld - Hệ thống xác thực OTP</h2>
            <hr>
            <p>Chào bạn,</p>
            <p>Chúng tôi đã nhận được yêu cầu xác thực tài khoản của bạn. Vui lòng sử dụng mã OTP dưới đây để hoàn tất quá trình xác thực:</p>
            <div class='otp-box'>
            <p class='otp-code'>%s</p>
            </div>
            <p class='warning'>Mã này sẽ hết hạn sau %d giây.</p>
            <p>Vui lòng nhập mã OTP vào trang xác thực để tiếp tục.</p>
            <hr>
            <p style='color: #999999; font-size: 14px;'>Nếu bạn không yêu cầu mã này, vui lòng bỏ qua email này. Tài khoản của bạn vẫn được bảo mật.</p>
            <div class='footer'>
            <p>© 2026 ToyWorld. All rights reserved.</p>
            </div>
            </div>
            </body>
            </html>
            """, otp.toUpperCase(), OTP_DELAY_IN_SECOND);

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send OTP email", e);
        }
    }

    public void sendCheckoutEmail(User user, Cart cart,Location location, long orderId, Payment payment) {
        Session session = createMailSession();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail()));
            message.setSubject(String.format("ToyWorld - Xác nhận đơn hàng #%d", orderId));

            String htmlContent = String.format("""
            <html>
            <head>
            <style>
            body { font-family: 'Courier New', monospace; background-color: #f4f4f4; margin: 0; padding: 20px; }
            .container { max-width: 700px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; padding: 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
            .header { text-align: center; border-bottom: 2px solid #D51B1B; padding-bottom: 20px; margin-bottom: 20px; }
            .header h1 { color: #D51B1B; margin: 0; }
            .order-info { background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px; font-family: Arial, sans-serif; }
            .order-info p { margin: 8px 0; color: #333; }
            .items-section { white-space: pre-wrap; background-color: #f8f9fa; padding: 20px; border-radius: 5px; margin: 20px 0; line-height: 1.8; }
            .footer { text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd; color: #999; font-family: Arial, sans-serif; }
            </style>
            </head>
            <body>
            <div class='container'>
            <div class='header'>
            <h1>HÓA ĐƠN THANH TOÁN</h1>
            <p>ToyWorld - Đồ chơi trẻ em chất lượng</p>
            </div>
            <div class='order-info'>
            <p><strong>Mã đơn hàng:</strong> #%d</p>
            <p><strong>Khách hàng:</strong> %s %s</p>
            <p><strong>Số điện thoại:</strong> %s</p>
            <p><strong>Địa chỉ giao hàng:</strong> %s</p>
            </div>
            <div class='items-section'>%s</div>
            <div class='footer'>
            <p>Cảm ơn quý khách đã mua hàng tại ToyWorld!</p>
            <p>Mọi thắc mắc xin liên hệ: support@toyworld.com</p>
            <p>© 2026 ToyWorld. All rights reserved.</p>
            </div>
            </div>
            </body>
            </html>
            """,
            orderId, user.getFirstName(), user.getLastName(), user.getPhone(), location.getAddress(),
            buildItemsSection(cart, payment));

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            executorService.submit(() -> {
                try {
                    Transport.send(message);
                } catch (Exception e) {
                    throw new RuntimeException("Không thể gửi email, lỗi: " + e.getMessage());
                }
            });

        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send checkout email", e);
        }
    }

    public void shutdown() {
        if (executorService != null && !executorService.isShutdown()) {
            executorService.shutdown();
            try {
                if (!executorService.awaitTermination(60, TimeUnit.SECONDS)) {
                    executorService.shutdownNow();
                }
            } catch (InterruptedException e) {
                executorService.shutdownNow();
                Thread.currentThread().interrupt();
            }
        }
    }

    private String buildItemsSection(Cart cart, Payment payment) {
        StringBuilder section = new StringBuilder();

        section.append("<hr>\n");

        // Items
        for (CartItem item : cart.getCartItems()) {
            section.append(String.format("  %s\n", item.getCartProductDTO().getName()));
            section.append(String.format("  Giá:\t\t\t%,.0f đ\n", item.getCartProductDTO().getPrice()));
            section.append(String.format("  Số lượng:\t\t%d\n", item.getQuantity()));
            section.append("\n");
        }

        // Summary
        section.append("<hr>\n");
        section.append(String.format("Tổng cộng:\t\t%,.0f đ\n", cart.getTotalCost()));
        section.append(String.format("Giảm giá:\t\t%,.0f đ\n", cart.getTotalPromotion()));
        section.append(String.format("Thành tiền:\t\t%,.0f đ\n", cart.getTotalPrice()));
        section.append(String.format("Khách trả:\t\t%,.0f đ\n", payment.getBalance()));
        section.append("<hr>\n");

        return section.toString();
    }

    private Session createMailSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", SMTP_AUTH);
        props.put("mail.smtp.starttls.enable", SMTP_STARTTLS);
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
            }
        });
    }
}
