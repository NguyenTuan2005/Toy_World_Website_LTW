package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(value = "/login")
public class LoginController extends HttpServlet {
    private AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = authService.login(email, password);

        if (user != null) {
            System.out.println(user);

            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
//            session.setMaxInactiveInterval(60 * 60); // 30 phút
            session.setMaxInactiveInterval(10*60);

            response.sendRedirect(request.getContextPath() + "/home");

        } else {
            request.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }



    }
}