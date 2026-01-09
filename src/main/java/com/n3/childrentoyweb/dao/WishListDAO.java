package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.WishList;
import java.util.Optional;
import java.util.List;

public class WishListDAO extends BaseDAO {

    public void save(WishList wishList) {
        String sql = """
                INSERT INTO wish_lists (user_id, product_id)
                VALUES (:userId, :productId)
                """;
        this.getJdbi().useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("userId", wishList.getUserId())
                        .bind("productId", wishList.getProductId())
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

    public void update(WishList w) {
        String sql = """
                    UPDATE wish_lists 
                    SET is_active = :active
                    WHERE id = :id
                    """;
        this.getJdbi().useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("active", w.getActive())
                        .bind("id", w.getId())
                        .execute()
        );
    }

    public List<Long> findAllProductIdByUserId(Long userId) {
        String sql = """
                SELECT product_id
                FROM wish_lists
                WHERE user_id = :userId
                    AND is_active = 1
                """;
        return this.getJdbi().withHandle(handle -> handle.createQuery(sql)
                .bind("userId", userId)
                .mapTo(Long.class)
                .list()
        );
    }

    public Optional<WishList> findByUserIdAndProductId(long userId, long productId) {
        String sql = """
                    SELECT id, user_id, product_id, is_active AS active
                    FROM wish_lists 
                    WHERE user_id = :userId AND product_id = :productId
                    """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .bind("productId", productId)
                        .mapToBean(WishList.class)
                        .findOne()
        );
    }


    public static void main(String[] args) {
        System.out.println(new WishListDAO().findByUserIdAndProductId(1, 1));
    }

}
