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
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

@WebServlet(name = "editProduct", value = "/admin/edit-products")
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class EditProductController extends HttpServlet {
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
        long productId = Long.parseLong(req.getParameter("id"));
        Product product = productService.findProductForManagementById(productId);
        List<ProductAsset> assets = productAssetService.findAllByProductId(productId);

        List<PromotionNameDTO> promotions = promotionService.findAllPromotionName();
        List<Brand> brands = brandService.findAll();
        List<Category> categories = categoryService.findAll();

        req.setAttribute("product", product);
        req.setAttribute("assets", assets);
        req.setAttribute("promotions", promotions);
        req.setAttribute("brands", brands);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/adminPages/edit-products.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            Product product = initProduct(req);
            productService.update(product);

            String deletedImagesParam = req.getParameter("deletedImages");
            if (deletedImagesParam != null && !deletedImagesParam.isBlank()) {
                long[] deletedImageIds = Arrays.stream(deletedImagesParam.split(",")).mapToLong(s -> Long.parseLong(s.trim())).toArray();
                productAssetService.deleteAllById(deletedImageIds);
            }

            List<ProductAsset> assets = initProductAssets(req, product.getId());
            this.productAssetService.saveAll(assets);

            resp.getWriter().write("{\"success\": true, \"message\": \"Cập nhật sản phẩm thành công!\"}");

        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(e.getMessage());
        }
    }

    private List<ProductAsset> initProductAssets(HttpServletRequest req, long productId) throws ServletException, IOException {
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
        long id = Integer.parseInt(req.getParameter("id"));
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
            throw new IllegalArgumentException("Tên không hợp lệ");
        }

        Product product = new Product();
        product.setId(id);
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
