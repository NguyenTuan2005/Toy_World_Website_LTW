package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.dao.BannerDAO;
import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.services.BannerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "promotions", value = "/promotion")
public class PromotionController extends HttpServlet {

    private String DEFAULT_BANNER_PROMOTION="https://www.mykingdom.com.vn/cdn/shop/files/1._1280x496_124de139-e6a1-496a-aac8-f4f9030fbd79.webp?v=1767199490&width=1200";
    private BannerService bannerService;

    public void init(){
        bannerService = new BannerService();
    }

    private static final Logger log =
            Logger.getLogger(PromotionController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        this.addBanner(request);
        request.getRequestDispatcher("promotion.jsp").forward(request, response);

    }

    private void addBanner(HttpServletRequest request){
        Banner banner = this.bannerService.findBannerForCurrentPromotion().orElse(new Banner(DEFAULT_BANNER_PROMOTION));
        request.setAttribute("banner",banner.getImgPath());
    }

}
