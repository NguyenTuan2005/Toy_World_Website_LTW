package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.dto.UserCriteria;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageUsers",value = "/admin/users")
public class UserController extends HttpServlet {
    public static final int  PAGE_SIZE = 10;
    private UserService userService;

    public void init(){
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Go to admin");
        int page =1;
        if(req.getParameter("page") != null){
            page = Integer.parseInt(req.getParameter("page"));
        }
        this.addUsersPagination(page,req);
        this.addStatisticUsers(req);

        req.getRequestDispatcher("/adminPages/users.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        UserCriteria userCriteria = new UserCriteria(keyword);
        System.out.println(userCriteria);

        this.findUserByCriteria(userCriteria,req);
        this.addStatisticUsers(req);

        req.getRequestDispatcher("/adminPages/users.jsp").forward(req,resp);
    }


    private void findUserByCriteria(UserCriteria userCriteria, HttpServletRequest request){
        Pagination<ManageUserDTO>  manageUserDTOPagination = this.userService.findByCriteria(userCriteria);

        System.out.println(manageUserDTOPagination.getData());

        request.setAttribute("find_user","find-user");
        request.setAttribute("manage_users",manageUserDTOPagination.getData());
        request.setAttribute("currentPage",1);
        request.setAttribute("totalElements",manageUserDTOPagination.getTotalElements());
        request.setAttribute("totalPages",manageUserDTOPagination.getTotalPages());
        request.setAttribute("pageSize",manageUserDTOPagination.getData().size());
    }


    private void addUsersPagination(int page, HttpServletRequest request){
        Pagination<ManageUserDTO> manageUserDTOPagination = this.userService.findAllUsersForManagements(page,PAGE_SIZE);
        System.out.println(manageUserDTOPagination);
        List<ManageUserDTO> manageUserDTOS = manageUserDTOPagination.getData();
        request.setAttribute("manage_users",manageUserDTOS);
        request.setAttribute("currentPage",manageUserDTOPagination.getCurrentPage());
        request.setAttribute("totalElements",manageUserDTOPagination.getTotalElements());
        request.setAttribute("totalPages",manageUserDTOPagination.getTotalPages());
        request.setAttribute("pageSize",PAGE_SIZE);
    }


    public void addStatisticUsers(HttpServletRequest request){
        int totalUsers = this.userService.countAllUsers();
        int totalAdmins = this.userService.countAllAdmins();
        int totalNewUsersInMonth = this.userService.countNewUsersInMonth();

        request.setAttribute("total_users_num",totalUsers);
        request.setAttribute("total_admins_num",totalAdmins);
        request.setAttribute("total_new_users_num",totalNewUsersInMonth);
    }

}
