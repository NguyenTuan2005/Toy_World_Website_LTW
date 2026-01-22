package com.n3.childrentoyweb.controllers.banner;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Banner;
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
import java.util.concurrent.CompletableFuture;

@WebServlet(value = "/admin/banners/update")
@MultipartConfig(
        maxFileSize = 5242880,      // 5MB
        maxRequestSize = 10485760,  // 10MB
        fileSizeThreshold = 0
)
public class UpdateBannerController extends HttpServlet {

    private BannerService bannerService = new BannerService();
    private EventService eventService = new EventService();
    private CloudinaryService cloudinaryService = new CloudinaryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if(req.getParameter("id") == null)
            throw new ObjectNotFoundException();

        long id = Long.parseLong(req.getParameter("id"));

        var banner = this.bannerService.getBannerById(id).orElseThrow(ObjectNotFoundException::new);

        List<String> groupTags = bannerService.findAllGroupTags();
        var events = this.eventService.findActiveEvent();

        req.setAttribute("tags", groupTags);
        req.setAttribute("banner", banner); // chỉ cho edit
        req.setAttribute("events",events);
        req.getRequestDispatcher("/adminPages/banners/update-banner.jsp").forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            String title = request.getParameter("title");
            String groupTag = request.getParameter("groupTag");
            int sortOrder = Integer.parseInt(request.getParameter("sortOrder"));
            String eventIdParam = request.getParameter("eventId");
            String isActiveParam = request.getParameter("isActive");

            // Xử lý upload file ảnh mới (nếu có)
            Part filePart = request.getPart("imgFile");
            String img = null;
            if (filePart != null && filePart.getSize() > 0) {
                CompletableFuture<String> upload =CompletableFuture.supplyAsync(()->this.cloudinaryService.upload(filePart));
                img = upload.get();
            }


            Banner banner = this.bannerService.getBannerById(id).orElseThrow(ObjectNotFoundException::new);
            banner.setTitle(title);
            banner.setEventId(Long.parseLong(eventIdParam));
            if (img != null)
                banner.setImgPath(img);
            banner.setActive(Boolean.parseBoolean(isActiveParam));
            banner.setSortOrder(sortOrder);
            banner.setGroupTag(groupTag);

            this.bannerService.updateBanner(banner);
            request.setAttribute("success","Thành công");
            System.out.println(banner);
        } catch ( Exception e){
            request.setAttribute("error","Không thành công");
        }
        resp.sendRedirect(request.getContextPath() + "/admin/banners/update?id="+request.getParameter("id"));
    }
}
