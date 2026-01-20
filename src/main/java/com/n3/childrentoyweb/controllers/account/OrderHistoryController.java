package com.n3.childrentoyweb.controllers.account;

import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.exception.ForbiddenException;
import com.n3.childrentoyweb.exception.InvalidOrderStateException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.UserOrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(value = "/account/order-history")
public class OrderHistoryController extends HttpServlet {
    private UserOrderService userOrderService;

    @Override
    public void init() {
        userOrderService = new UserOrderService();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("currentUser");


        List<UserOrderDTO> userOrders = userOrderService.getOrdersByUser(user.getId());

        request.setAttribute("orders", userOrders);

        request.getRequestDispatcher("/account-order-history.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}