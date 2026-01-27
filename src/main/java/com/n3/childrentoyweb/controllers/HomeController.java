package com.n3.childrentoyweb.controllers;

import java.io.*;
import java.util.List;

import com.n3.childrentoyweb.dto.HomeProductDTO;
import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.BannerService;
import com.n3.childrentoyweb.services.ProductService;
import com.n3.childrentoyweb.services.WishListService;
import com.n3.childrentoyweb.utils.AppContextPathHolder;
import com.n3.childrentoyweb.utils.EndpointUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;


@WebServlet(name = "home", value = "/home")
public class HomeController extends HttpServlet {
    private BannerService bannerService;
    private ProductService productService;
    private WishListService wishListService;

    @Override
    public void init()  {
        bannerService = new BannerService();
        productService = new ProductService();
        EndpointUtil.printAllEndpoints(getServletContext());
        wishListService = new WishListService();
    }
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        AppContextPathHolder.setContextPath(request.getContextPath());

        this.addBanners(request);
        this.addNewProductsInMonth(request);
        this.addSignatureProducts(request);
        request.getRequestDispatcher("/home-page.jsp").forward(request, response);
    }

    private void addBanners(HttpServletRequest request){
        List<String> banners = this.bannerService.findAllBanners(BannerGroupTag.HOME).stream().map(Banner::getImgPath).toList();
        request.setAttribute("banners", banners);
    }

    private void addNewProductsInMonth(HttpServletRequest request){
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        Long userId = (currentUser != null) ? currentUser.getId() : null;
        List<HomeProductDTO> homeProductDTOS = this.productService.findNewImportProductsInMonth().stream().map(p -> {

            boolean isWishListed = this.wishListService.isProductInWishList(userId,p.getId());
            p.setWishlisted(isWishListed);
            return p;
        }).toList();
        request.setAttribute("newProductsInMonth",homeProductDTOS);
    }

    public void addSignatureProducts(HttpServletRequest request){
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        Long userId = (currentUser != null) ? currentUser.getId() : null;
        List<HomeProductDTO> homeProductDTOS = this.productService.findSignatureProduct().stream().map(p -> {

            boolean isWishListed = this.wishListService.isProductInWishList(userId,p.getId());
            p.setWishlisted(isWishListed);
            return p;
        }).toList();
        request.setAttribute("signatureProducts",homeProductDTOS);
    }

}
