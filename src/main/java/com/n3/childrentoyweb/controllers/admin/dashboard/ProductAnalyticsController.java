package com.n3.childrentoyweb.controllers.admin.dashboard;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.n3.childrentoyweb.dto.ProductStockStatDTO;
import com.n3.childrentoyweb.services.StatisticService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/api/products/analytics")
public class ProductAnalyticsController extends HttpServlet {
    private StatisticService statisticService;
    private int range = 8;
    private boolean ascOrder = false;

    @Override
    public void init() throws ServletException {
        super.init();
        statisticService = new StatisticService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String order = request.getParameter("order");

        if (order == null) order = "desc";

        List<ProductStockStatDTO> data = statisticService.getProductStockStat(range, order);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        new ObjectMapper().writeValue(response.getWriter(), data);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}