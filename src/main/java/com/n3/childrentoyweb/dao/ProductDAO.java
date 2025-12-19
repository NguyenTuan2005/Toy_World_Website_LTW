package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Product;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.List;

public class ProductDAO  extends BaseDAO{

    public List<Product> findAll() {
        String sql = """
            SELECT id, name, price, quantity, description,
                   brand_id AS brandId,
                   category_id AS categoryId
            FROM products
            WHERE is_active = 1
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .registerRowMapper(BeanMapper.factory(Product.class))
                        .mapTo(Product.class)
                        .list()
        );
    }

}
