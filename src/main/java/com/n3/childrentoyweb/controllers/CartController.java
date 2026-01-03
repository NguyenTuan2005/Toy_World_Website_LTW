package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.dto.CartProductDTO;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.*;
import com.n3.childrentoyweb.services.ProductAssetService;
import com.n3.childrentoyweb.services.ProductService;
import com.n3.childrentoyweb.services.PromotionService;
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
    private ProductAssetService productAssetService;
    private PromotionService promotionService;

    @Override
    public void init() {
        this.productService = new ProductService();
        this.productAssetService = new ProductAssetService();
        this.promotionService = new PromotionService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long productId = Long.parseLong(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        HttpSession session =  req.getSession();

        Cart cart = (Cart) session.getAttribute(Cart.CART);

        if(cart == null){
            cart = new Cart();
        }

        Product product = this.productService.findById(productId).orElseThrow(ObjectNotFoundException::new);
        ProductAsset asset = this.productAssetService.findFirstByProductId(productId).orElseThrow(ObjectNotFoundException::new);
        Promotion promotion = this.promotionService.findById(product.getPromotionId()).orElse(new Promotion());

        CartProductDTO cartProductDTO = new com.n3.childrentoyweb.dto.CartProductDTO(product,asset,promotion);
        cart.addItem(new CartItem(cartProductDTO,quantity));
        session.setAttribute(Cart.CART,cart);

        resp.sendRedirect(req.getHeader("Referer"));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cart cart = (Cart) req.getSession().getAttribute(Cart.CART);

        req.setAttribute(Cart.CART, cart);
        req.getRequestDispatcher("/my-shopping-cart.jsp").forward(req, resp);
    }
}
