package com.n3.childrentoyweb.interceptor;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.exception.PermissionDeniedException;
import com.n3.childrentoyweb.models.CurrentUser;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*"})
public class AuthenticationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) servletRequest;
        HttpSession session = httpRequest.getSession(false);

        if (session == null) throw new PermissionDeniedException();

        CurrentUser currentUser = (CurrentUser) session.getAttribute(CurrentUser.CURRENT_USER);
        System.out.println("User in session: " + currentUser);
        boolean isAdmin = currentUser!= null &&  currentUser.hasAdminRole();

        if(!isAdmin) throw new PermissionDeniedException();

        filterChain.doFilter(servletRequest, servletResponse);
    }
}
