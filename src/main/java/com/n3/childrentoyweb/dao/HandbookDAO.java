package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.HandBookCardDTO;
import com.n3.childrentoyweb.dto.HandBookCriteria;
import com.n3.childrentoyweb.models.Handbook;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;

import java.util.List;

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
                            handbook.setViews(rs.getLong("views"));
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
                set  user_id =:userId, title =:title, status =:status, views = :views
                where id =:id
                """;
        return this.getJdbi().withHandle(handle -> handle.createUpdate(sql)
                .bind("id",handbook.getId())
                .bind("userId",handbook.getUserId())
                .bind("title",handbook.getTitle())
                .bind("status",handbook.getStatus())
                .bind("views",handbook.getViews())
                .execute()
        );
    }

    public Integer countAll(){
        String sql = """
                select  count(h.id) as total
                from handbooks h
                """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
                );
    }

    public Integer countAllHidden(){
        String sql = """
                select  count(h.id) as total
                from handbooks h
                where d.status = 'HIDDEN'
                """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }


    public List<HandBookCardDTO> findHandbookCardByCriteria(HandBookCriteria handBookCriteria) {
        StringBuilder  sql =new StringBuilder( """
                select h.id
                        ,h.user_id
                        ,h.title
                        ,h.views
                        ,h.status
                        ,p.description
                        ,p.image_path
                        ,concat(u.first_name,' ',u.last_name) as fullname
                        , h.created_at
                from handbooks h
                         join paragraphs p on h.id = p.handbook_id
                         join users u on h.user_id = u.id
                where p.display_index = 1
                """);
        sql.append(handBookCriteria.getIdForSql());
        sql.append(handBookCriteria.getIsOnDayForSql());
        sql.append(handBookCriteria.getIsOnMonthForSql());
        sql.append(handBookCriteria.getIsHiddenForSql());
        sql.append(handBookCriteria.getTitleForSql());
        sql.append(handBookCriteria.getUserIdForSql());
        sql.append(handBookCriteria.getOrderByForSql());
        sql.append(handBookCriteria.getPaginationForSql());

        return this.getJdbi().withHandle(handle -> handle.createQuery(sql)
                .map((rs,e)->{
                    HandBookCardDTO handBookCardDTO = new HandBookCardDTO();
                    handBookCardDTO.setId(rs.getLong("id"));
                    handBookCardDTO.setUserId(rs.getLong("user_id"));
                    handBookCardDTO.setViews(rs.getLong("views"));
                    handBookCardDTO.setTitle(rs.getString("title"));
                    handBookCardDTO.setStatus(rs.getString("status"));
                    handBookCardDTO.setDescription(rs.getString("description"));
                    handBookCardDTO.setFirstImage(rs.getString("image_path"));
                    handBookCardDTO.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                    handBookCardDTO.setUsername(rs.getString("fullname"));

                    return handBookCardDTO;
                }).list()
        );
    }


}
