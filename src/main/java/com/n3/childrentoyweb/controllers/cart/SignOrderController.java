package com.n3.childrentoyweb.controllers.cart;

import com.n3.childrentoyweb.dto.CartProductDTO;
import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.enums.PaymentStatus;
import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.*;
import com.n3.childrentoyweb.services.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "signOrder", value = "/sign-order")
public class SignOrderController extends HttpServlet {
    private OrderService orderService;
    private UserService userService;
    private UserOrderService userOrderService;

    @Override
    public void init() {
        this.userOrderService = new UserOrderService();
        this.orderService = new OrderService();
        this.userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser;
        try {
            if ((currentUser = (User) request.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");

            long orderId = Long.parseLong(request.getParameter("orderId"));

            UserOrderDTO userOrder = userOrderService.findOrdersByUserAndOrderId(currentUser.getId() , orderId);

            request.setAttribute("order", userOrder);
            System.out.println(userOrder);
            request.setAttribute("userFullName", currentUser.getFullName());

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/my-shopping-cart.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("/sign-order.jsp").forward(request, response);
    }


}
