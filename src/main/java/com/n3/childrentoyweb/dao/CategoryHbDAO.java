package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.CategoryHb;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;

import java.util.List;

public class CategoryHbDAO extends BaseDAO {

    public List<CategoryHb> findAll(){
        String sql = """
                    select * from category_hbs
                    """;
        return this.getJdbi().withHandle(handle -> handle.createQuery(sql)
                .map((rs,e)->{
                    CategoryHb categoryHb = new CategoryHb();
                    categoryHb.setId(rs.getLong("id"));
                    categoryHb.setName(rs.getString("name"));
                    categoryHb.setActive(rs.getBoolean("is_active"));
                    categoryHb.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                    return categoryHb;
                }).list()
        );
    }

    public long save(CategoryHb categoryHb) {
        String sql = """
                insert into category_hbs (name)
                values (:name)
                """;
        return this.getJdbi().withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("name", categoryHb.getName())
                            .executeAndReturnGeneratedKeys()
                            .mapTo(Long.class)
                            .one()
                );
    }
}
