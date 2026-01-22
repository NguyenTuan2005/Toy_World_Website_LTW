package com.n3.childrentoyweb.controllers.account;

import com.n3.childrentoyweb.exception.ForbiddenException;
import com.n3.childrentoyweb.exception.InvalidOrderStateException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.UserOrderService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(value = "/account/order-history/cancel")
public class CancelOrderController extends HttpServlet {
    private UserOrderService userOrderService;

    @Override
    public void init() {
        userOrderService = new UserOrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("currentUser");

        String orderIdParam = request.getParameter("orderId");
        Long orderId;

        try {
            orderId = Long.parseLong(orderIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/account/order-history");
            return;
        }

        try {
            userOrderService.cancelOrder(orderId, user.getId());

            session.setAttribute("MSG_SUCCESS", "Hủy đơn hàng #" + orderId + " thành công.");
        } catch (ObjectNotFoundException | ForbiddenException | InvalidOrderStateException e) {
            session.setAttribute("MSG_ERROR", "Hủy đơn hàng #" + orderId + " thất bại! " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("MSG_ERROR", "Có lỗi hệ thống, vui lòng thử lại sau");
        }

        response.sendRedirect(request.getContextPath() + "/account/order-history");
    }
}