package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.*;
import com.n3.childrentoyweb.dto.*;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.models.WishList;
import com.n3.childrentoyweb.utils.AppContextPathHolder;

import java.util.*;
import java.util.stream.Collectors;

public class ProductService {
    private ProductDAO productDAO;
    private ProductAssetDAO productAssetDAO;
    private UserCommentDAO userCommentDAO;
    private WishListDAO wishListDAO;
    private static final int FIRST_PAGE = 1;

    public ProductService() {
        this.productDAO = new ProductDAO();
        this.productAssetDAO = new ProductAssetDAO();
        this.userCommentDAO = new UserCommentDAO();
        this.wishListDAO = new WishListDAO();
    }

    public List<ProductListDTO> findAll() {
        return productDAO.findAll();
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

    public ProductDetailDTO findProductDetailById(User currentUser, Long productId) {
        ProductDetailDTO product = productDAO.findDetailById(productId)
                .orElseThrow(() -> new NoSuchElementException(
                        "Product not found with id = " + productId));

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

        product.setImagePaths(productAssetDAO.findImagePathByProductId(productId));

        if(product.getImagePaths() == null || product.getImagePaths().isEmpty()){
            product.setImagePaths(new ArrayList<>(List.of(AppContextPathHolder.getContextPath() + "/img/default-product-img.png")));
        }

        //wishlist
        if(currentUser != null){
            WishList wishList = new WishList(currentUser.getId(), productId);
            boolean wishListStatus = wishListDAO.exists(wishList);
            product.setWishlisted(wishListStatus);
        }
        
        //comment
        product.setComments(userCommentDAO.findByProductId(productId));

        return product;
    }

    public long countProductInMonth(int year, int month) {
        return productDAO.countProductInMonth(year, month);
    }


    public List<ProductPromotionDTO> findProductsByPromotionId(Long promotionId) {
        return this.productDAO.findProductsByPromotionId(promotionId);
    }

    public List<ProductListDTO> findByFilter(Long currentUserId, List<Integer> brandIds, List<Integer> categoryIds, List<PriceRangeFilterDTO> priceRanges, String sortType, int page, int pageSize) {

        int offset = (page - 1) * pageSize;

        List<ProductListDTO> products = productDAO.findByFilter(brandIds, categoryIds, priceRanges, sortType, pageSize, offset);

        List<Long> wishlistProductIds = wishListDAO.findAllProductIdByUserId(currentUserId);

        products.forEach(p -> {
            p.setWishlisted(wishlistProductIds.contains(p.getId()));
            if(p.getImgPath() == null || p.getImgPath().trim().isEmpty()){
                p.setImgPath(AppContextPathHolder.getContextPath() + "/img/default-product-img.png");
            }
        });

        return products;
    }


    public int countByFilter(List<Integer> brandIds, List<Integer> categoryIds, List<PriceRangeFilterDTO> priceRanges) {
        return productDAO.countByFilter(brandIds, categoryIds, priceRanges);
    }

    public List<ProductListDTO> findRelatedProduct(User currentUser, Long productId, int limit){
        Product current = productDAO.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        List<ProductListDTO> result = new ArrayList<>();

        result.addAll(productDAO.findRelatedByCategoryAndBrand(
                        current.getCategoryId(),
                        current.getBrandId(),
                        current.getId(),
                        limit)
        );

//        if (result.size() < limit) {
//            int remain = limit - result.size();
//
//            List<Product> more = productDAO.findByCategory(
//                    current.getCategoryId(),
//                    current.getId(),
//                    remain
//            );
//
//            Set<Long> existedIds = result.stream()
//                    .map(Product::getId)
//                    .collect(Collectors.toSet());
//
//            more.stream().filter(p -> !existedIds.contains(p.getId())).forEach(result::add);
//        }

        List<Long> wishlistProductIds = new ArrayList<>();
        if(currentUser != null)
            wishlistProductIds.addAll(wishListDAO.findAllProductIdByUserId(currentUser.getId()));

        for (ProductListDTO p : result) {
            long originPrice = p.getOriginPrice();
            long maxDiscountPrice = p.getMaxDiscountPrice();
            double discountPercent = p.getDiscountPercent();

            if (originPrice <= 0) continue;
            if (discountPercent < 0) discountPercent = 0;
            if (discountPercent > 100) discountPercent = 100;

            long discountByPercent = Math.round(originPrice * discountPercent / 100);
            long finalDiscount = Math.min(discountByPercent, maxDiscountPrice);
            p.setFinalPrice(originPrice - finalDiscount);

            if(wishlistProductIds.contains(p.getId())){
                p.setWishlisted(true);
            }
        }

        return result;
    }

}
