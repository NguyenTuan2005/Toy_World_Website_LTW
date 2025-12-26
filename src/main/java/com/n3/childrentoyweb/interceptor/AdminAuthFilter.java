package com.n3.childrentoyweb.interceptor;

import com.n3.childrentoyweb.enums.RoleEnum;
import com.n3.childrentoyweb.exception.PermissionDeniedException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminAuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        System.out.println("Path :"+((HttpServletRequest) req).getPathInfo());

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null || session.getAttribute("roles") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            System.out.println("NO SESSION");
            return;
        }

        List<RoleEnum> roles = (List<RoleEnum>) session.getAttribute("roles");

        boolean isAdmin = roles.stream().anyMatch(RoleEnum::isAdmin);

        if (!isAdmin) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        chain.doFilter(req, res);
    }
}
