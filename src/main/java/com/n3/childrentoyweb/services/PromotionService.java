package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.PromotionDAO;
import com.n3.childrentoyweb.models.Promotion;

import java.util.List;

public class PromotionService {
    private PromotionDAO promotionDAO;

    public PromotionService() {
        this.promotionDAO = new PromotionDAO();
    }

    public List<Promotion> findPromotionByEventId(long eventId) {
        return  this.promotionDAO.findPromotionsByEventId(eventId);
    }
}
