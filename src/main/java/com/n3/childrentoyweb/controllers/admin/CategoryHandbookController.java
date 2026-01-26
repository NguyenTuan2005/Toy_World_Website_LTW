package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.models.CategoryHb;
import com.n3.childrentoyweb.services.CategoryHbService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="categoryHandbook", value = "/admin/category-handbooks")
public class CategoryHandbookController extends HttpServlet {
    private CategoryHbService categoryHbService;

    @Override
    public void init() throws ServletException {
        this.categoryHbService = new CategoryHbService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String categoryName = req.getParameter("categoryName");
        try {
            if (categoryName == null)
                throw new DataInvalidException("Category name is null");

            CategoryHb categoryHb = new CategoryHb(categoryName);
            if (this.categoryHbService.isExist(categoryHb))
                throw new DataInvalidException("Tên danh mục này đã tồn tại");

            long id = this.categoryHbService.save(categoryHb);

            resp.getWriter().write("{\"success\": true, \"id\": \"" + id + "\"}");
        } catch (DataInvalidException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write(e.getMessage());
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(e.getMessage());
        }

    }
}
