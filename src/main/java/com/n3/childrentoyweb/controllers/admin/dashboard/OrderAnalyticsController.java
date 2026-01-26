package com.n3.childrentoyweb.controllers.admin.dashboard;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.n3.childrentoyweb.dto.OrderAnalyticsDTO;
import com.n3.childrentoyweb.enums.OrderMetric;
import com.n3.childrentoyweb.services.StatisticService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/api/orders/analytics")
public class OrderAnalyticsController extends HttpServlet {
    private StatisticService statisticService;

    public void init(){
        statisticService = new StatisticService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String metricParam = request.getParameter("metric");
        String range = request.getParameter("range");

        if (metricParam == null || range == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        OrderMetric metric = OrderMetric.valueOf(metricParam.toUpperCase());

        List<OrderAnalyticsDTO> data;
        switch (metric) {
            case REVENUE:
                data = statisticService.getRevenue(range);
                break;
            case ORDER:
                data = statisticService.getOrderStats(range);
                break;
            case STATUS:
                data = statisticService.getOrderStatusStat(range);
                break;
            default:
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        new ObjectMapper().writeValue(response.getWriter(), data);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}