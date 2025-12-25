package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.WishList;

public class WishListDAO extends BaseDAO {

    public void save(WishList wishList) {
        String sql = """
                    INSERT INTO wish_list (is_active, user_id, product_id, created_at)
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


}
