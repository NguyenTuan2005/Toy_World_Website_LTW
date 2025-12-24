package com.n3.childrentoyweb.services;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String USERNAME = "hduy09092005@gmail.com";
    private static final String PASSWORD = "srwmlebtfrsfdxkl";

    public void sendOtpEmail(String email, String otp) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.username", USERNAME);
        props.put("mail.password", PASSWORD);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME));
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
