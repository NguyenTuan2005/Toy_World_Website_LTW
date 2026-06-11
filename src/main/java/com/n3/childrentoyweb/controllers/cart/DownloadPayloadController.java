package com.n3.childrentoyweb.controllers.cart;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.models.Order;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.OrderService;
import com.n3.childrentoyweb.services.UserOrderService;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.Signature;
import java.util.List;

@WebServlet(name = "downloadOrderPayload", value = "/dowload-order-payload")
public class DownloadPayloadController extends HttpServlet {
    private OrderService orderService;

    public DownloadPayloadController() {
        this.orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");

        User currentUser;
        try{
            if ((currentUser = (User) request.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");

            long orderId = Long.parseLong(request.getParameter("orderId"));

            String payload = orderService.getOrderPayload(orderId);

            response.setHeader(
                    "Content-Disposition",
                    "attachment; filename=order-"
                            + orderId + ".json"
            );

            response.getWriter().write(payload);

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/my-shopping-cart.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");


    }

}
