package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.HandbookCategory;

public class HandbookCategoryDAO extends BaseDAO {

    public long save(HandbookCategory handbookCategory){
        String sql  = """
                insert into  handbook_categories(category_id, handbook_id) VALUE (:categoryId,:handbookId);
                """;
        return this.getJdbi().withHandle(handle -> handle.createUpdate(sql)

                .bind("handbookId",handbookCategory.getHandbookId())
                .bind("categoryId",handbookCategory.getCategoryId())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(Long.class)
                .one()
        );
    }
}
