package com.n3.childrentoyweb.controllers.cart;

import com.n3.childrentoyweb.enums.LocationProvince;
import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.enums.PaymentMethod;
import com.n3.childrentoyweb.enums.PaymentStatus;
import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.models.*;
import com.n3.childrentoyweb.services.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
@WebServlet(name = "createOrder", value = "/create-order")
public class CreateOrderController extends HttpServlet {
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        this.orderService = new OrderService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user;
        Cart cart = (Cart) request.getSession().getAttribute(Cart.CART);
        try {
            if ((user = (User) request.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");
            if (cart == null || cart.getTotalQuantity() == 0)
                throw new DataInvalidException("Giỏ hàng trống");

            if (user.getNoKey()){
                request.setAttribute("username",user.getFirstName()+" "+user.getLastName());
                request.getRequestDispatcher("/no-key-policy.jsp").forward(request, response);
                return;
            }

            if (user.getIsLostKey()){
                request.setAttribute("username",user.getFirstName()+" "+user.getLastName());
                request.getRequestDispatcher("/Policy-lost-key.jsp").forward(request,response);
                return;
            }


            long orderId = this.orderService.createOrder(user, cart);

            request.getSession().setAttribute(Cart.CART, new Cart());
            response.sendRedirect(request.getContextPath() + "/sign-order?orderId=" + orderId);

        } catch (Exception e) {
            request.setAttribute("error","Có lỗi xảy ra khi đặt đơn hàng, Vui lòng thử lại sau");
            request.getRequestDispatcher("/my-shopping-cart.jsp").forward(request, response);
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }



}
