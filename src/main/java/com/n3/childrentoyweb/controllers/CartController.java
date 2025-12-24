package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Cart;
import com.n3.childrentoyweb.models.CartItem;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.services.ProductService;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


@WebServlet(name = "cart", value = "/cart")
public class CartController  extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() {
        this.productService = new ProductService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long productId = Long.parseLong(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        System.out.println("productId" +productId);
        HttpSession session =  req.getSession();

        Cart cart = (Cart) session.getAttribute(Cart.CART);

        if(cart == null){
            cart = new Cart();
        }

        Product product = this.productService.findById(productId).orElseThrow(ObjectNotFoundException::new);

        cart.addItem(new CartItem(product,quantity));
        session.setAttribute(Cart.CART,cart);

        resp.sendRedirect(req.getHeader("Referer"));
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
    }


}
