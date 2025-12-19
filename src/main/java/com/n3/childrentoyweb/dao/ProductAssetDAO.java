package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Category;
import com.n3.childrentoyweb.models.ProductAsset;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.List;

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

}
