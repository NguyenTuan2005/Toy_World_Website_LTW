package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.models.Event;
import com.n3.childrentoyweb.models.Promotion;
import com.n3.childrentoyweb.services.EventService;
import com.n3.childrentoyweb.services.PromotionService;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;

@WebServlet(value = "/admin/new-promotions")
public class NewPromotionController extends HttpServlet {

    private EventService eventService = new EventService();
    private PromotionService promotionService = new PromotionService();
    private static boolean isNotification = false;
    private static String error  = "Không tạo đc Giảm giá";
    private static String ok  = "Thành công";
    private static String message = "";
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        this.addEventsPagination(req);

        req.getRequestDispatcher("/adminPages/new-promotion.jsp").forward(req,resp);
    }

    private void addEventsPagination( HttpServletRequest request){
        int page = 1;
        if(request.getParameter("page") != null)
            page = Integer.parseInt(request.getParameter("page").trim());

        Pagination<Event> eventPagination = this.eventService.findEventForManagement(page,20);
        System.out.println(eventPagination);
        request.setAttribute("events",eventPagination.getData());
        request.setAttribute("notify",isNotification);
        request.setAttribute("message",message);
        isNotification = false;

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Run cái controller");
        this.createPromotion(req);

        resp.sendRedirect(req.getHeader("Referer"));
    }

    public void  createPromotion(HttpServletRequest req){
        System.out.println("Run cái controller");
        String name = req.getParameter("promotionName");
        String expiryDateStr = req.getParameter("expiryDate");

        System.out.println(expiryDateStr);
        isNotification = true;

        if( expiryDateStr == null
                || req.getParameter("eventId") == null
                || req.getParameter("expiryDate") == null ) {

            System.out.println(" invalid");
            message = error;
            return;
        }

        long eventId = Long.parseLong(req.getParameter("eventId"));
        double discountPrice =  Double.parseDouble(req.getParameter("discountPrice"));
        double discountPercent =  Double.parseDouble(req.getParameter("discountPercent"));
        boolean status = Boolean.parseBoolean(req.getParameter("status"));
        LocalDateTime expiredAt = LocalDateTimeConverterUtil.convertDateStringToLocalDateTime(expiryDateStr);

        Promotion promotion = new Promotion();
        promotion.setName(name);
        promotion.setDiscountPrice(discountPrice);
        promotion.setDiscountPercent(discountPercent);
        promotion.setExpiredAt(expiredAt);
        promotion.setActive(status);
        promotion.setEventId(eventId);

        try{
            promotionService.save(promotion);
            message = ok;

        } catch (Exception e){
            message = error;
        }

    }
}
