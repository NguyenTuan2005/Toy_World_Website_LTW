package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.AuthService;
import com.n3.childrentoyweb.services.CacheService;
import com.n3.childrentoyweb.services.EmailService;
import com.n3.childrentoyweb.services.UserService;
import com.n3.childrentoyweb.utils.OTPUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(value = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    private AuthService authService;
    private UserService userService;
    private CacheService cacheService;
    private EmailService emailService;

    @Override
    public void init() {
        this.authService = new AuthService();
        this.userService = new UserService();
        this.cacheService = CacheService.getInstance();
        this.emailService = EmailService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String email = (String) session.getAttribute("emailToVerify");
            request.setAttribute("emailToVerify", email);
        }
        request.getRequestDispatcher("/login/forgot-password-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String email = request.getParameter("forgotPasswordEmail");

            this.userService.validateEmailForForgotPassword(email);

            String otp = OTPUtil.generate();

            this.cacheService.remove(email);

            this.cacheService.add(email, otp);

            this.emailService.sendOtpEmail(email, otp);


            request.getSession().setAttribute("emailToVerify", email);
            response.sendRedirect(request.getContextPath() + "/verify-login-otp");
        } catch (ObjectNotFoundException | DataInvalidException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/login/forgot-password-form.jsp").forward(request, response);
        }
    }
}