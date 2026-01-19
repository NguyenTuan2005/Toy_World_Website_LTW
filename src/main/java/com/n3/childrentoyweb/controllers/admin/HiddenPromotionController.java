package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.services.PromotionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/admin/hidden-promotions")
public class HiddenPromotionController extends HttpServlet {
    private PromotionService promotionService = new PromotionService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try{

            long promotionId = Long.parseLong( req.getParameter("promotionId"));
            var promotion = this.promotionService.findById(promotionId).orElseThrow(ObjectNotFoundException::new);

            promotion.revertActive();

            System.out.println("Load  for hiddent"+promotion);
            this.promotionService.updatePromotion(promotion);
        }catch (ObjectNotFoundException e){
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        } catch (Exception e){
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        resp.sendRedirect(req.getContextPath()+"/admin/promotions");
    }
}
