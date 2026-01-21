package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.models.Event;
import com.n3.childrentoyweb.services.BannerService;
import com.n3.childrentoyweb.services.CloudinaryService;
import com.n3.childrentoyweb.services.EventService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/admin/new-banners")
@MultipartConfig(
        maxFileSize = 5242880,      // 5MB
        maxRequestSize = 10485760,  // 10MB
        fileSizeThreshold = 0
)
public class NewBannerController extends HttpServlet {

    private EventService eventService = new EventService();
    private CloudinaryService cloudinaryService = new CloudinaryService();
    private BannerService bannerService = new BannerService();

    private void loadEvents(HttpServletRequest request){
        List<Event> events = this.eventService.findActiveEvent();
        request.setAttribute("events",events);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        loadEvents(req);
        req.getRequestDispatcher("/adminPages/new-banner.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("------DEBUG------");
        String bannerName = request.getParameter("name");
        String event = request.getParameter("eventId");
        String status = request.getParameter("status");
        String group = request.getParameter("group");


        System.out.println("name "+bannerName+" event "+event);
        System.out.println("status "+status);

        if(request.getParameter("id") == null || request.getParameter("eventId") == null){
            return;
        }

        String fileName = null;
        String filePath = null;

        Part filePart = request.getPart("bannerImage");

        if (filePart != null && filePart.getSize() > 0) {
            fileName = this.cloudinaryService.upload(filePart);
        }

//        long id = Long.parseLong(request.getParameter("id"));
        Banner banner = new Banner();
        banner.setGroupTag(group);
        banner.setTitle(bannerName);
        banner.setEventId(Long.parseLong(event));
        banner.setSortOrder(Integer.parseInt(request.getParameter("sortOrder")));
        if ( fileName != null)
            banner.setImgPath(fileName);
        banner.setActive(Boolean.parseBoolean(status));

        try{
            this.bannerService.save(banner);
        } catch (Exception e){
            e.printStackTrace();
        }

        System.out.println("đone" + banner);

        resp.sendRedirect(request.getHeader("Referer"));
    }
}
