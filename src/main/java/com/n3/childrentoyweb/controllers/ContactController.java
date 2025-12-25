package com.n3.childrentoyweb.controllers;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "Contact",value = "/contact")
public class ContactController  extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/contact.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = "email";
        String name = req.getParameter("fullName");
        String content = req.getParameter("content");
        System.out.println(email);
        System.out.println(name);
        System.out.println(content);
        resp.sendRedirect(req.getHeader("Referer"));
    }
}
