package com.n3.childrentoyweb.controllers.cart;

import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.models.Cart;
import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.LocationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "checkout", value = "/checkout")
public class CheckoutController extends HttpServlet {
    private LocationService locationService;

    @Override
    public void init() throws ServletException {
        this.locationService = new LocationService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user;
        try {
            if ((user = (User) req.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");
            if (req.getSession().getAttribute(Cart.CART) == null)
                throw new DataInvalidException("Giỏ hàng trống");

            req.getRequestDispatcher("/checkout.jsp").forward(req,resp);
        } catch (DataInvalidException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/my-shopping-cart.jsp").forward(req, resp);
        }
    }
}
