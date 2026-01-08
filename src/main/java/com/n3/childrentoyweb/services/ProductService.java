package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.ApplicationProperties;
import com.n3.childrentoyweb.dao.ProductAssetDAO;
import com.n3.childrentoyweb.dao.ProductDAO;
import com.n3.childrentoyweb.dao.UserCommentDAO;
import com.n3.childrentoyweb.dto.HomeProductDTO;
import com.n3.childrentoyweb.dto.ProductDetailDTO;
import com.n3.childrentoyweb.dto.ProductListDTO;
import com.n3.childrentoyweb.dto.ProductPromotionDTO;
import com.n3.childrentoyweb.models.Product;

import java.util.ArrayList;
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
    public Optional<Product> findById(Long id ){
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

    public long countProductInMonth(int year, int month){
        return productDAO.countProductInMonth(year, month);
    }

//    public List<Product> findProductsWithAvailablePromotion(){
//        return this.productDAO. findProductsWithAvailablePromotion();
//    }

    public List<ProductPromotionDTO> findProductsByPromotionId(Long promotionId) {
        return this.productDAO.findProductsByPromotionId(promotionId);
    }

    public List<ProductListDTO> findByFilter(List<Integer> brandIds, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        List<ProductListDTO> products;

        if (brandIds == null || brandIds.isEmpty()) {
            products = productDAO.findAllByPage(page, pageSize);
        } else {
            products = productDAO.findByFilter(brandIds, pageSize, offset);
        }

        for (ProductListDTO p : products) {
            long originPrice = p.getOriginPrice();
            long maxDiscountPrice = p.getMaxDiscountPrice();
            double discountPercent = p.getDiscountPercent();

            long discountPrice = (long) (originPrice * discountPercent/100);

            if(discountPrice > maxDiscountPrice){
                p.setFinalPrice( originPrice - maxDiscountPrice);
            }else{
                p.setFinalPrice(originPrice - discountPrice);
            }
        }
        return products;
    }


    public int countByFilter(List<Integer> brandIds) {
        return productDAO.countByFilter(brandIds);
    }

    public static void main(String[] args) {
        System.out.println(new ProductService().findAllByPage(1,10));
    }


}
