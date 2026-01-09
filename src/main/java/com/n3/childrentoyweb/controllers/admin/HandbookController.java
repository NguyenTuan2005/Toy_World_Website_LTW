package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.HandBookCardDTO;
import com.n3.childrentoyweb.dto.HandBookCriteria;
import com.n3.childrentoyweb.dto.HandbookAdminCriteria;
import com.n3.childrentoyweb.services.HandBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet( value = "/admin/handbooks")
public class HandbookController extends HttpServlet {
    private HandBookService handBookService;

    public static final int  PAGE_SIZE = 10;
    private final int FIRST_PAGE =1;

    @Override
    public void init() throws ServletException {
        this.handBookService = new HandBookService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.statisticHandbooks(req);
        this.addHandbookCards(req);
        req.getRequestDispatcher("/adminPages/handbook-management.jsp").forward(req,resp);
    }

    private void statisticHandbooks(HttpServletRequest request){
        int totalHandbooks = 100;
        int totalHiddenHandbooks = 10;
        int totalNewHandbooksOnMonth =30;
        int totalPostedOnMonth =20;
        int totalHiddenOnMonth =10;

        request.setAttribute("total_handbooks",totalHandbooks);
        request.setAttribute("total_hidden_handbooks",totalHiddenHandbooks);
        request.setAttribute("total_new_handbooks_on_month",totalNewHandbooksOnMonth);
        request.setAttribute("total_posted_on_month",totalPostedOnMonth);
        request.setAttribute("total_hidden_on_month",totalHiddenOnMonth);
    }

    private void addHandbookCards(HttpServletRequest request){

        HandBookCriteria handBookCriteria = new HandBookCriteria();
        handBookCriteria.setOnMonth(true);
        int currentPage = FIRST_PAGE;

        if(request.getParameter("page") != null)
            currentPage = Integer.parseInt(request.getParameter("page"));

        handBookCriteria.setCurrentPage(currentPage);
        handBookCriteria.setPageSize(PAGE_SIZE);

        Pagination<HandBookCardDTO> handBookCardDTOPagination = this.handBookService.findHandbookCardByCriteria(handBookCriteria);

        System.out.println(handBookCardDTOPagination.getData());

        request.setAttribute("handbooks",handBookCardDTOPagination.getData());
        request.setAttribute("currentPage",handBookCardDTOPagination.getCurrentPage());
        request.setAttribute("totalElements",handBookCardDTOPagination.getTotalElements());
        request.setAttribute("totalPages",handBookCardDTOPagination.getTotalPages());
        request.setAttribute("pageSize",handBookCardDTOPagination.getData().size());
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.findByCriteria(req);
        this.statisticHandbooks(req);
        req.getRequestDispatcher("/adminPages/handbook-management.jsp").forward(req,resp);
    }

    private void findByCriteria(HttpServletRequest request){

        String keyword = request.getParameter("keyword");

        HandBookCriteria handBookCriteria = new HandbookAdminCriteria(keyword);
        handBookCriteria.setOnDay(false);
        handBookCriteria.setOnMonth(false);
        handBookCriteria.setCurrentPage(FIRST_PAGE);
        handBookCriteria.setPageSize(PAGE_SIZE);
        System.out.println(handBookCriteria);

        Pagination<HandBookCardDTO> handBookCardDTOPagination = this.handBookService.findHandbookCardByCriteria(handBookCriteria);

        System.out.println(handBookCardDTOPagination.getData());

        request.setAttribute("handbooks",handBookCardDTOPagination.getData());
        request.setAttribute("currentPage",handBookCardDTOPagination.getCurrentPage());
        request.setAttribute("totalElements",handBookCardDTOPagination.getTotalElements());
        request.setAttribute("totalPages",handBookCardDTOPagination.getTotalPages());
        request.setAttribute("pageSize",handBookCardDTOPagination.getData().size());
    }
}
