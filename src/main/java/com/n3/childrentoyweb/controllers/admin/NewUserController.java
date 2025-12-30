package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.UserService;
import com.n3.childrentoyweb.utils.MD5Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;


@WebServlet(name = "NewUserAdmin",value = "/admin/new-users")
public class NewUserController extends HttpServlet {
    private UserService userService;

    public void  init(){
       this.userService = new UserService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        String passwordEncoded = MD5Util.encryptMd5(password);

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setGender(gender);
        user.setPhone(phone);
        user.setEmail(email);
        user.setPassword(passwordEncoded);
        user.setActive(Boolean.getBoolean(status));


        Location location = new Location();
        location.setProvince(province);
        location.setAddress(address);

        try {
            if(user.isValidEmail() || user.isValidPhone() || user.isValidPassword()||user.isValidFirstName()||user.isValidLastName())
                throw  new RuntimeException("Thông tin có sai không hợp lệ");
            this.userService.createNewUser(user, location, roles);
        } catch (Exception e){
            System.out.println("Error : "+ e.getMessage());
            request.setAttribute("error", e.getMessage());

            request.getRequestDispatcher("/adminPages/users.jsp").forward(request,response);
            return;
        }

        request.setAttribute("notify", "Đã thêm user thành công");
        request.getRequestDispatcher("/admin/users").forward(request,response);
    }
}








