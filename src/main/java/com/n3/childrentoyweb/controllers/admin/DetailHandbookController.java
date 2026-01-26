package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dto.HandbookDetailDTO;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Handbook;
import com.n3.childrentoyweb.services.HandBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/admin/handbook-details")
public class DetailHandbookController extends HttpServlet {

    private HandBookService handBookService;

    public void init(){
        this.handBookService =new HandBookService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        this.displayHandbookDetail(req);
        req.getRequestDispatcher("/adminPages/handbook-detail.jsp").forward(req,resp);
    }

    private void displayHandbookDetail(HttpServletRequest request){
        try{
            long handbookId = Long.parseLong(request.getParameter("id"));
            HandbookDetailDTO handbookDetailDTO = this.handBookService.findHandbookDetailById(handbookId);

            request.setAttribute("title",handbookDetailDTO.getTitle());
            request.setAttribute("createdAt",handbookDetailDTO.getCreatedAtAsDate());
            request.setAttribute("status",handbookDetailDTO.getStatus());
            request.setAttribute("handbookId",handbookDetailDTO.getId());



            request.setAttribute("userId",handbookDetailDTO.getUserId());
            request.setAttribute("username",handbookDetailDTO.getFullName());

            request.setAttribute("categoryName",handbookDetailDTO.getCategoryName());
            request.setAttribute("categoryId",handbookDetailDTO.getCategoryId());


            request.setAttribute("paragraphs",handbookDetailDTO.getParagraphs());
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            long handbookId = Long.parseLong(req.getParameter("id"));
            Handbook handbook = this.handBookService.findById(handbookId).orElseThrow(ObjectNotFoundException::new);
            handbook.revertStatus();
            this.handBookService.updateHandbook(handbook);

            resp.getWriter().write("{\"success\": true, \"message\": \"Đã cập nhật bài viết!\"}");
        } catch (Exception e){
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(e.getMessage());
        }
    }
}
