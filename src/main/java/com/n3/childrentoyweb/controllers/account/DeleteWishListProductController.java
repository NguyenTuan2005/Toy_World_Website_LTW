package com.n3.childrentoyweb.controllers.account;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.WishListService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(value = "/wishlist/remove")
public class DeleteWishListProductController extends HttpServlet {
    private WishListService wishListService;
    @Override
    public void init(){
        wishListService = new WishListService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Long productId = Long.parseLong(request.getParameter("productId"));

        wishListService.removeFromWishlist(user.getId(), productId);

        response.sendRedirect(request.getContextPath() + "/account");
    }
}