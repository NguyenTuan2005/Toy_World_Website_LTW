package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.CategoryFilterDTO;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.List;

public class CategoryDAO extends BaseDAO{

    public List<CategoryFilterDTO> findCategoryProductCount() {
        String sql = """
        SELECT c.id,
               c.name,
               COUNT(p.id) AS productCount
        FROM categories c
        LEFT JOIN products p ON p.category_id = c.id
        WHERE c.is_active = 1
        GROUP BY c.id
        ORDER BY c.name
        """;

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .registerRowMapper(BeanMapper.factory(CategoryFilterDTO.class))
                        .mapTo(CategoryFilterDTO.class)
                        .list()
        );
    }

}
