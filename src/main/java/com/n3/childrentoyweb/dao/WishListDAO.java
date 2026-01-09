package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.WishList;

public class WishListDAO extends BaseDAO {

    public void save(WishList wishList) {
        String sql = """
                    INSERT INTO wish_lists (is_active, user_id, product_id, created_at)
                    VALUES (:isActive, :userId, :productId, :createdAt)
                    """;
        this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
            .bind("isActive", wishList.getActive())
            .bind("userId", wishList.getUserId())
            .bind("productId", wishList.getProductId())
            .bind("createdAt", wishList.getCreatedAt())
            .execute()
        );
    }

    public boolean exists(WishList wishList) {
        String sql = """
                    SELECT 1
                    FROM wish_lists
                    WHERE user_id = :userId AND product_id = :productId AND is_active = :isActive
                    """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", wishList.getUserId())
                        .bind("productId", wishList.getProductId())
                        .bind("isActive", wishList.getActive())
                        .mapTo(Integer.class)
                        .findFirst()
                        .isPresent()
        );
    }

}
