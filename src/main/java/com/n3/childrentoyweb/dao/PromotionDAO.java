package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Promotion;

import java.util.Optional;

public class PromotionDAO  extends BaseDAO{

    public Optional<Promotion> findById(long id) {
        String sql = """
                Select p.*
                from promotions p
                where p.id = :id
                """;

        return super.getJdbi().withHandle(handle -> handle.createQuery(sql)
                .bind("id", 1)
                .mapToBean(Promotion.class)
                .findOne());
    }



}
