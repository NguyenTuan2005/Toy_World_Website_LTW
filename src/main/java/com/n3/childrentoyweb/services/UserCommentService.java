package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dao.UserCommentDAO;
import com.n3.childrentoyweb.dto.CommentCriteria;
import com.n3.childrentoyweb.dto.CommentManagementDTO;
import com.n3.childrentoyweb.models.UserComment;

import java.util.List;

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

    public Pagination<CommentManagementDTO> findAllCommentsForManagement(int page, int pageSize) {
        List<CommentManagementDTO> comments = this.userCommentDAO.findAllCommentsForManagement(page, pageSize);
        int totalComment = this.userCommentDAO.countAll();
        int totalPage = totalComment / pageSize;

        return new Pagination<>(comments, page, totalComment, totalPage);
    }

    public Pagination<CommentManagementDTO> findByCriteria(CommentCriteria commentCriteria) {
        List<CommentManagementDTO> comments = this.userCommentDAO.findByCriteria(commentCriteria);
        return new Pagination<>(comments, 1, 10, 1);
    }

    public UserComment findById(long commentId) {
        return this.userCommentDAO.findById(commentId);
    }

    public void update(UserComment comment) {
        this.userCommentDAO.update(comment);
    }
}
