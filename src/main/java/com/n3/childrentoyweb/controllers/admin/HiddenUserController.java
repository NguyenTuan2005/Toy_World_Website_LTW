package com.n3.childrentoyweb.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(name = "HiddenUserManage",value = "/admin/hidden-users")
public class HiddenUserController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userIdString  = req.getParameter("userId");
        String activeString =  req.getParameter("active");
        System.out.println(userIdString +" --- "+ activeString);




        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer);
    }
}
