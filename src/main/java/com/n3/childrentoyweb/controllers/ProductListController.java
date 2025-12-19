package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.models.Category;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.models.ProductAsset;
import com.n3.childrentoyweb.services.CategoryService;
import com.n3.childrentoyweb.services.ProductAssetService;
import com.n3.childrentoyweb.services.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "ProductListController", value = "/products")
public class ProductListController extends HttpServlet {
    private static final int PAGE_SIZE = 9;
    private ProductService productService;
    private CategoryService categoryService;
    private ProductAssetService productAssetService;

    @Override
    public void init() {
        productService = new ProductService();
        categoryService = new CategoryService();
        productAssetService = new ProductAssetService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        if(request.getParameter("page") != null){
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<Product> products = productService.findAllByPage(page, PAGE_SIZE);
        List<Category> categories = categoryService.findAll();
        List<ProductAsset> productAssets = productAssetService.findAll();

        Map<Long, String> categoryMap = categories.stream().collect(Collectors.toMap(Category::getId, Category::getName));
        Map<Long, List<String>> productAssetMap = productAssets.stream().collect(
                Collectors.groupingBy(ProductAsset::getProductId,
                        Collectors.mapping(ProductAsset::getImgPath, Collectors.toList())));

        int totalItems = productService.countAll();
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

        request.setAttribute("products", products);
        request.setAttribute("categoryMap", categoryMap);
        request.setAttribute("productAssetMap", productAssetMap);

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/product-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}