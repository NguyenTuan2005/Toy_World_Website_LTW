package com.n3.childrentoyweb.controllers.account;

import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.LocationService;
import com.n3.childrentoyweb.services.WishListService;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(value = "/account/wishlist")
public class WishlistController extends HttpServlet {
    private WishListService wishListService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.wishListService = new WishListService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User currentUser  = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Long userId = currentUser.getId();

        request.setAttribute("wishlist", wishListService.findUserWishlist(userId));

        request.getRequestDispatcher("/myAccount/account-wishlist.jsp").forward(request,response);
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

        response.sendRedirect(request.getContextPath() + "/account/wishlist");
    }
}