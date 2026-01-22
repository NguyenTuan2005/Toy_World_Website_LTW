package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.CommentManagementDTO;
import com.n3.childrentoyweb.dto.UserCommentDTO;
import com.n3.childrentoyweb.models.UserComment;

import java.util.List;

public class UserCommentDAO extends BaseDAO {


    public List<UserCommentDTO> findByProductId(Long productId) {
        String sql = """
        SELECT uc.id,
               uc.content,
               uc.user_id ,
               CONCAT(u.first_name,' ',u.last_name) AS userName,
               uc.created_at
        FROM user_comments uc
        JOIN users u ON uc.user_id = u.id
        WHERE uc.is_active = 1
          AND uc.product_id = :productId
        ORDER BY uc.created_at DESC
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("productId", productId)
                        .mapToBean(UserCommentDTO.class)
                        .list()
        );
    }


    public void save(UserComment userComment){
        String sql = """
                INSERT INTO user_comments (content, product_id, user_id)
                VALUES (:content, :productId, :userId)
                """;

        super.getJdbi().useHandle(handle -> handle.createUpdate(sql)
                        .bind("content", userComment.getContent())
                        .bind("userId", userComment.getUserId())
                        .bind("productId", userComment.getProductId())
                        .execute()
        );
    }

    public List<CommentManagementDTO> findAllCommentsForManagement(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = """
                select uc.id as commentId,
                       concat(u.last_name, " ", u.first_name) as user,
                       p.name as product,
                       uc.content,
                       uc.is_active as isActive, 
                       uc.created_at as createdAt
                from user_comments uc
                join users u on u.id = uc.user_id
                join products p on p.id = uc.product_id
                limit :limit offset :offset
                """;

        return this.getJdbi().withHandle(handle ->
                    handle.createQuery(sql)
                            .bind("limit", pageSize)
                            .bind("offset", offset)
                            .map((rs, ctx) -> {
                                CommentManagementDTO commentManagementDTO = new CommentManagementDTO();
                                commentManagementDTO.setCommentId(rs.getInt("commentId"));
                                commentManagementDTO.setUser(rs.getString("user"));
                                commentManagementDTO.setProduct(rs.getString("product"));
                                commentManagementDTO.setContent(rs.getString("content"));
                                commentManagementDTO.setActive(rs.getBoolean("isActive"));
                                commentManagementDTO.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                                return commentManagementDTO;
                            })
                            .list()
                );
    }

    public int countAll() {
        String sql = """
                select count(*)
                from user_comments
                """;
        return this.getJdbi().withHandle(handle ->
                    handle.createQuery(sql)
                            .mapTo(Integer.class)
                            .one()
                );
    }
}
