package com.n3.childrentoyweb.controllers.admin.products;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.CommentManagementDTO;
import com.n3.childrentoyweb.models.UserComment;
import com.n3.childrentoyweb.services.UserCommentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "hiddenComment", value = "/admin/hidden-comments")
public class HiddenCommentController extends HttpServlet {
    private static final int PAGE_SIZE = 10;
    private UserCommentService commentService;

    @Override
    public void init() throws ServletException {
        this.commentService = new UserCommentService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            long commentId = Long.parseLong(req.getParameter("commentId"));

            UserComment comment = commentService.findById(commentId);
            comment.revertActive();

            commentService.update(comment);

            int page = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
            Pagination<CommentManagementDTO> comments = commentService.findAllCommentsForManagement(page, PAGE_SIZE);

            req.setAttribute("comments", comments.getData());
            req.setAttribute("totalPages", comments.getTotalPages());
            req.setAttribute("currentPage", comments.getCurrentPage());
            req.setAttribute("totalComments", comments.getTotalElements());
            req.getRequestDispatcher("/adminPages/comments.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write(e.getMessage());
        }
    }
}
