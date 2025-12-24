package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.enums.RoleEnum;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.AuthService;
import com.n3.childrentoyweb.services.RoleService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/login")
public class LoginController extends HttpServlet {
    private AuthService authService;
    private RoleService roleService;

    @Override
    public void init() {
        this.authService = new AuthService();
        this.roleService = new RoleService();
    }

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
            session.setAttribute("roles",null);
//            session.setMaxInactiveInterval(30 * 60); // 30 phút
            List<RoleEnum> roles = this.roleService.findAllByUserId(user.getId());
            session.setAttribute("roles",roles);
            session.setMaxInactiveInterval(4*60);

            response.sendRedirect(request.getContextPath() + "/home");

        } else {
            request.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }



    }
}