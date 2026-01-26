package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.exception.OTPInvalidException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.CacheService;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(value = "/verify-otp")
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
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("pendingUser");
        String otp, userInput = req.getParameter("otpCode");
        try {
            boolean isValidEmail =  user != null && user.isValidEmail();
            if (!isValidEmail)
                throw new DataInvalidException("Vui lòng nhập thông tin để tiếp tục");

            otp = cacheService.get(user.getEmail());

            if (userInput == null) req.getRequestDispatcher( "/common/verify-otp.jsp").forward(req, resp);

            boolean isValidOTP = !userInput.trim().isEmpty() && otp != null && otp.equalsIgnoreCase(userInput.trim());
            if (!isValidOTP)
                throw new OTPInvalidException("Không thể xác thực OTP");

            userService.save(user);

            session.removeAttribute("pendingUser");

            session.setAttribute("successMessage", "Đăng ký thành công, Hãy đăng nhập để sử dụng hệ thống!");

            resp.sendRedirect(req.getContextPath() + "/login");

        } catch (OTPInvalidException | ObjectNotFoundException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher( "/common/verify-otp.jsp").forward(req, resp);
        } catch (DataInvalidException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher( "/sign-up.jsp").forward(req, resp);
        }
    }
}
