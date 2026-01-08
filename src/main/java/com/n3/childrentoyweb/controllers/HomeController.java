package com.n3.childrentoyweb.controllers;

import java.io.*;
import java.util.List;

import com.n3.childrentoyweb.dto.HomeProductDTO;
import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.services.BannerService;
import com.n3.childrentoyweb.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;


@WebServlet(name = "home", value = "/home")
public class HomeController extends HttpServlet {
    private BannerService bannerService;
    private ProductService productService;

    @Override
    public void init()  {
        bannerService = new BannerService();
        productService = new ProductService();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

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
        List<HomeProductDTO> homeProductDTOS = this.productService.findNewImportProductsInMonth();
        request.setAttribute("newProductsInMonth",homeProductDTOS);
    }

    public void addSignatureProducts(HttpServletRequest request){
        List<HomeProductDTO> homeProductDTOS = this.productService.findSignatureProduct();
        request.setAttribute("signatureProducts",homeProductDTOS);
    }

}
