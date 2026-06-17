package com.n3.childrentoyweb.controllers.admin.orders;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.n3.childrentoyweb.dto.OrderDetailDTO;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.services.OrderDetailService;
import com.n3.childrentoyweb.services.OrderService;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.util.Optional;

@WebServlet(value = "/admin/orders/view/*")
public class ViewOrderDetailController extends HttpServlet {
    private OrderDetailService orderDetailService;
    private OrderService orderService;

    @Override
    public void init(){
        orderDetailService = new OrderDetailService();
        orderService = new OrderService();
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

            try {
                com.n3.childrentoyweb.enums.SignatureStatus signatureStatus = this.orderService.verifyOrder(orderDetail.getCustomerEmail(),orderId);
                switch (signatureStatus){
                    case SIGNED -> {
                        System.out.println("ok hehe ");
                        orderDetail.setSignatureStatus("OK_HE_HE");
                    }

                    case PENDING_SIGNATURE -> {
                        System.out.println("NO hehe ");
                        orderDetail.setSignatureStatus("NO_HE_HE");
                    }
                }

            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            } catch (NoSuchAlgorithmException e) {
                throw new RuntimeException(e);
            } catch (InvalidKeySpecException e) {
                throw new RuntimeException(e);
            } catch (InvalidKeyException e) {
                throw new RuntimeException(e);
            } catch (SignatureException e) {
                throw new RuntimeException(e);
            }

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