package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.exception.OTPInvalidException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.services.CacheService;
import com.n3.childrentoyweb.services.UserService;
import com.n3.childrentoyweb.verifier.EmailVerifier;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(value = "/verify-login-otp")
public class VerifyLoginOtpController extends HttpServlet {
    private UserService userService;
    private CacheService cacheService;
    private EmailVerifier emailVerifier;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
        this.cacheService = CacheService.getInstance();
        this.emailVerifier = new EmailVerifier();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login/verify-login-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }

        String email = (String) session.getAttribute("emailToVerify");
        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }

        String userInput = request.getParameter("otpCode");
        String otp = cacheService.get(email);

        try {
            this.emailVerifier.verify(email);

            if (userInput == null || userInput.trim().isEmpty()) {
                throw new OTPInvalidException("Vui lòng nhập mã OTP");
            }

            if (otp == null) {
                throw new OTPInvalidException("Mã OTP đã hết hạn, vui lòng yêu cầu gửi lại");
            }

            boolean isValidOTP = !userInput.trim().isEmpty() && otp != null && otp.equalsIgnoreCase(userInput.trim());

            if (!isValidOTP)
                throw new OTPInvalidException("Mã OTP không chính xác");

            cacheService.remove(email);
            session.removeAttribute("emailToVerify");

            session.setAttribute("verifiedEmail", email);
            response.sendRedirect(request.getContextPath() + "/reset-password");

        } catch (OTPInvalidException | ObjectNotFoundException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher( "/login/verify-login-otp.jsp").forward(request, response);

        } catch (DataInvalidException | IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher( "/login/login.jsp").forward(request, response);
        }
    }
}
