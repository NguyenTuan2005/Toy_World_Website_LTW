package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Handbook;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;

public class HandbookDAO extends BaseDAO{


    public long save(Handbook handbook){
        String sql = """
                insert into  handbooks (user_id, title, status)\s
                value (:userId,:title,:status)
                    """;

       return this.getJdbi().withHandle(handle -> handle.createUpdate(sql)
                .bind("userId",handbook.getUserId())
                .bind("title",handbook.getTitle())
                .bind("status",handbook.getStatus())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(Long.class)
                .one()
        );
    }

    public Handbook findById(long id) {
        String sql = """
                select\s
                    *
                from handbooks
                where id =:id
                """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id",id)
                        .map((rs, ctx) -> {
                            Handbook handbook = new Handbook();
                            handbook.setId(rs.getLong("id"));
                            handbook.setUserId(rs.getLong("user_id"));
                            handbook.setTitle(rs.getString("title"));
                            handbook.setStatus(rs.getString("status"));
                            handbook.setActive(rs.getBoolean("is_active"));
                            handbook.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                            return handbook;
                        }).one()
        );
    }

    public int updateHandbook(Handbook handbook) {
        String sql = """
                update handbooks
                set  user_id =:userId, title =:title, status =:status
                where id =:id
                """;
        return this.getJdbi().withHandle(handle -> handle.createUpdate(sql)
                .bind("id",handbook.getId())
                .bind("userId",handbook.getUserId())
                .bind("title",handbook.getTitle())
                .bind("status",handbook.getStatus())
                .execute()
        );
    }



}
