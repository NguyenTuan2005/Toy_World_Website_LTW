package com.n3.childrentoyweb.controllers.admin.orders;

import com.n3.childrentoyweb.dto.OrderDetailDTO;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.services.OrderDetailService;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.Optional;

@WebServlet(value = "/admin/orders/view/*")
public class ViewOrderDetailController extends HttpServlet {
    private OrderDetailService orderDetailService;

    @Override
    public void init(){
        orderDetailService = new OrderDetailService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String pathInfo = request.getPathInfo();

            Long orderId = null;
            if (pathInfo == null || pathInfo.equals("/")) {
                response.sendRedirect(request.getContextPath() + "/admin/orders");
            } else {
                orderId = Long.parseLong(pathInfo.substring(1));
            }


            OrderDetailDTO orderDetail = orderDetailService.findOrderDetail(orderId);

            request.setAttribute("orderDetail", orderDetail);
            request.setAttribute("orderDate", LocalDateTimeConverterUtil.convertToString(orderDetail.getCreatedAt()));
            request.getRequestDispatcher("/adminPages/orders/view-order-details.jsp").forward(request, response);

        } catch (ObjectNotFoundException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        } catch( NumberFormatException e){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}