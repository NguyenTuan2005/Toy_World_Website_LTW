package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.PromotionNameDTO;
import com.n3.childrentoyweb.models.Promotion;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;

import java.util.List;
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
                            promotion.setActive(rs.getBoolean("is_active"));
                            return promotion;
                        })
                        .list()
        );
    }

    public Long save(Promotion p) {

        String sql = """
        insert into promotions
        (name, expired_at, discount_percent, discount_price, event_id, is_active)
        values
        (:name, :expiredAt, :discountPercent, :discountPrice, :eventId, :isActive)
        """;

        return this.getJdbi().withHandle(h ->
                h.createUpdate(sql)
                        .bind("name", p.getName())
                        .bind("expiredAt", p.getExpiredAt())
                        .bind("discountPercent", p.getDiscountPercent())
                        .bind("discountPrice", p.getDiscountPrice())
                        .bind("eventId", p.getEventId())
                        .bind("isActive", p.getActive())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Long.class)
                        .one()
        );
    }


    public void update(Promotion p) {

        String sql = """
        update promotions
        set name = :name,
            expired_at = :expiredAt,
            discount_percent = :discountPercent,
            discount_price = :discountPrice,
            event_id = :eventId,
            is_active = :isActive
        where id = :id
        """;

        this.getJdbi().useHandle(h ->
                h.createUpdate(sql)
                        .bind("id", p.getId())
                        .bind("name", p.getName())
                        .bind("expiredAt", p.getExpiredAt())
                        .bind("discountPercent", p.getDiscountPercent())
                        .bind("discountPrice", p.getDiscountPrice())
                        .bind("eventId", p.getEventId())
                        .bind("isActive", p.getActive())
                        .execute()
        );
    }

    public Promotion findById(Long id) {

        String sql = "select * from promotions where id = :id";

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            Promotion p = new Promotion();
                            p.setId(rs.getLong("id"));
                            p.setName(rs.getString("name"));
                            p.setExpiredAt(
                                    rs.getTimestamp("expired_at").toLocalDateTime()
                            );
                            p.setDiscountPercent(rs.getDouble("discount_percent"));
                            p.setDiscountPrice(rs.getDouble("discount_price"));
                            p.setEventId(rs.getLong("event_id"));
                            p.setActive(rs.getBoolean("is_active"));
                            p.setCreatedAt(
                                    rs.getTimestamp("created_at").toLocalDateTime()
                            );
                            return p;
                        })
                        .one()
        );
    }

    public List<Promotion> findPaging(int currentPage, int pageSize) {

        int offset = (currentPage - 1) * pageSize;

        String sql = """
        select * from promotions
        order by created_at desc
        limit :limit offset :offset
        """;

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .map((rs, ctx) -> {
                            Promotion p = new Promotion();
                            p.setId(rs.getLong("id"));
                            p.setName(rs.getString("name"));
                            p.setExpiredAt(
                                    rs.getTimestamp("expired_at").toLocalDateTime()
                            );
                            p.setDiscountPercent(rs.getDouble("discount_percent"));
                            p.setDiscountPrice(rs.getDouble("discount_price"));
                            p.setEventId(rs.getLong("event_id"));
                            p.setActive(rs.getBoolean("is_active"));
                            p.setCreatedAt(
                                    rs.getTimestamp("created_at").toLocalDateTime()
                            );
                            return p;
                        })
                        .list()
        );
    }

    public int countAll() {

        String sql = "select count(*) from promotions";

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public Promotion findValidPromotionById(Long promotionId) {
        String sql = """
                Select p.*
                from promotions p
                where p.id = :id
                and p.expired_at >= now()
                and p.is_active = 1
                """;

        return super.getJdbi().withHandle(handle -> handle.createQuery(sql)
                .bind("id", promotionId)
                .mapToBean(Promotion.class)
                .one());
    }

    public List<PromotionNameDTO> findAllPromotionName() {
        String sql = """
                select p.id, p.name
                from promotions p
                where p.is_active = 1
                and p.expired_at >= now()
                order by p.expired_at
                """;

        return this.getJdbi().withHandle(handle ->
                  handle.createQuery(sql)
                          .map((rs,ctx) -> {
                              PromotionNameDTO promotionNameDTO = new PromotionNameDTO();
                              promotionNameDTO.setId(rs.getInt("id"));
                              promotionNameDTO.setName(rs.getString("name"));
                              return promotionNameDTO;
                          })
                          .list()
                );
    }
}
