package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.services.BannerService;
import com.n3.childrentoyweb.services.EventService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/banners")
public class BannerController extends HttpServlet {
    private EventService eventService;
    private BannerService bannerService;
    public static final int  PAGE_SIZE = 10;

    @Override
    public void init() throws ServletException {
        this.bannerService = new BannerService();
        this.eventService = new EventService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.addBannerPagination(req);
        this.addStatisticEvent(req);
        req.getRequestDispatcher("/adminPages/banner.jsp").forward(req,resp);
    }

    private void addBannerPagination(HttpServletRequest request){
        int page = 1;
        if(request.getParameter("banner-page") != null)
            page = Integer.parseInt(request.getParameter("banner-page"));

        Pagination<Banner> bannerPagination  = this.bannerService.findBannerPaging(page,PAGE_SIZE);
        System.out.println(bannerPagination);
        request.setAttribute("banners",bannerPagination.getData());
        request.setAttribute("currentPage_banner",bannerPagination.getCurrentPage());
        request.setAttribute("totalElements_banner",bannerPagination.getTotalElements());
        request.setAttribute("totalPages_banner",bannerPagination.getTotalPages());
        request.setAttribute("pageSize_banner",PAGE_SIZE);
    }

    private void addStatisticEvent(HttpServletRequest request){
        int total = eventService.getTotalEvent();
        int ongoing = eventService.getOngoingEvent();
        int upcoming = eventService.getUpcomingEvent();
        int ended = eventService.getEndedEvent();

        request.setAttribute("total_events",total);
        request.setAttribute("total_in_process",ongoing);
        request.setAttribute("total_by_take_place",upcoming);
        request.setAttribute("total_done",ended);
    }



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
