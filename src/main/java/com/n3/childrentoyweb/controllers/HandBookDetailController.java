package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.dto.HandbookDetailDTO;
import com.n3.childrentoyweb.services.HandBookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/handbook-details")
public class HandBookDetailController extends HttpServlet {

    private HandBookService handBookService;

    public void init(){
        this.handBookService =new HandBookService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        this.displayHandbookDetail(req);
        req.getRequestDispatcher("/handbook-detail.jsp").forward(req,resp);
    }

    private void displayHandbookDetail(HttpServletRequest request){
        HandbookDetailDTO handbookDetailDTO = this.handBookService.findHandbookDetailById(4);

        request.setAttribute("title",handbookDetailDTO.getTitle());
        request.setAttribute("createdAt",handbookDetailDTO.getCreated());

        request.setAttribute("userId",handbookDetailDTO.getUserId());
        request.setAttribute("username",handbookDetailDTO.getFullName());

        request.setAttribute("categoryName",handbookDetailDTO.getCategoryName());
        request.setAttribute("categoryId",handbookDetailDTO.getCategoryId());


        request.setAttribute("paragraphs",handbookDetailDTO.getParagraphs());
    }
}
