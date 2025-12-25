package com.n3.childrentoyweb.services;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

import static com.n3.childrentoyweb.dao.DBProperties.*;

public class EmailService {

    public void sendOtpEmail(String email, String otp) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", SMTP_AUTH);
        props.put("mail.smtp.starttls.enable", SMTP_STARTTLS);
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
            }
        });

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
            .container { max-width: 600px; margin: 0 auto; background-color: #ffffff; border: 2px solid #D51B1B; border-radius: 8px; padding: 30px; }
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
            <p class='warning'>Mã này sẽ hết hạn sau 90 giây.</p>
            <p>Vui lòng nhập mã OTP vào trang xác thực để tiếp tục.</p>
            <hr>
            <p style='color: #999999; font-size: 14px;'>Nếu bạn không yêu cầu mã này, vui lòng bỏ qua email này. Tài khoản của bạn vẫn được bảo mật.</p>
            <div class='footer'>
            <p>© 2026 ToyWorld. All rights reserved.</p>
            </div>
            </div>
            </body>
            </html>
            """, otp.toUpperCase());

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send OTP email", e);
        }
    }
}
