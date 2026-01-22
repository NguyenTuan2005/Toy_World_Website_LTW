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
import java.nio.file.Paths;
import java.util.List;

@WebServlet(value = "/admin/update-banners")
@MultipartConfig(
        maxFileSize = 5242880,      // 5MB
        maxRequestSize = 10485760,  // 10MB
        fileSizeThreshold = 0
)
public class UpdateBannerController extends HttpServlet {
    private EventService eventService;
    private BannerService bannerService;
    private CloudinaryService cloudinaryService;

    public static final int  PAGE_SIZE = 10;
    private static boolean isNotification = false;
    private static String error  = "Không cập nhật dc";
    private static String ok  = "Thành công";
    private static String message = "";

    @Override
    public void init() throws ServletException {
        this.bannerService = new BannerService();
        this.eventService = new EventService();
        this.cloudinaryService = new CloudinaryService();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.loadBannerDetail(req);
        this.loadEvents(req);
        req.setAttribute("notify",isNotification);
        req.setAttribute("message",message);
        isNotification = false;
        req.getRequestDispatcher("/adminPages/update-banner.jsp").forward(req,resp);
    }

    private void loadBannerDetail(HttpServletRequest request){
        if(request.getParameter("id") == null){
            throw new ObjectNotFoundException();
        }
        long id = Long.parseLong(request.getParameter("id"));

        System.out.println("Ok id ="+id);
        Banner banner =this.bannerService.getBannerById(id).orElseThrow(ObjectNotFoundException::new);

//        System.out.println(banner);
        request.setAttribute("banner",banner);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        this.update(req,resp);

//        req.getRequestDispatcher("/adminPages/update-banner.jsp").forward(req,resp);
    }


    private void loadEvents(HttpServletRequest request){
        List<Event> events = this.eventService.findActiveEvent();
        request.setAttribute("events",events);
    }

    private void update(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        System.out.println("------DEBUG------");
        String bannerName = request.getParameter("name");
        String event = request.getParameter("eventId");
        String status = request.getParameter("status");

        System.out.println("name "+bannerName+" event "+event);
        System.out.println("status "+status);

        isNotification = true;

        if(request.getParameter("id") == null || request.getParameter("eventId") == null){
            message = error;
            return;
        }

        String fileName = null;
        String filePath = null;

        Part filePart = request.getPart("bannerImage");

        if (filePart != null && filePart.getSize() > 0) {
           fileName = this.cloudinaryService.upload(filePart);
        }

        long id = Long.parseLong(request.getParameter("id"));
         Banner banner = this.bannerService.getBannerById(id).orElseThrow(ObjectNotFoundException::new);
         banner.setTitle(bannerName);
         banner.setEventId(Long.parseLong(event));
         if ( fileName != null)
            banner.setImgPath(filePath);
         banner.setActive(Boolean.parseBoolean(status));

        try{
            this.bannerService.updateBanner(banner);
            message = ok;
        } catch (Exception e){
            message = error;
        }

        response.sendRedirect(request.getHeader("Referer"));

    }

}
