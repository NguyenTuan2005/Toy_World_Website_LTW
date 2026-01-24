package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.dto.ProductDetailDTO;
import com.n3.childrentoyweb.dto.ProductListDTO;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.ProductService;
import com.n3.childrentoyweb.utils.AppContextPathHolder;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.NoSuchElementException;

@WebServlet(value = "/products/*")
public class ProductDetailsController extends HttpServlet {
    private ProductService productService;

    public void init() {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AppContextPathHolder.setContextPath(request.getContextPath());
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

            User currentUser = (User) request.getSession().getAttribute("currentUser");

            ProductDetailDTO product = productService.findProductDetailById(currentUser, id);

            List<ProductListDTO> relatedProducts = productService.findRelatedProduct(currentUser, id, 8);

            request.setAttribute("product", product);
            request.setAttribute("relatedProducts", relatedProducts);

            request.getRequestDispatcher("/product-detail.jsp").forward(request, response);

        } catch (NoSuchElementException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}