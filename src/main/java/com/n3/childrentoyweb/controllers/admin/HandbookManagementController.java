package com.n3.childrentoyweb.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet( value = "/handbook-managements")
public class HandbookManagementController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.statisticHandbooks(req);
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


}
