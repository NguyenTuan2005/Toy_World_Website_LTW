package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.ProductAsset;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.List;
import java.util.Optional;

public class ProductAssetDAO extends BaseDAO {

    public List<ProductAsset> findAll(){
        String sql = """
            SELECT id, img_path, product_id
            FROM product_assets
        """;

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .registerRowMapper(BeanMapper.factory(ProductAsset.class))
                        .mapTo(ProductAsset.class)
                        .list()
        );
    }

    public List<String> findImagePathByProductId(Long productId) {
        String sql = """
            SELECT img_path
            FROM product_assets
            WHERE product_id = :productId
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("productId", productId)
                        .mapTo(String.class)
                        .list()
        );
    }

    public Optional<ProductAsset> findFirstByProductId(long productId) {
        String sql = """
                select id, img_path, product_id
                from product_assets
                where product_id = :productId
                limit 1
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("productId", productId)
                        .mapToBean(ProductAsset.class)
                        .findOne());
    }

    public void save(ProductAsset productAsset) {
        String sql = """
                INSERT INTO `product_assets` (`img_path`, `product_id`)
                VALUES (:imgPath, :productId)
                """;

        this.getJdbi().useHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("imgPath", productAsset.getImgPath())
                            .bind("productId", productAsset.getProductId())
                            .execute()
                );
    }
}
