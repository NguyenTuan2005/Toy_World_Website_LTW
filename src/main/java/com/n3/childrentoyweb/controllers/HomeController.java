package com.n3.childrentoyweb.controllers;

import java.io.*;
import java.util.List;

import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.services.BannerService;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
@WebServlet(name = "home", value = "/home")
public class HomeController extends HttpServlet {
    private BannerService bannerService;

    @Override
    public void init() throws ServletException {
        bannerService = new BannerService();
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        this.addBanners(request);


        request.getRequestDispatcher("home-page.jsp").forward(request, response);
    }

    private void addBanners(HttpServletRequest request){
        List<String> banners = this.bannerService.findAllBanners(BannerGroupTag.HOME).stream().map(Banner::getImgPath).toList();
        System.out.println(banners);
        request.setAttribute("banners", banners);
    }



}
