package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dao.PromotionDAO;
import com.n3.childrentoyweb.models.Promotion;

import java.util.Optional;
import java.util.List;

public class PromotionService {
    private PromotionDAO promotionDAO;

    public PromotionService() {
        this.promotionDAO = new PromotionDAO();
    }

    public Optional<Promotion> findById(Long promotionId) {
        if (promotionId == null) return Optional.empty();
        return Optional.ofNullable(this.promotionDAO.findById(promotionId));
    }

    public List<Promotion> findPromotionByEventId(long eventId) {
        return  this.promotionDAO.findPromotionsByEventId(eventId);
    }


    public Long save(Promotion promotion) {
        return promotionDAO.save(promotion);
    }


    public void updatePromotion(Promotion promotion) {
        promotionDAO.update(promotion);
    }

    public Optional<Promotion> getPromotionById(Long id) {
        return Optional.ofNullable( promotionDAO.findById(id));
    }

    public  Pagination<Promotion> findPromotionPaging(int currentPage, int pageSize) {
        List<Promotion> promotions = this.promotionDAO.findPaging(currentPage,pageSize);
        int totalElements = this.promotionDAO.countAll();
        int totalPages = totalElements / pageSize;
        return new Pagination<>(promotions,currentPage,totalElements,totalPages);
    }

    public int countAllPromotion() {
        return promotionDAO.countAll();
    }

    public  Pagination<Promotion> findPromotionPagingByName(int currentPage, int pageSize, String keyword) {
        List<Promotion> promotions = this.promotionDAO.findByName(keyword);
        int totalElements = this.promotionDAO.countAll();
        int totalPages = totalElements / pageSize;
        return new Pagination<>(promotions,currentPage,totalElements,totalPages);
    }

}
