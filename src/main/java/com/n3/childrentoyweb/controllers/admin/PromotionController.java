package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.models.Promotion;
import com.n3.childrentoyweb.services.PromotionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/admin/promotions")
public class PromotionController extends HttpServlet {
    private PromotionService promotionService;
    private int PAGE_SIZE =10;

    @Override
    public void init() throws ServletException {
        this.promotionService = new PromotionService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Dm chay adadsadasdasdsadsa ");
        this.addPromotionsPagination(req);
        req.getRequestDispatcher("/adminPages/promotion.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


    }

    private void addPromotionsPagination(HttpServletRequest request){
        int page = 1;
        if(request.getParameter("promotion-page") != null)
            page = Integer.parseInt(request.getParameter("promotion-page"));

        Pagination<Promotion> promotionPagination = this.promotionService.findPromotionPaging(page,PAGE_SIZE);
        System.out.println(promotionPagination);
        request.setAttribute("promotions",promotionPagination.getData());
        request.setAttribute("currentPage_promotion",promotionPagination.getCurrentPage());
        request.setAttribute("totalElements_promotion",promotionPagination.getTotalElements());
        request.setAttribute("totalPages_promotion",promotionPagination.getTotalPages());
        request.setAttribute("pageSize_promotion",PAGE_SIZE);
    }
}
