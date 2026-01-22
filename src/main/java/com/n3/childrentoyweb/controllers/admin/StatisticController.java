package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.StatisticDAO;
import com.n3.childrentoyweb.dto.PaymentMethodChartDTO;
import com.n3.childrentoyweb.dto.ProductChartDTO;
import com.n3.childrentoyweb.services.OrderService;
import com.n3.childrentoyweb.services.StatisticService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "StatisticManage",value = "/admin/statistics")
public class StatisticController extends HttpServlet {

    private OrderService orderService = new OrderService();
    private StatisticService statisticService = new StatisticService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int month = LocalDate.now().getMonthValue();

        if(req.getParameter("month") == null){
            req.setAttribute("month", month);
        } else {
            month = Integer.parseInt(req.getParameter("month"));
        }


        this.addTotalNumberOfOrdersOnMonth(req,month);

        this.addTotalPricesOfOrderOnMonth(req,month);

        this.addAverageValuePerOrderOnMonth(req,month);

        this.buildTopProductsChart(req,month);

        this.buildRevenueOverTimeChart(req,month);

        this.buildPaymentChart(req,month);


        req.getRequestDispatcher("/adminPages/statistics.jsp").forward(req,resp);
    }

    private void addTotalPricesOfOrderOnMonth(HttpServletRequest req, int month)  {
        double  totalPricesOfOrder = this.orderService.sumRevenueByMonth(month);
        req.setAttribute("totalPricesOfOrder",totalPricesOfOrder);
    }

    private void addTotalNumberOfOrdersOnMonth(HttpServletRequest req, int month)  {
        int totalNumberOfOrders = this.orderService.countAllOrders(month);
        req.setAttribute("totalNumberOfOrders",totalNumberOfOrders);
    }

    private void addAverageValuePerOrderOnMonth(HttpServletRequest req, int month)  {
        double averageValuePerOrder = orderService.sumRevenueByMonth(month) / orderService.countAllOrders(month);
        req.setAttribute("averageValuePerOrder",averageValuePerOrder);
    }

    private void buildRevenueOverTimeChart(HttpServletRequest req, int month)  {
        List<Double> revenueOverTime = new ArrayList<>();
        for (int i = 1  ; i <= 12 ; i++) {
            revenueOverTime.add(orderService.sumRevenueByMonth(i));
        }
        req.setAttribute("revenueOverTime",revenueOverTime);
    }

    private void buildTopProductsChart(HttpServletRequest req, int month)  {
      List<ProductChartDTO> productChartDTOS = statisticService.top3ProductByMonth(month);

      req.setAttribute("productChart",productChartDTOS);
    }

    private void buildPaymentChart(HttpServletRequest req, int month){
        List<PaymentMethodChartDTO> paymentChart = this.statisticService.getPaymentMethodChart();
        req.setAttribute("paymentChart", paymentChart);
    }
}
