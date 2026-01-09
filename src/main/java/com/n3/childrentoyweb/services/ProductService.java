package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.ApplicationProperties;
import com.n3.childrentoyweb.dao.ProductAssetDAO;
import com.n3.childrentoyweb.dao.ProductDAO;
import com.n3.childrentoyweb.dao.UserCommentDAO;
import com.n3.childrentoyweb.dto.*;
import com.n3.childrentoyweb.models.Product;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

public class ProductService {
    private ProductDAO productDAO;
    private ProductAssetDAO productAssetDAO;
    private UserCommentDAO userCommentDAO;
    private static final int FIRST_PAGE = 1;

    public ProductService() {
        this.productDAO = new ProductDAO();
        this.productAssetDAO = new ProductAssetDAO();
        this.userCommentDAO = new UserCommentDAO();
    }

    public List<ProductListDTO> findAll() {
        return productDAO.findAll();
    }

    public List<ProductListDTO> findAllByPage(int page, int pageSize) {
        return productDAO.findAllByPage(page, pageSize);
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

    public ProductDetailDTO findProductDetailById(Long id) {
        ProductDetailDTO product = productDAO.findDetailById(id)
                .orElseThrow(() -> new NoSuchElementException(
                        "Product not found with id = " + id));

        if (product.getPromotionId() != null) {
            double originalPrice = product.getOriginalPrice();
            double discountPercent = product.getDiscountPercent();
            Double maxDiscountPrice = product.getMaxDiscountPrice();

            double discountAmount = originalPrice * discountPercent / 100;


            if (maxDiscountPrice != null && discountAmount > maxDiscountPrice) {
                discountAmount = maxDiscountPrice;
            }


            double discountPrice = originalPrice - discountAmount;


            if (discountPrice < 0) {
                discountPrice = 0;
            }

            product.setDiscountPrice(discountPrice);
        }

        product.setImagePaths(productAssetDAO.findImagePathByProductId(id));

        product.setComments(userCommentDAO.findByProductId(id));


        return product;
    }

    public long countProductInMonth(int year, int month) {
        return productDAO.countProductInMonth(year, month);
    }

//    public List<Product> findProductsWithAvailablePromotion(){
//        return this.productDAO. findProductsWithAvailablePromotion();
//    }

    public List<ProductPromotionDTO> findProductsByPromotionId(Long promotionId) {
        return this.productDAO.findProductsByPromotionId(promotionId);
    }

    public List<ProductListDTO> findByFilter(List<Integer> brandIds, List<Integer> categoryIds, List<PriceRangeFilterDTO> priceRanges, int page, int pageSize) {

        int offset = (page - 1) * pageSize;
        List<ProductListDTO> products = productDAO.findByFilter(brandIds, categoryIds, priceRanges, pageSize, offset);


        for (ProductListDTO p : products) {
            long originPrice = p.getOriginPrice();
            long maxDiscountPrice = p.getMaxDiscountPrice();
            double discountPercent = p.getDiscountPercent();

            if (originPrice <= 0) continue;
            if (discountPercent < 0) discountPercent = 0;
            if (discountPercent > 100) discountPercent = 100;

            long discountByPercent = Math.round(originPrice * discountPercent / 100);
            long finalDiscount = Math.min(discountByPercent, maxDiscountPrice);
            p.setFinalPrice(originPrice - finalDiscount);
        }
        return products;
    }


    public int countByFilter(List<Integer> brandIds) {
        return productDAO.countByFilter(brandIds);
    }

    public static void main(String[] args) {
        System.out.println(new ProductService().findByFilter(List.of(), List.of(),
                List.of(  new PriceRangeFilterDTO(1000000, 2000000, "1.000.000₫ - 2.000.000₫")), 1, 10));
    }


}
