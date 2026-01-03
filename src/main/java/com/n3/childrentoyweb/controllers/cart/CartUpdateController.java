package com.n3.childrentoyweb.controllers.cart;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "cartUpdate", value="/cart-update")
public class CartUpdateController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            if (req.getParameter("quantity") == null || req.getParameter("productId") == null)
                throw new IllegalArgumentException("Thiếu tham số 'productId' hoặc 'quantity'");

            long productId = Long.parseLong(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            HttpSession session = req.getSession();
            Cart cart = (Cart) session.getAttribute(Cart.CART);

            if (cart == null)
                throw new ObjectNotFoundException("Không tìm thấy giỏ hàng");

            cart.updateQuantity(productId, quantity);
            session.setAttribute(Cart.CART, cart);
            resp.getWriter().write("{\"success\": true}");
        } catch (Exception e) {
            resp.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}
