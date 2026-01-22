package com.n3.childrentoyweb.controllers.admin.orders;

import com.n3.childrentoyweb.exception.InvalidOrderStateException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.services.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/orders/delete")
public class DeleteOrderController extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String orderIdParam = request.getParameter("orderId");
        Long orderId;
        try {
            orderId = Long.parseLong(orderIdParam);
        } catch (NumberFormatException e) {
            session.setAttribute("MSG_ERROR", "ID đơn hàng không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        try {

            orderService.deleteOrder(orderId);
            session.setAttribute("MSG_SUCCESS", "Xóa đơn hàng #" + orderId + " thành công.");

        } catch (ObjectNotFoundException | InvalidOrderStateException e) {
            session.setAttribute("MSG_ERROR", "Xóa đơn hàng #" + orderId + " thất bại! "+e.getMessage());
        } catch (Exception e) {
            session.setAttribute("MSG_ERROR", "Có lỗi hệ thống, vui lòng thử lại");
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
