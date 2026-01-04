package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dto.PaymentMethodChartDTO;
import com.n3.childrentoyweb.dto.ProductChartDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "StatisticManage",value = "/statistics")
public class StatisticController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        this.addTotalNumberOfOrdersOnMonth(req);

        this.addTotalPricesOfOrderOnMonth(req);

        this.addAverageValuePerOrderOnMonth(req);

        this.buildTopProductsChart(req);

        this.buildRevenueOverTimeChart(req);

        this.buildPaymentChart(req);

        req.getRequestDispatcher("/adminPages/statistics.jsp").forward(req,resp);
    }

    private void addTotalPricesOfOrderOnMonth(HttpServletRequest req)  {
        int totalPricesOfOrder = 10990000;
        req.setAttribute("totalPricesOfOrder",totalPricesOfOrder);
    }

    private void addTotalNumberOfOrdersOnMonth(HttpServletRequest req)  {
        int totalNumberOfOrders = 1099;
        req.setAttribute("totalNumberOfOrders",totalNumberOfOrders);
    }

    private void addAverageValuePerOrderOnMonth(HttpServletRequest req)  {
        double averageValuePerOrder = 500000;
        req.setAttribute("averageValuePerOrder",averageValuePerOrder);
    }

    private void buildRevenueOverTimeChart(HttpServletRequest req)  {
        List<Double> revenueOverTime = new ArrayList<>();
        revenueOverTime.addAll(List.of(18.5, 20.2, 22.8, 19.5, 25.3, 28.7, 24.2, 26.8, 23.5, 27.2, 29.8, 30.5));
        req.setAttribute("revenueOverTime",revenueOverTime);
    }

    private void buildTopProductsChart(HttpServletRequest req)  {
      List<ProductChartDTO> productChartDTOS = new ArrayList<>();

          ProductChartDTO productChartDTO =new ProductChartDTO();
          productChartDTO.setName("Java core");
          productChartDTO.setTotalPrice(190000.0);
          productChartDTOS.add(productChartDTO);

        ProductChartDTO productChartDTO1 =new ProductChartDTO();
        productChartDTO1.setName("C# dev");
        productChartDTO1.setTotalPrice(490000.0);
        productChartDTOS.add(productChartDTO1);

        ProductChartDTO productChartDTO2 =new ProductChartDTO();
        productChartDTO2.setName("Py thorn dev");
        productChartDTO2.setTotalPrice(590000.0);
        productChartDTOS.add(productChartDTO2);

      req.setAttribute("productChart",productChartDTOS);
    }

    private void buildPaymentChart(HttpServletRequest req){
        List<PaymentMethodChartDTO> paymentChart = new ArrayList<>();
        paymentChart.add(new PaymentMethodChartDTO("COD",30));
        paymentChart.add(new PaymentMethodChartDTO("VNPay",70));

        req.setAttribute("paymentChart", paymentChart);
    }
}
