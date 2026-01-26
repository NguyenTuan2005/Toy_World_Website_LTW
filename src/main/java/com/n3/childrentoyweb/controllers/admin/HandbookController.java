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
import java.util.ArrayList;

@WebServlet( value = "/admin/handbooks")
public class HandbookController extends HttpServlet {
    private HandBookService handBookService;

    public static final int  PAGE_SIZE = 9;
    private final int FIRST_PAGE =1;

    @Override
    public void init() throws ServletException {
        this.handBookService = new HandBookService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.addHandbookCards(req);
        req.getRequestDispatcher("/adminPages/handbook-management.jsp").forward(req,resp);
    }

    private void addHandbookCards(HttpServletRequest request){

        HandBookCriteria handBookCriteria = new HandBookCriteria();
        handBookCriteria.setOnMonth(true);
        int currentPage = FIRST_PAGE;

        if(request.getParameter("page") != null)
            currentPage = Integer.parseInt(request.getParameter("page"));
        handBookCriteria.setOrderBy("h.created_at");
        handBookCriteria.setCurrentPage(currentPage);
        handBookCriteria.setPageSize(PAGE_SIZE);

        Pagination<HandBookCardDTO> handBookCardDTOPagination = this.handBookService.findHandbookCardByCriteria(handBookCriteria);

        request.setAttribute("handbooks",handBookCardDTOPagination.getData());
        request.setAttribute("currentPage",handBookCardDTOPagination.getCurrentPage());
        request.setAttribute("totalElements",handBookCardDTOPagination.getTotalElements());
        request.setAttribute("totalPages",handBookCardDTOPagination.getTotalPages());
        request.setAttribute("pageSize",handBookCardDTOPagination.getData().size());
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.findByCriteria(req);
        req.getRequestDispatcher("/adminPages/handbook-management.jsp").forward(req,resp);
    }

    private void findByCriteria(HttpServletRequest request){

        String keyword = request.getParameter("keyword");

        int currentPage = FIRST_PAGE;
        if(request.getParameter("page") != null)
            currentPage = Integer.parseInt(request.getParameter("page"));

        HandBookCriteria handBookCriteria = new HandbookAdminCriteria(keyword);
        handBookCriteria.setOnDay(false);
        handBookCriteria.setOnMonth(false);
        handBookCriteria.setOrderBy("h.created_at");
        handBookCriteria.setCurrentPage(currentPage);
        handBookCriteria.setPageSize(PAGE_SIZE);

        Pagination<HandBookCardDTO> handBookCardDTOPagination = this.handBookService.findHandbookCardByCriteria(handBookCriteria);

        request.setAttribute("keyword", keyword);
        request.setAttribute("handbooks",handBookCardDTOPagination.getData());
        request.setAttribute("currentPage",handBookCardDTOPagination.getCurrentPage());
        request.setAttribute("totalElements",handBookCardDTOPagination.getTotalElements());
        request.setAttribute("totalPages",handBookCardDTOPagination.getTotalPages());
        request.setAttribute("pageSize",handBookCardDTOPagination.getData().size());
    }
}
