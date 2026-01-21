package com.n3.childrentoyweb.controllers.admin.orders;

import com.n3.childrentoyweb.dto.OrderDetailDTO;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.services.OrderDetailService;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(value = "/admin/orders/edit/*")
public class EditOrderDetailController extends HttpServlet {
    private OrderDetailService orderDetailService;

    @Override
    public void init() {
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
            request.getRequestDispatcher("/adminPages/orders/edit-order-details.jsp").forward(request, response);

        } catch (ObjectNotFoundException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Long orderId = 0L;
        try {
            orderId = Long.parseLong(request.getPathInfo().substring(1));

            String orderStatus = request.getParameter("orderStatus");
            String paymentStatus = request.getParameter("paymentStatus");

            Long customerId = Long.parseLong(request.getParameter("customerId"));
            String firstName = request.getParameter("customerFirstName");
            String lastName = request.getParameter("customerLastName");
            String email = request.getParameter("customerEmail");
            String phone = request.getParameter("customerPhone");

            Long locationId = Long.parseLong(request.getParameter("locationId"));
            String address = request.getParameter("address");
            String province = request.getParameter("province");

            String createdAtStr = request.getParameter("createdAt");
            LocalDateTime createdAt = LocalDateTimeConverterUtil.convertHTMLDateToLocalDateTime(createdAtStr);

            OrderDetailDTO orderDetail = new OrderDetailDTO();
            orderDetail.setId(orderId);
            orderDetail.setOrderStatus(orderStatus);
            orderDetail.setPaymentStatus(paymentStatus);
            orderDetail.setCustomerId(customerId);
            orderDetail.setCustomerFirstName(firstName);
            orderDetail.setCustomerLastName(lastName);
            orderDetail.setCustomerEmail(email);
            orderDetail.setCustomerPhone(phone);
            orderDetail.setLocationId(locationId);
            orderDetail.setAddress(address);
            orderDetail.setProvince(province);
            orderDetail.setCreatedAt(createdAt);

            orderDetailService.updateOrderDetail(orderDetail);

            session.setAttribute("MSG_SUCCESS", "Cập nhật đơn hàng #" + orderId + " thành công.");
            response.sendRedirect(request.getContextPath() + "/admin/orders");

        } catch (ObjectNotFoundException e) {
            session.setAttribute("MSG_ERROR", "Cập nhật đơn hàng #" + orderId + " thất bại:  " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/orders");

        } catch (Exception e) {
            session.setAttribute("MSG_ERROR", "Cập nhật đơn hàng #" + orderId + " thất bại:  " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }

    }
}