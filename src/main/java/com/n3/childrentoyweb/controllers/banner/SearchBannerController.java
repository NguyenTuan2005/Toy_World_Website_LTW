package com.n3.childrentoyweb.controllers.banner;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.services.BannerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(value = "/admin/search-banners")
public class SearchBannerController extends HttpServlet {
    private BannerService bannerService =new BannerService();
    private int PAGE_SIZE =10;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        addBannerPagination(req);
        req.getRequestDispatcher("/adminPages/banner.jsp").forward(req,resp);
    }

    private void addBannerPagination(HttpServletRequest request){
        int page = 1;
        if(request.getParameter("banner-page") != null)
            page = Integer.parseInt(request.getParameter("banner-page"));

        String title = request.getParameter("keyword");

        Pagination<Banner> bannerPagination  = this.bannerService.findByTile(page,PAGE_SIZE,title);
        System.out.println(bannerPagination);
        request.setAttribute("banners",bannerPagination.getData());
        request.setAttribute("currentPage_banner",bannerPagination.getCurrentPage());
        request.setAttribute("totalElements_banner",bannerPagination.getTotalElements());
        request.setAttribute("totalPages_banner",bannerPagination.getTotalPages());
        request.setAttribute("pageSize_banner",PAGE_SIZE);


        Map<String, List<Banner>> bannersByGroup = bannerPagination.getData().stream()
                .collect(Collectors.groupingBy(Banner::getGroupTag));
        request.setAttribute("bannersByGroup", bannersByGroup);
        request.setAttribute("find_banners",true);
    }
}
