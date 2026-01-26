package com.n3.childrentoyweb.controllers.admin.dashboard;

import com.n3.childrentoyweb.services.OrderService;
import com.n3.childrentoyweb.services.ProductService;
import com.n3.childrentoyweb.services.StatisticService;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Map;

@WebServlet(value = "/admin/dashboard")
public class DashBoardController extends HttpServlet {
    private UserService userService;
    private ProductService productService;
    private OrderService orderService;
    private StatisticService statisticService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
        productService = new ProductService();
        orderService = new OrderService();
        statisticService = new StatisticService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LocalDate today = LocalDate.now();
        int thisYear = today.getYear();
        int thisMonth = today.getMonthValue();

        int totalUserThisMonth = userService.countAllInMonth(thisYear, thisMonth);
        long totalProductThisMonth = productService.countProductInMonth(thisYear, thisMonth);
        double revenueThisMonth = orderService.calculateRevenueInMonth(thisYear, thisMonth);
        long totalOrderThisMonth = orderService.countAllInMonth(thisYear, thisMonth);
        request.setAttribute("revenueThisMonth", revenueThisMonth);
        request.setAttribute("totalOrderThisMonth", totalOrderThisMonth);
        request.setAttribute("totalProductThisMonth", totalProductThisMonth);
        request.setAttribute("totalUserThisMonth", totalUserThisMonth);


        Map<String, Double> stat = statisticService.getGrowthRates(thisYear, thisMonth);

        request.setAttribute("revenueGrowth", stat.get("revenueGrowth"));
        request.setAttribute("orderGrowth", stat.get("orderGrowth"));
        request.setAttribute("productGrowth", stat.get("productGrowth"));
        request.setAttribute("userGrowth", stat.get("userGrowth"));

        request.getRequestDispatcher("/adminPages/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}