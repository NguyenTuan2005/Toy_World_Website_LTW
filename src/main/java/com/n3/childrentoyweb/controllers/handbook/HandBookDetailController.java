package com.n3.childrentoyweb.controllers.handbook;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.HandBookCardDTO;
import com.n3.childrentoyweb.dto.HandBookCriteria;
import com.n3.childrentoyweb.dto.HandbookDetailDTO;
import com.n3.childrentoyweb.models.Handbook;
import com.n3.childrentoyweb.services.HandBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/handbook-details")
public class HandBookDetailController extends HttpServlet {
    private static final int SUGGEST_PAGE_SIZE = 3;
    private HandBookService handBookService;

    public void init(){
        this.handBookService =new HandBookService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HandBookCriteria handBookCriteria = new HandBookCriteria();
        handBookCriteria.setOnMonth(true);
        handBookCriteria.setHidden(false);
        handBookCriteria.setOrderBy("h.views");
        handBookCriteria.setCurrentPage(1);
        handBookCriteria.setPageSize(SUGGEST_PAGE_SIZE);

        Pagination<HandBookCardDTO> suggestHandbookCards = this.handBookService.findHandbookCardByCriteria(handBookCriteria);

        this.displayHandbookDetail(req);
        req.setAttribute("suggestHandbooks", suggestHandbookCards.getData());
        req.getRequestDispatcher("/handbook-detail.jsp").forward(req,resp);
    }

    private void displayHandbookDetail(HttpServletRequest request){
        try {
            long handbookId = Long.parseLong(request.getParameter("id"));

            Handbook handbook = this.handBookService.findById(handbookId).orElseThrow();
            handbook.increaseView();
            this.handBookService.updateHandbook(handbook);

            HandbookDetailDTO handbookDetailDTO = this.handBookService.findHandbookDetailById(handbookId);

            request.setAttribute("title",handbookDetailDTO.getTitle());
            request.setAttribute("createdAt",handbookDetailDTO.getCreatedAtAsDate());

            request.setAttribute("userId",handbookDetailDTO.getUserId());
            request.setAttribute("username",handbookDetailDTO.getFullName());

            request.setAttribute("categoryName",handbookDetailDTO.getCategoryName());
            request.setAttribute("categoryId",handbookDetailDTO.getCategoryId());


            request.setAttribute("paragraphs",handbookDetailDTO.getParagraphs());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
