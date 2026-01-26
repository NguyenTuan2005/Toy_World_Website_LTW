package com.n3.childrentoyweb.controllers.account;

import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.UserOrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/account/order-history")
public class OrderHistoryController extends HttpServlet {
    private UserOrderService userOrderService;

    @Override
    public void init() {
        userOrderService = new UserOrderService();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("currentUser");

        String keyword = request.getParameter("keyword");

        List<UserOrderDTO> userOrders;
        if (keyword != null && !keyword.isBlank()) {
            try {
                Long orderId = Long.parseLong(keyword);
                userOrders = userOrderService.findOrdersByUserAndOrderId(user.getId(), orderId);
            } catch (NumberFormatException e) {
                userOrders = List.of();
            }
        } else {
            userOrders = userOrderService.findOrdersByUserId(user.getId());
        }

        request.setAttribute("orders", userOrders);
        request.getRequestDispatcher("/myAccount/account-order-history.jsp")
                .forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}