package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Brand;

import java.util.List;

public class BrandDAO  extends BaseDAO{
    public List<Brand> findALl() {
        String sql = """
                select * from brands
                where is_active = 1
                order by name
                """;
        return this.getJdbi().withHandle(handle ->
                    handle.createQuery(sql)
                            .mapToBean(Brand.class)
                            .list()
                );
    }
}
