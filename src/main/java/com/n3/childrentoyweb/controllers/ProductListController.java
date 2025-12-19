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
        List<Product> products = productService.findAll();
        List<Category> categories = categoryService.findAll();
        List<ProductAsset> productAssets = productAssetService.findAll();

        Map<Long, String> categoryMap = categories.stream().collect(Collectors.toMap(Category::getId, Category::getName));
        Map<Long, List<String>> productAssetMap = productAssets.stream().collect(
                Collectors.groupingBy(ProductAsset::getProductId,
                        Collectors.mapping(ProductAsset::getImgPath, Collectors.toList())));


        request.setAttribute("products", products);
        request.setAttribute("categoryMap", categoryMap);
        request.setAttribute("productAssetMap", productAssetMap);
        request.getRequestDispatcher("/product-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}