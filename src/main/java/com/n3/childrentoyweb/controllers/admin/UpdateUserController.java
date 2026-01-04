package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "UpdateUserManage", value = "/change-user-info")
public class UpdateUserController extends HttpServlet {

    private UserService userService;

    public void init(){
        this.userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Reached me");
        long id = Long.parseLong(request.getParameter("userId"));
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

        System.out.println("UserId " + id);
        System.out.println("FirstName " + firstName);
        System.out.println("Last name " + lastName);
        System.out.println("Gender " + gender);
        System.out.println("Phone " + phone);
        System.out.println("mail " + email);
        System.out.println("" + password);
        System.out.println("Province" + province);
        System.out.println("address " + address);
        System.out.println("Role" + roles);
        System.out.println(status);


        User user = new User();
        user.setId(id);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setGender(gender);
        user.setPhone(phone);
        user.setEmail(email);
        user.setPassword(password);
        user.setActive(status != null ? true :false);


        Location location = new Location();
        location.setProvince(province);
        location.setAddress(address);
        try {
            this.userService.updateUser(user,location,roles);
        } catch (Exception e) {
            e.printStackTrace();
        }


        request.setAttribute("notify", "Đã cập nhật thành công");

        String previousPage = request.getHeader("Referer");
        resp.sendRedirect(previousPage);
    }
}
