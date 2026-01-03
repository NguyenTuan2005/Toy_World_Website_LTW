package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.dto.ProductDetailDTO;
import com.n3.childrentoyweb.services.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.NoSuchElementException;

@WebServlet(value = "/products/*")
public class ProductDetailsController extends HttpServlet {
    private ProductService productService;

    public void init() {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String pathInfo = request.getPathInfo();

            if (pathInfo == null || pathInfo.equals("/")) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            long id;
            try {
                id = Long.parseLong(pathInfo.substring(1));
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }


            ProductDetailDTO product = productService.findProductDetailById(id);

            request.setAttribute("product", product);
            request.getRequestDispatcher("/product-detail.jsp").forward(request, response);

        } catch (NoSuchElementException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}