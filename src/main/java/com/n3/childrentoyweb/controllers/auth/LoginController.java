package com.n3.childrentoyweb.controllers.auth;

import com.n3.childrentoyweb.dao.UserDAO;
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
        HttpSession session = request.getSession(false);

        if (session != null) {
            String message = (String) session.getAttribute("resetSuccessMessage");
            if (message != null) {
                request.setAttribute("resetSuccessMessage", message);
                session.removeAttribute("resetSuccessMessage");
            }

            if (session.getAttribute("currentUser") != null) {
                response.sendRedirect(request.getContextPath() + "/account/profile");
                return;
            }
        }

        request.getRequestDispatcher("/login/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = authService.login(email, password);

            if (user == null) {
                request.setAttribute("error", "Sai email hoặc mật khẩu");
                request.getRequestDispatcher("/login/login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("currentUser", user);

            List<RoleEnum> roles = roleService.findAllByUserId(user.getId());
            session.setAttribute("roles", roles);
            session.setAttribute("isAdmin", roles.contains(RoleEnum.ROLE_ADMIN));


            session.setMaxInactiveInterval(10 * 60 * 60); // session

            response.sendRedirect(request.getContextPath() + "/home");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/login/login.jsp").forward(request, response);
        }
    }

}