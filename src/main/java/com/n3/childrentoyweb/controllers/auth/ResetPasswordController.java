package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.UserService;
import com.n3.childrentoyweb.utils.MD5Util;
import com.n3.childrentoyweb.verifier.PasswordVerifier;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(value = "/reset-password")
public class ResetPasswordController extends HttpServlet {
    private UserService  userService;
    private PasswordVerifier passwordVerifier;
    @Override
    public void init() throws ServletException {
        userService = new UserService();
        passwordVerifier = new PasswordVerifier();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            request.getRequestDispatcher("/forgot-password").forward(request, response);
        }

        String email = (String) session.getAttribute("verifiedEmail");
        if(email == null){
            request.getRequestDispatcher("/forgot-password").forward(request, response);
        }

        request.getRequestDispatcher("/login/reset-password-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("verifiedEmail") == null) {
                response.sendRedirect("/forgot-password");
                return;
            }

            String email = session.getAttribute("verifiedEmail").toString();
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if(!newPassword.equals(confirmPassword)){
                throw new DataInvalidException("Mật khẩu phải khớp");
            }

            passwordVerifier.verify(newPassword);

            User user = userService.findByEmail(email).orElseThrow(() -> new DataInvalidException("Tài khoản không tồn tại"));

            user.setPassword(MD5Util.encryptMd5(newPassword));
            userService.update(user);

            session.removeAttribute("verifiedEmail");

            session.setAttribute("successMessage", "Đổi mật khẩu thành công, Vui lòng đăng nhập lại!");

            response.sendRedirect(request.getContextPath() + "/login");

        } catch (DataInvalidException | IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/login/reset-password-form.jsp").forward(request, response);
        }
    }
}