package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.dao.BannerDAO;
import com.n3.childrentoyweb.dto.ProductPromotionDTO;
import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;
import com.n3.childrentoyweb.models.Promotion;
import com.n3.childrentoyweb.services.BannerService;
import com.n3.childrentoyweb.services.ProductService;
import com.n3.childrentoyweb.services.PromotionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet(name = "promotions", value = "/promotion")
public class PromotionController extends HttpServlet {

    private String DEFAULT_BANNER_PROMOTION="https://www.mykingdom.com.vn/cdn/shop/files/1._1280x496_124de139-e6a1-496a-aac8-f4f9030fbd79.webp?v=1767199490&width=1200";
    private BannerService bannerService;
    private ProductService productService;
    private PromotionService promotionService;

    public void init(){
        bannerService = new BannerService();
        productService = new ProductService();
        promotionService = new PromotionService();
    }

    private static final Logger log =
            Logger.getLogger(PromotionController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        this.addProductsPromotion(request);
        request.getRequestDispatcher("promotion.jsp").forward(request, response);

    }

    private void addProductsPromotion(HttpServletRequest request){
        Banner banner = this.bannerService.findBannerForCurrentPromotion().orElse(new Banner(DEFAULT_BANNER_PROMOTION));
        request.setAttribute("banner",banner.getImgPath());

        List<Promotion>  promotions = this.promotionService.findPromotionByEventId(banner.getEventId());
        System.out.println("Promotion size: "+promotions.size());
        Map<Promotion,List<ProductPromotionDTO>> data = new HashMap<>();
        for (int i = 0; i < promotions.size(); i++) {
            Promotion promotion = promotions.get(i);
            System.out.println(promotion);
            List<ProductPromotionDTO> productPromotionDTOS = this.productService
                    .findProductsByPromotionId(promotions.get(i).getId())
                    .stream().map(productPromotionDTO -> {

                        boolean isDiscountedByDiscountPrice = (promotion.getDiscountPrice() != null &&  promotion.getDiscountPrice() >0.0);

                        if(isDiscountedByDiscountPrice){
                            double promotionDiscountPrice = promotion.getDiscountPrice();
                            double originalPrice = productPromotionDTO.getOriginalPrice();

                            boolean isDiscountPriceGreaterThanZero =originalPrice > promotionDiscountPrice;

                            if(isDiscountPriceGreaterThanZero){
                                productPromotionDTO.setDiscountPrice(originalPrice);
                                return productPromotionDTO;
                            } else {
                                productPromotionDTO.setDiscountPrice(originalPrice -promotionDiscountPrice);
                                return productPromotionDTO;
                            }

                        }

                        boolean isDiscountedByDiscountPercent = (promotion.getDiscountPercent() != null && promotion.getDiscountPercent() > 0.0);

                        if(isDiscountedByDiscountPercent){
                            double promotionDiscountPercent = promotion.getDiscountPercent();
                            double discountPrice = productPromotionDTO.getOriginalPrice() - (promotionDiscountPercent*productPromotionDTO.getOriginalPrice()/ 100);

                            boolean isDiscountPriceGreaterThanZero =discountPrice >0;

                            if(isDiscountPriceGreaterThanZero){
                                productPromotionDTO.setDiscountPrice(discountPrice);
                                return productPromotionDTO;
                            }else {
                                productPromotionDTO.setDiscountPrice(productPromotionDTO.getOriginalPrice());
                                return productPromotionDTO;
                            }
                        }
                        return productPromotionDTO;

                    })
                    .toList();
            data.put(promotions.get(i),productPromotionDTOS);
        }

        request.setAttribute("promotions",data);
    }

}
