package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.UserCommentService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(value = "/comment/create")
public class UserCommentController extends HttpServlet {
    private UserCommentService userCommentService;

    @Override
    public void init() throws ServletException {
        super.init();
        userCommentService = new UserCommentService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Long productId = Long.parseLong(request.getParameter("productId"));

        User user = (User) request.getSession().getAttribute("currentUser");

        String content = request.getParameter("content");

        userCommentService.save(productId, user.getId(), content);

        response.sendRedirect(request.getContextPath() + "/products/" + productId);
    }
}