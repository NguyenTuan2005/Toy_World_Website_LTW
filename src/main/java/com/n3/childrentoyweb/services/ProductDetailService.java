package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.ProductAssetDAO;
import com.n3.childrentoyweb.dao.ProductDAO;
import com.n3.childrentoyweb.dao.UserCommentDAO;
import com.n3.childrentoyweb.dao.WishListDAO;
import com.n3.childrentoyweb.dto.ProductDetailDTO;
import com.n3.childrentoyweb.dto.ProductListDTO;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.models.WishList;
import com.n3.childrentoyweb.utils.AppContextPathHolder;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

public class ProductDetailService {
    private ProductDAO productDAO;
    private ProductAssetDAO productAssetDAO;
    private UserCommentDAO userCommentDAO;
    private WishListDAO wishListDAO;
    private static final int RELATED_PRODUCT_LIMIT = 8;


    public ProductDetailService() {
        this.productDAO = new ProductDAO();
        this.productAssetDAO = new ProductAssetDAO();
        this.userCommentDAO = new UserCommentDAO();
        this.wishListDAO = new WishListDAO();
    }

    public ProductDetailDTO findProductDetailById(User currentUser, Long productId) {
        ProductDetailDTO product = productDAO.findDetailById(productId)
                .orElseThrow(() -> new NoSuchElementException(
                        "Product not found with id = " + productId));

        if (product.getPromotionId() != null && product.getDiscountPercent() > 0) {
            double finalPrice = calculateFinalPrice(
                    product.getOriginalPrice(),
                    product.getDiscountPercent(),
                    product.getMaxDiscountPrice()
            );
            product.setDiscountPrice(finalPrice);
        }

        product.setImagePaths(productAssetDAO.findImagePathByProductId(productId));

        if(product.getImagePaths() == null || product.getImagePaths().isEmpty()){
            product.setImagePaths(new ArrayList<>(List.of(AppContextPathHolder.getContextPath() + "/img/default-product-img.png")));
        }



        if(currentUser != null){
            WishList wishList = new WishList(currentUser.getId(), productId);
            boolean wishListStatus = wishListDAO.exists(wishList);
            product.setWishlisted(wishListStatus);
        }


        product.setComments(userCommentDAO.findByProductId(productId));

        return product;
    }

    public List<ProductListDTO> findRelatedProduct(User currentUser, Long productId){
        Product current = productDAO.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        List<ProductListDTO> relatedProducts = new ArrayList<>();

        relatedProducts.addAll(productDAO.findRelatedByCategoryAndBrand(
                current.getCategoryId(),
                current.getBrandId(),
                current.getId(),
                RELATED_PRODUCT_LIMIT)
        );

        if (relatedProducts.size() < RELATED_PRODUCT_LIMIT) {
            int remain = RELATED_PRODUCT_LIMIT - relatedProducts.size();

            List<Long> excludeIds = relatedProducts.stream()
                    .map(ProductListDTO::getId)
                    .toList();

            excludeIds = new ArrayList<>(excludeIds);
            excludeIds.add(productId);

            List<ProductListDTO> more =
                    productDAO.findRelatedByCategory(
                            current.getCategoryId(),
                            excludeIds,
                            remain
                    );

            relatedProducts.addAll(more);
        }



        List<Long> wishlistProductIds = new ArrayList<>();
        if(currentUser != null)
            wishlistProductIds.addAll(wishListDAO.findAllProductIdByUserId(currentUser.getId()));

        for (ProductListDTO p : relatedProducts) {
            double finalPrice = calculateFinalPrice(
                    p.getOriginPrice(),
                    p.getDiscountPercent(),
                    p.getMaxDiscountPrice()
            );

            p.setFinalPrice(finalPrice);

            if (wishlistProductIds.contains(p.getId())) {
                p.setWishlisted(true);
            }
        }

        return relatedProducts;
    }


    private double calculateFinalPrice(double originalPrice, double discountPercent, Double maxDiscountPrice) {
        if (originalPrice <= 0) return 0;

        if (discountPercent < 0) discountPercent = 0;
        if (discountPercent > 100) discountPercent = 100.0;

        double discountAmount = originalPrice * discountPercent / 100;

        if (maxDiscountPrice != null) {
            discountAmount = Math.min(discountAmount, maxDiscountPrice);
        }

        double finalPrice = originalPrice - discountAmount;
        return Math.max(finalPrice, 0);
    }

}
