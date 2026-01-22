package com.n3.childrentoyweb.controllers.admin.products;

import com.n3.childrentoyweb.dto.PromotionNameDTO;
import com.n3.childrentoyweb.models.Brand;
import com.n3.childrentoyweb.models.Category;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.models.ProductAsset;
import com.n3.childrentoyweb.services.*;
import com.n3.childrentoyweb.utils.JsonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet(name = "newProduct", value = "/admin/new-products")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class NewProductController extends HttpServlet {
    private PromotionService promotionService;
    private BrandService brandService;
    private CategoryService categoryService;
    private CloudinaryService cloudinaryService;
    private ProductService productService;
    private ProductAssetService productAssetService;

    @Override
    public void init() throws ServletException {
        this.promotionService = new PromotionService();
        this.brandService = new BrandService();
        this.categoryService = new CategoryService();
        this.cloudinaryService = new CloudinaryService();
        this.productService = new ProductService();
        this.productAssetService = new ProductAssetService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<PromotionNameDTO> promotions = promotionService.findAllPromotionName();
        List<Brand> brands = brandService.findAll();
        List<Category> categories = categoryService.findAll();

        req.setAttribute("promotions", promotions);
        req.setAttribute("brands", brands);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/adminPages/new-products.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            Product product = initProduct(req);

            long productId = productService.save(product);

            List<ProductAsset> assets = initProductAsset(req,  productId);
            this.productAssetService.saveAll(assets);

            resp.getWriter().write("{\"success\": true, \"message\": \"Thêm sản phẩm thành công!\"}");
        } catch (IllegalArgumentException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"success\": false, \"message\": \"Dữ liệu không hợp lệ!\"}");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }

    private List<ProductAsset> initProductAsset(HttpServletRequest req, long productId) throws ServletException, IOException {
        Collection<Part> fileParts = req.getParts();
        List<ProductAsset> assets = new ArrayList<>();
        ProductAsset productAsset;
        for (Part part : fileParts) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String fileName = cloudinaryService.upload(part);
                productAsset = new ProductAsset(fileName, productId);
                assets.add(productAsset);
            }
        }
        return assets;
    }

    private Product initProduct(HttpServletRequest req) throws IllegalArgumentException {
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String restInfo = req.getParameter("restInfo");
        String description = !req.getParameter("description").isBlank() ? req.getParameter("description") : null ;
        Long promotionId = !req.getParameter("promotionId").isEmpty() ? Long.parseLong(req.getParameter("promotionId")) : null;
        long brandId = Long.parseLong(req.getParameter("brandId"));
        long categoryId = Long.parseLong(req.getParameter("categoryId"));
        boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));

        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException();
        }

        Product product = new Product();
        product.setName(name);
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setRestInfo(JsonUtil.parseProductRestInfo(restInfo));
        product.setDescription(description);
        product.setPromotionId(promotionId);
        product.setBrandId(brandId);
        product.setCategoryId(categoryId);
        product.setActive(isActive);
        return product;
    }
}
