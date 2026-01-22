package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.dto.PriceRangeFilterDTO;
import com.n3.childrentoyweb.dto.ProductListDTO;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.*;
import com.n3.childrentoyweb.utils.AppContextPathHolder;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(value = "/products")
public class ProductListController extends HttpServlet {
    private static final int PAGE_SIZE = 18;
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
        AppContextPathHolder.setContextPath(request.getContextPath());
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        //category filter
        String[] categoryParams = request.getParameterValues("categoryId");

        List<Integer> categoryIds = null;
        if (categoryParams != null) {
            categoryIds = Arrays.stream(categoryParams)
                    .map(Integer::parseInt)
                    .toList();
        }

        //price filter
        String[] priceParams = request.getParameterValues("priceRange");

        List<PriceRangeFilterDTO> selectedPriceRanges = new ArrayList<>();

        if (priceParams != null) {
            for (String p : priceParams) {
                String[] parts = p.split(" - ");
                int min = Integer.parseInt(parts[0].trim());
                int max = Integer.parseInt(parts[1].trim());

                selectedPriceRanges.add(new PriceRangeFilterDTO(min, max, null));
            }
        }

        //brand filter
        String[] brandParams = request.getParameterValues("brandId");
        List<Integer> brandIds = null;
        if (brandParams != null) {
            brandIds = Arrays.stream(brandParams)
                    .map(Integer::parseInt)
                    .toList();
        }

        //sort
        String sortType = request.getParameter("sort");
        if (sortType == null) {
            sortType = "new";
        }


        //product
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        Long userId = (currentUser != null) ? currentUser.getId() : null;

        List<ProductListDTO> products = productService.findByFilter(userId, brandIds, categoryIds, selectedPriceRanges, sortType, page, PAGE_SIZE);

        //page
        int totalItems = productService.countByFilter(brandIds, categoryIds, selectedPriceRanges);
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

        request.setAttribute("products", products);
        request.setAttribute("brands", brandService.findBrandProductCount());
        request.setAttribute("categories", categoryService.findCategoryProductCount());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);

        //default price filter
        List<PriceRangeFilterDTO> priceRanges = List.of(
                new PriceRangeFilterDTO(0, 200000, "Dưới 200.000₫"),
                new PriceRangeFilterDTO(200000, 500000, "200.000₫ - 500.000₫"),
                new PriceRangeFilterDTO(500000, 1000000, "500.000₫ - 1.000.000₫"),
                new PriceRangeFilterDTO(1000000, 2000000, "1.000.000₫ - 2.000.000₫"),
                new PriceRangeFilterDTO(2000000, 3000000, "2.000.000₫ - 3.000.000₫"),
                new PriceRangeFilterDTO(3000000, 999999999, "Trên 3.000.000₫")
        );

        request.setAttribute("priceRanges", priceRanges);
        request.getRequestDispatcher("/product-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}