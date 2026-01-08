package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.HomeProductDTO;
import com.n3.childrentoyweb.models.Paragraph;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;

import java.util.List;

public class ParagraphDAO extends BaseDAO{

    public long save(Paragraph paragraph){
        String sql = """
                insert into paragraphs(header, description, image_path, image_description, display_index, handbook_id)\s
                VALUE (:header,:description, :image_path, :image_description, :display_index,:handbook_id);
                    """;

        return this.getJdbi().withHandle(handle -> handle.createUpdate(sql)
                .bind("header",paragraph.getHeader())
                .bind("description",paragraph.getDescription())
                .bind("image_path",paragraph.getImagePath())
                .bind("image_description",paragraph.getImageDescription())
                .bind("display_index",paragraph.getDisplayIndex())
                .bind("handbook_id",paragraph.getHandbookId())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(Long.class)
                .one()
        );
    }

    public List<Paragraph> findAllByHandbookId(Long id) {
        String sql  = """
                select * from paragraphs where handbook_id = :handbookId
                """;
       return this.getJdbi().withHandle(handle -> handle.createQuery(sql)
               .bind("handbookId",id)
               .map((rs, ctx) -> {
                  Paragraph paragraph = new Paragraph();
                  paragraph.setId(rs.getLong("id"));
                  paragraph.setHeader(rs.getString("header"));
                  paragraph.setDescription(rs.getString("description"));
                  paragraph.setImagePath(rs.getString("image_path"));
                  paragraph.setImageDescription(rs.getString("image_description"));
                  paragraph.setDisplayIndex(rs.getInt("display_index"));
                  paragraph.setHandbookId(rs.getLong("handbook_id"));
                  paragraph.setActive(rs.getBoolean("is_active"));
                  paragraph.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                  return paragraph;
               }).list()
       );
    }
}
