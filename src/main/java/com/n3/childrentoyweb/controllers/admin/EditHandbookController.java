package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dto.HandbookDetailDTO;
import com.n3.childrentoyweb.models.CategoryHb;
import com.n3.childrentoyweb.services.CategoryHbService;
import com.n3.childrentoyweb.services.HandBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/admin/edit-handbooks")
public class EditHandbookController extends HttpServlet {
    private HandBookService handBookService;
    private CategoryHbService categoryHbService;

    @Override
    public void init() throws ServletException {
        this.handBookService = new HandBookService();
        this.categoryHbService =new CategoryHbService();
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        this.loadHandbookDetail(req);
        this.addCategoryOfHandbook(req);
        req.getRequestDispatcher("/adminPages/edit-handbook.jsp").forward(req,resp);
    }

    private void loadHandbookDetail(HttpServletRequest request){
        if(request.getParameter("id")== null){
            System.out.println("Not found");
        }

        long handbookId = Long.parseLong(request.getParameter("id"));
        HandbookDetailDTO handbookDetailDTO = this.handBookService.findHandbookDetailById(handbookId);

        request.setAttribute("title",handbookDetailDTO.getTitle());
        request.setAttribute("createdAt",handbookDetailDTO.getCreated());
        request.setAttribute("status",handbookDetailDTO.getStatus());
        request.setAttribute("handbookId",handbookDetailDTO.getId());



        request.setAttribute("userId",handbookDetailDTO.getUserId());
        request.setAttribute("username",handbookDetailDTO.getFullName());

        request.setAttribute("categoryName",handbookDetailDTO.getCategoryName());
        request.setAttribute("categoryId",handbookDetailDTO.getCategoryId());


        request.setAttribute("paragraphs",handbookDetailDTO.getParagraphs());

    }


    private void addCategoryOfHandbook(HttpServletRequest request){
        List<CategoryHb> categoryHbs = this.categoryHbService.findAll();
        request.setAttribute("categoryOfHB",categoryHbs);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
