package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
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
import java.time.LocalDateTime;

@WebServlet(value = "/admin/update-promotions")
public class UpdatePromotionController extends HttpServlet {
    private PromotionService promotionService = new PromotionService();
    private EventService eventService = new EventService();
    private static boolean isNotification = false;
    private static String error  = "Không tạo đc Giảm giá";
    private static String ok  = "Thành công";
    private static String message = "";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getParameter("promotionId") == null){
            throw  new ObjectNotFoundException();
        }
        long promotionId = Long.parseLong(req.getParameter("promotionId"));
        var promotion = this.promotionService.getPromotionById(promotionId).orElseThrow(ObjectNotFoundException::new);
        req.setAttribute("promotion",promotion);

        var pagination = this.eventService.findEventForManagement(1,20);
        req.setAttribute("events",pagination.getData());

        req.setAttribute("notify",isNotification);
        req.setAttribute("message",message);
        req.setAttribute("date",LocalDateTimeConverterUtil.convertToStringForInputTag(promotion.getExpiredAt()));
        isNotification = false;
        req.getRequestDispatcher("/adminPages/update-promotion.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("promotionName");
        String expiryDateStr = req.getParameter("expiryDate");

        System.out.println(expiryDateStr);
        isNotification = true;

        if( expiryDateStr == null
                || req.getParameter("eventId") == null
                || req.getParameter("expiryDate") == null
                || req.getParameter("id") == null) {

            System.out.println(" invalid");
            message = error;
            return;
        }
        long id = 1;
        long eventId = Long.parseLong(req.getParameter("eventId"));
        double discountPrice =  Double.parseDouble(req.getParameter("discountPrice"));
        double discountPercent =  Double.parseDouble(req.getParameter("discountPercent"));
        boolean status = Boolean.parseBoolean(req.getParameter("status"));
        LocalDateTime expiredAt = LocalDateTimeConverterUtil.convertDateStringToLocalDateTime(expiryDateStr);

        Promotion promotion =  this.promotionService.getPromotionById(id).orElseThrow(ObjectNotFoundException::new);
        promotion.setName(name);
        promotion.setDiscountPrice(discountPrice);
        promotion.setDiscountPercent(discountPercent);
        promotion.setExpiredAt(expiredAt);
        promotion.setActive(status);
        promotion.setEventId(eventId);

        try{
            promotionService.updatePromotion(promotion);
            message = ok;

        } catch (Exception e){
            message = error;
        }

        resp.sendRedirect(req.getHeader("Referer"));
    }

}
