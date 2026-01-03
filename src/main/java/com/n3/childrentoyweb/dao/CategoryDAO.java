package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Category;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.List;

public class CategoryDAO extends BaseDAO{

    public List<Category> findAll() {
        String sql = """
            SELECT id, name, is_active, created_at
            FROM categories
        """;

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .registerRowMapper(BeanMapper.factory(Category.class))
                        .mapTo(Category.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        System.out.println(new ProductDAO().findAll());
    }
}
