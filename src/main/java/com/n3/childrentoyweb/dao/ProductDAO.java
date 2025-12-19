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

    public List<Product> findAllByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        String sql = """
            SELECT id, name, price, quantity, description,
                   brand_id AS brandId,
                   category_id AS categoryId
            FROM products
            WHERE is_active = 1
            LIMIT :pageSize OFFSET :offset
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("offset", offset)
                        .bind("pageSize", pageSize)
                        .registerRowMapper(BeanMapper.factory(Product.class))
                        .mapTo(Product.class)
                        .list()
        );
    }


    public int countAll() {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = 1";

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }


}
