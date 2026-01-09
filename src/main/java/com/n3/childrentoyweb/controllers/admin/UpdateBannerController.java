package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.models.Event;
import com.n3.childrentoyweb.services.BannerService;
import com.n3.childrentoyweb.services.CloudinaryService;
import com.n3.childrentoyweb.services.EventService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(value = "/admin/update-banners")
public class UpdateBannerController extends HttpServlet {
    private EventService eventService;
    private BannerService bannerService;
    private CloudinaryService cloudinaryService;

    public static final int  PAGE_SIZE = 10;

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
        req.getRequestDispatcher("/adminPages/update-banner.jsp").forward(req,resp);
    }

    private void loadBannerDetail(HttpServletRequest request){
        if(request.getParameter("id") == null){
            System.out.println("null roifo");
            throw new ObjectNotFoundException();
        }
        long id = Long.parseLong(request.getParameter("id"));

        System.out.println("Ok id ="+id);
        Banner banner =this.bannerService.getBannerById(id).orElseThrow(ObjectNotFoundException::new);

        System.out.println(banner);
        request.setAttribute("banner",banner);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        this.updateBanner(req);

        req.getRequestDispatcher("/adminPages/update-banner.jsp").forward(req,resp);
    }

    private void updateBanner(HttpServletRequest request) throws ServletException, IOException {
        Part filePart = request.getPart("bannerImage");
        String bannerName = request.getParameter("bannerName");
        String eventId = request.getParameter("eventId");
    }


    private void loadEvents(HttpServletRequest request){
        List<Event> events = this.eventService.findActiveEvent();
        request.setAttribute("events",events);
    }

    private void update(HttpServletRequest request){


        try {
            // 1. Lấy dữ liệu từ form
            String bannerName = request.getParameter("bannerName");
            String event = request.getParameter("eventId");
            String status = request.getParameter("status");

            // 2. Xử lý upload file
            String fileName = null;
            String filePath = null;

            Part filePart = request.getPart("bannerImage");

            if (filePart != null && filePart.getSize() > 0) {
               fileName = this.cloudinaryService.upload(filePart);
            }

            // 3. Tạo object Banner
             Banner banner = new Banner();
             banner.setTitle(bannerName);

             banner.setImgPath(filePath);
//             banner.setStatus(Boolean.parseBoolean(status));

            // 4. Lưu vào database
            // bannerDAO.save(banner);

            // 5. Thông báo thành công
            request.getSession().setAttribute("message", "Lưu banner thành công!");
            request.getSession().setAttribute("messageType", "success");

            // 6. Redirect về danh sách
//            response.sendRedirect(request.getContextPath() + "/admin/banners");

        } catch (Exception e) {
            e.printStackTrace();

            // Thông báo lỗi
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");

//            response.sendRedirect(request.getContextPath() + "/admin/banner");
        }
    }

}
