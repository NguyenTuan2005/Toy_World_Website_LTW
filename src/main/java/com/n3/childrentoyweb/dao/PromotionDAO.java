package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Promotion;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;

import java.util.List;
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

    public List<Promotion> findPromotionsByEventId(long eventId) {
        String sql = """
        select * 
        from promotions 
        where event_id = :eventId 
        and is_active = 1 
        and  expired_at > now();
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("eventId", eventId)
                        .map((rs, ctx) -> {
                            Promotion promotion = new Promotion();
                            promotion.setId(rs.getLong("id"));
                            promotion.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                            promotion.setName(rs.getString("name"));
                            promotion.setEventId(rs.getLong("event_id"));
                            promotion.setExpiredAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("expired_at")));
                            promotion.setDiscountPercent(rs.getDouble("discount_percent"));
                            promotion.setDiscountPrice(rs.getDouble("discount_price"));
                            return promotion;
                        })
                        .list()
        );
    }

    public static void main(String[] args) {
        System.out.println(new PromotionDAO().findPromotionsByEventId(10));
    }



}
