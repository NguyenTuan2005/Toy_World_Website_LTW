package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.*;
import com.n3.childrentoyweb.dto.*;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.utils.AppContextPathHolder;
import java.util.*;


public class ProductService {
    private ProductDAO productDAO;
    private ProductAssetDAO productAssetDAO;
    private WishListDAO wishListDAO;
    private static final int FIRST_PAGE = 1;

    public ProductService() {
        this.productDAO = new ProductDAO();
        this.productAssetDAO = new ProductAssetDAO();
        this.wishListDAO = new WishListDAO();
    }

    public List<ProductListDTO> findAll() {
        return productDAO.findAll();
    }

    public Pagination<ProductManagementDTO> findAllProductsForManagement(int page, int pageSize) {
        List<ProductManagementDTO> products= productDAO.findAllProductsForManagement(page, pageSize);
        int totalElement = productDAO.countAll();
        int totalPages = totalElement / pageSize;
        boolean hasLeftover = totalElement > totalPages * pageSize;

        return new Pagination<>(products, page, totalElement, totalPages + (hasLeftover ? 1 : 0));
    }

    public int countAll() {
        return this.productDAO.countAll();
    }

    public List<HomeProductDTO> findNewImportProductsInMonth() {
        return this.productDAO.findNewImportProductsInMonth(FIRST_PAGE, ApplicationProperties.DISPLAY_PRODUCT_SIZE);
    }

    public List<HomeProductDTO> findSignatureProduct() {
        return this.productDAO.findSignatureProduct(FIRST_PAGE, ApplicationProperties.DISPLAY_PRODUCT_SIZE, ApplicationProperties.SIGNATURE_BRAND_NAME);
    }

    public Optional<Product> findById(Long id) {
        return this.productDAO.findById(id);
    }


    public long countProductInMonth(int year, int month) {
        return productDAO.countProductInMonth(year, month);
    }


    public List<ProductPromotionDTO> findProductsByPromotionId(Long promotionId) {
        return this.productDAO.findProductsByPromotionId(promotionId);
    }

    public List<ProductListDTO> findByFilter(Long currentUserId, String keyword, List<Integer> brandIds, List<Integer> categoryIds, List<PriceRangeFilterDTO> priceRanges, String sortType, int page, int pageSize) {

        int offset = (page - 1) * pageSize;

        List<ProductListDTO> products = productDAO.findByFilter(keyword, brandIds, categoryIds, priceRanges, sortType, pageSize, offset);

        List<Long> wishlistProductIds = wishListDAO.findAllProductIdByUserId(currentUserId);

        products.forEach(p -> {
            p.setWishlisted(wishlistProductIds.contains(p.getId()));

            if(p.getImgPath() == null || p.getImgPath().trim().isEmpty()){
                p.setImgPath(AppContextPathHolder.getContextPath() + "/img/default-product-img.png");
            }
        });

        return products;
    }


    public int countByFilter(String keyword, List<Integer> brandIds, List<Integer> categoryIds, List<PriceRangeFilterDTO> priceRanges) {
        return productDAO.countByFilter(keyword, brandIds, categoryIds, priceRanges);
    }

    public Pagination<ProductManagementDTO> findByCriteria(ProductCriteria productCriteria) {
        List<ProductManagementDTO> products = productDAO.findByCriteria(productCriteria);
        return new Pagination<>(products, 1, products.size(), 1);
    }

    public long save(Product product) {
        return this.productDAO.save(product);
    }

    public Product findProductForManagementById(long productId) {
        return this.productDAO.findProductForManagementById(productId);
    }

    public void update(Product product) {
        this.productDAO.update(product);
    }
}
