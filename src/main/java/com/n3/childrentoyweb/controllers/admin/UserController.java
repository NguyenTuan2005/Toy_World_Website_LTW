package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageUsers",value = "/users")
public class UserController extends HttpServlet {
    public static final int  PAGE_SIZE = 9;
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

        req.getRequestDispatcher("/adminPages/users.jsp").forward(req,resp);
    }

    private void addUsersPagination(int page,HttpServletRequest request){
        Pagination<ManageUserDTO> manageUserDTOPagination = this.userService.findAllUsersForManagements(page,PAGE_SIZE);
        System.out.println(manageUserDTOPagination);
        List<ManageUserDTO> manageUserDTOS = manageUserDTOPagination.getData();
        request.setAttribute("manage_users",manageUserDTOS);
        request.setAttribute("currentPage",manageUserDTOPagination.getCurrentPage());
        request.setAttribute("totalElements",manageUserDTOPagination.getTotalElements());
        request.setAttribute("totalPages",manageUserDTOPagination.getTotalPages());
        request.setAttribute("pageSize",PAGE_SIZE);
    }


}
