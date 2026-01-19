package com.n3.childrentoyweb.controllers.admin.products;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.ProductManagementDTO;
import com.n3.childrentoyweb.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "products", value = "/admin/products")
public class ProductController extends HttpServlet {
    private static final int PAGE_SIZE = 10;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        this.productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
        Pagination<ProductManagementDTO> products = productService.findAllProductsForManagement(page, PAGE_SIZE);

        req.setAttribute("products", products.getData());
        req.setAttribute("currentPage", products.getCurrentPage());
        req.setAttribute("totalProduct", products.getTotalElements());
        req.setAttribute("totalPages", products.getTotalPages());
        req.getRequestDispatcher("/adminPages/products.jsp").forward(req, resp);
    }
}
