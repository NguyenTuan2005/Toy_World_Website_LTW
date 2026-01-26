package com.n3.childrentoyweb.controllers.account;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.UserService;
import com.n3.childrentoyweb.verifier.PasswordVerifier;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(value = "/account/change-password")
public class ChangePasswordController extends HttpServlet {
    private UserService userService;
    private PasswordVerifier passwordVerifier;

    @Override
    public void init(){
        userService = new UserService();
        passwordVerifier = new PasswordVerifier();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/myAccount/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("currentUser");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!userService.checkPassword(user, currentPassword)) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng");
            doGet(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            doGet(request, response);
            return;
        }

        try{
            passwordVerifier.verify(newPassword);
        }catch (IllegalArgumentException e){
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
            return;
        }

        userService.updatePassword(user, newPassword);

        request.setAttribute("success", "Đổi mật khẩu thành công");
        doGet(request, response);
    }
}