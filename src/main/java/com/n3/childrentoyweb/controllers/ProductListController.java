package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.dto.ProductListDTO;
import com.n3.childrentoyweb.services.BrandService;
import com.n3.childrentoyweb.services.CategoryService;
import com.n3.childrentoyweb.services.ProductAssetService;
import com.n3.childrentoyweb.services.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(value = "/products")
public class ProductListController extends HttpServlet {
    private static final int PAGE_SIZE = 9;
    private ProductService productService;
    private CategoryService categoryService;
    private BrandService brandService;
    private ProductAssetService productAssetService;

    @Override
    public void init() {
        productService = new ProductService();
        categoryService = new CategoryService();
        brandService = new BrandService();
        productAssetService = new ProductAssetService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        String[] brandIdsParam = request.getParameterValues("brandId");
        List<Integer> brandIds;

        if (brandIdsParam != null) {
            brandIds = Arrays.stream(brandIdsParam)
                    .map(Integer::parseInt)
                    .toList();

            session.setAttribute("selectedBrandIds", brandIds);
            page = 1;
        } else {
            brandIds = (List<Integer>) session.getAttribute("selectedBrandIds");
        }


        List<ProductListDTO> products = productService.findByFilter(brandIds, page, PAGE_SIZE);

        int totalItems = productService.countByFilter(brandIds);

        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

        // 6. Data chung
        request.setAttribute("products", products);
        request.setAttribute("brands", brandService.findAll());
        request.setAttribute("categories", categoryService.findAll());

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/product-list.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}