package com.n3.childrentoyweb.controllers.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@Deprecated
@WebServlet(value = "/admin/*")
public class NavController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        switch (pathInfo) {

            case "/dashboard":
                request.setAttribute("activeTab", "dashboard");
                request.getRequestDispatcher("/adminPages/dashboard.jsp").forward(request, response);
                break;

            case "/orders":
                request.setAttribute("activeTab", "orders");
                request.getRequestDispatcher("/adminPages/orders.jsp").forward(request, response);
                break;

            case "/users":
                request.setAttribute("activeTab", "users");
                request.getRequestDispatcher("/adminPages/users.jsp").forward(request, response);
                break;

            case "/products":
                request.setAttribute("activeTab", "products");
                request.getRequestDispatcher("/adminPages/products.jsp").forward(request, response);
                break;

            case "/statistics":
                request.setAttribute("activeTab", "statistics");
                request.getRequestDispatcher("/adminPages/statistics.jsp").forward(request, response);
                break;

            case "/brands":
                request.setAttribute("activeTab", "brands");
                request.getRequestDispatcher("/adminPages/brands.jsp").forward(request, response);
                break;

            case "/events":
                request.setAttribute("activeTab", "events");
                request.getRequestDispatcher("/adminPages/events.jsp").forward(request, response);
                break;

            case "/handbooks":
                request.setAttribute("activeTab", "handbooks");
                request.getRequestDispatcher("/adminPages/handbook-management.jsp").forward(request, response);
                break;

            default:
                response.sendError(404);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}