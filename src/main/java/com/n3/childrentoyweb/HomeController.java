package com.n3.childrentoyweb;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "home", value = "/")
public class HomeController extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setAttribute("title", "TOY WORLD - THẾ GIỚI ĐỒ CHƠI");
        request.setAttribute("content", "/home-page.jsp");

        request.setAttribute("pageCSS", List.of("css/home-page.css"));

        request.getRequestDispatcher("common/user-layout.jsp").forward(request, response);
    }

}