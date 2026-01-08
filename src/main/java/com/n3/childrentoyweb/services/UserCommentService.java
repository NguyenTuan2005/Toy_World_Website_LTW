package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.UserCommentDAO;
import com.n3.childrentoyweb.dto.UserCommentDTO;
import com.n3.childrentoyweb.models.UserComment;

public class UserCommentService {
    private UserCommentDAO userCommentDAO;

    public UserCommentService(){
        userCommentDAO = new UserCommentDAO();
    }

    public void save(Long productId, Long userId, String content){
        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("Comment rỗng");
        }

        UserComment comment = new UserComment();
        comment.setContent(content.trim());
        comment.setUserId(userId);
        comment.setProductId(productId);

        this.userCommentDAO.save(comment);
    }


    public static void main(String[] args) {
        new UserCommentService().save(1L, 1L, "test comment");
    }
}
