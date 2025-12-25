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
        props.put("mail.username", SMTP_USERNAME);
        props.put("mail.password", SMTP_PASSWORD);

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
            message.setSubject("Mã OTP Xác Thực - Toy World");

            String htmlContent = "<html><body>" +
                    "<h2>Xác thực tài khoản</h2>" +
                    "<p>Mã OTP của bạn là: <strong style='font-size: 20px; color: #007bff;'>" + otp + "</strong></p>" +
                    "<p>Mã này sẽ hết hạn sau 5 phút.</p>" +
                    "<p>Nếu bạn không yêu cầu mã này, vui lòng bỏ qua email này.</p>" +
                    "</body></html>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("OTP email sent successfully to: " + email);

        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send OTP email", e);
        }
    }
}
