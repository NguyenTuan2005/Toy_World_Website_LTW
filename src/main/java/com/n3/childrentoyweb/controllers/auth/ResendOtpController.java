package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.exception.EmailInvalidException;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.CacheService;
import com.n3.childrentoyweb.services.EmailService;
import com.n3.childrentoyweb.utils.OTPUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="resendOtp", value="/resend-otp")
public class ResendOtpController extends HttpServlet {
    private CacheService cacheService;
    private EmailService emailService;

    @Override
    public void init() throws ServletException {
        this.cacheService = CacheService.getInstance();
        this.emailService = new EmailService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("pendingUser");
        String otp;
        try {
            boolean isValidEmail = user != null && user.isValidEmail();
            if (!isValidEmail)
                throw new EmailInvalidException("Vui lòng nhập thông tin để tiếp tục");

            cacheService.remove(user.getEmail());
            otp = OTPUtil.generate();
            cacheService.add(user.getEmail(), otp);

            emailService.sendOtpEmail(user.getEmail(), otp);

            req.getRequestDispatcher("/common/verify-otp.jsp").forward(req, resp);
        } catch (IllegalArgumentException | EmailInvalidException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher( "/sign-up").forward(req, resp);
        }
    }
}
