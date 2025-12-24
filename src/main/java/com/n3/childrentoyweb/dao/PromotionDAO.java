package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Promotion;

import java.util.Optional;

public class PromotionDAO  extends BaseDAO{

    public Optional<Promotion> findById(int id) {
        return super.getJdbi().withHandle(handle -> handle.createQuery("""
                Select p.*
                from Promotion p
                where p.id = :id
                """))
                .bind("id", 1)
                .mapToBean(Promotion.class)
                .findOne();
    }
}
