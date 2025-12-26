package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.dto.SignUpUserDTO;
import com.n3.childrentoyweb.exception.EmailInvalidException;
import com.n3.childrentoyweb.services.CacheService;
import com.n3.childrentoyweb.services.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Random;

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SignUpUserDTO signUpUserDTO = (SignUpUserDTO) req.getSession().getAttribute("pendingUser");
        String otp;
        try {
            boolean isValidSignUpUserDTO = signUpUserDTO != null && signUpUserDTO.isValidEmail();
            if (!isValidSignUpUserDTO)
                throw new EmailInvalidException("Không thể truy cập trang xác thực OTP");

            cacheService.remove(signUpUserDTO.getUser().getEmail());
            otp = String.format("%06d", new Random().nextInt(999999));
            cacheService.add(signUpUserDTO.getUser().getEmail(), otp);

            emailService.sendOtpEmail(signUpUserDTO.getUser().getEmail(), otp);

            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } catch (IllegalArgumentException | EmailInvalidException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher( "/sign-up").forward(req, resp);
        }
    }
}
