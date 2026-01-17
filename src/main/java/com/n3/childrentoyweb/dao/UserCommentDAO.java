package com.n3.childrentoyweb.dao;

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


    public static void main(String[] args) {
        System.out.println(new UserCommentDAO().findByProductId(1L));
    }


}
