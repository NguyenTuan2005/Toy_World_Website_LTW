package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.exception.PermissionDeniedException;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.models.WishList;
import com.n3.childrentoyweb.services.ProductService;
import com.n3.childrentoyweb.services.WishListService;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name= "WishList",value = "/wish-list")
public class WishListController extends HttpServlet {

    private WishListService wishListService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        this.wishListService = new WishListService();
        this.productService = new ProductService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }


        long userid = user.getId();
        String pid = req.getParameter("productId");
        if(pid == null){
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        long productId = Long.parseLong(pid);

        Product product = this.productService.findById(productId).orElseThrow(ObjectNotFoundException::new);

        WishList wishList = new WishList(userid, product.getId());
        this.wishListService.save(wishList);

        resp.setStatus(HttpServletResponse.SC_OK);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {



    }
}
