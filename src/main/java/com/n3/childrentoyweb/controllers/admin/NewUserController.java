package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "NewUserAdmin",value = "/admin/new-users")
public class NewUserController extends HttpServlet {
    private UserService userService;

    public void  init(){
       this.userService = new UserService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        System.out.println("James ket");

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String province = request.getParameter("province");
        String address = request.getParameter("address");
        String[] roles = request.getParameterValues("roles");
        String status = request.getParameter("status");
    }
}
