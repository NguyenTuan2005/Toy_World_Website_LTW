package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.PromotionDAO;
import com.n3.childrentoyweb.models.Promotion;

import java.util.Optional;

public class PromotionService {
    private PromotionDAO promotionDAO;

    public PromotionService() {
        this.promotionDAO = new PromotionDAO();
    }

    public Optional<Promotion> findById(Long promotionId) {
        if (promotionId == null) return Optional.empty();
        return this.promotionDAO.findById(promotionId);
    }
}
