package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.dto.SignUpUserDTO;
import com.n3.childrentoyweb.exception.EmailInvalidException;
import com.n3.childrentoyweb.exception.OTPInvalidException;
import com.n3.childrentoyweb.services.CacheService;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="verifyOtp", value = "/verify-otp")
public class VerifyOtpController extends HttpServlet {
    private UserService userService;
    private CacheService cacheService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
        this.cacheService = CacheService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/common/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SignUpUserDTO signUpUserDTO = (SignUpUserDTO) req.getSession().getAttribute("pendingUser");
        String otp, userInput = req.getParameter("otpCode");
        try {
            boolean isValidSignUpUserDTO =  signUpUserDTO != null && signUpUserDTO.isValidEmail();
            if (!isValidSignUpUserDTO)
                throw new EmailInvalidException("Không thể truy cập trang xác thực OTP");

            otp = cacheService.get(signUpUserDTO.getUser().getEmail());

            boolean isValidOTP = userInput != null && !userInput.isEmpty() && otp != null && otp.equalsIgnoreCase(userInput.trim());
            if (!isValidOTP)
                throw new OTPInvalidException("Không thể xác thực OTP");

            userService.save(signUpUserDTO.getUser());
            req.getSession().removeAttribute("pendingUser");
            resp.sendRedirect(req.getContextPath() + "/login");

        } catch (OTPInvalidException | EmailInvalidException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher( "/sign-up").forward(req, resp);
        }
    }
}
