package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.WishlistProductDTO;
import com.n3.childrentoyweb.models.WishList;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

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

    public boolean delete(Long userId, Long productId){
        String sql = """
                UPDATE wish_lists 
                    SET is_active = 0
                    WHERE user_id=:userId AND product_id=:productId
                """;
        return this.getJdbi().withHandle(handle -> handle.createUpdate(sql)
                .bind("userId", userId)
                .bind("productId", productId)
                .execute() > 0);
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

    public List<WishlistProductDTO> findWishlistByUserId(Long userId) {
        String sql = """
            SELECT 
                p.id AS productId,
                p.name AS name,
                p.price AS price,
                p.quantity AS quantity,
                (SELECT pa.img_path
                    FROM product_assets pa
                    WHERE pa.product_id = p.id
                        AND pa.is_active = 1
                    LIMIT 1) AS imgPath
            FROM wish_lists w
            JOIN products p ON w.product_id = p.id
            WHERE w.user_id = :userId
              AND w.is_active = 1
              AND p.is_active = 1
            ORDER BY w.created_at DESC
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .registerRowMapper(BeanMapper.factory(WishlistProductDTO.class))
                        .mapToBean(WishlistProductDTO.class)
                        .list()
        );
    }



    public boolean isProductInWishlist(long userId, long productId) {

        String sql = """
        SELECT EXISTS (
            SELECT 1
            FROM wish_lists w
            JOIN products p ON w.product_id = p.id
            WHERE w.user_id = :userId
              AND w.product_id = :productId
              AND w.is_active = 1
              AND p.is_active = 1
        )
    """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .bind("productId", productId)
                        .mapTo(Boolean.class)
                        .one()
        );
    }


    public static void main(String[] args) {
        System.out.println(new WishListDAO().findWishlistByUserId( 1L));
    }

}
