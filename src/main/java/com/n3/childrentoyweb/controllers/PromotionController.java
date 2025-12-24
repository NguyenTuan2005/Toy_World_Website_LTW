package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.dao.BannerDAO;
import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;
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

    private static final Logger log =
            Logger.getLogger(PromotionController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Banner> list = new BannerDAO().findAllByGroupTag(BannerGroupTag.PROMOTION);
        log.info("Demo banner");
        log.info(list.get(0).toString());
        System.out.println("James demo" + list.get(0).toString());

        request.setAttribute("banners", list);
        request.getRequestDispatcher("promotion.jsp").forward(request, response);

    }
}
