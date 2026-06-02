package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dto.UserDetailDTO;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Optional;
import java.util.OptionalInt;

@WebServlet(name = "UserDetailManage",value = "/admin/user-details")
public class UserDetailController extends HttpServlet {

    private UserService userService;

    @Override
    public void init()  {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.addUserDetail(req);
        req.getRequestDispatcher("/adminPages/user-detail.jsp").forward(req,resp);
    }

    public void addUserDetail(HttpServletRequest request){
        int currentPage = Integer.parseInt(Optional.<String>ofNullable(request.getParameter("page")).orElseGet(() -> "1"));
        int pageSize =20;
        currentPage =  currentPage <=0 ? 1: currentPage;
        String userIdString = request.getParameter("userId");

        if(userIdString == null) throw new ObjectNotFoundException();

        Long id = Long.parseLong(userIdString);
        UserDetailDTO userDetailDTO = this.userService.findUserDetailByIdAndLoadPublicKeysWithPagination(id,currentPage,pageSize);

        System.out.println(userDetailDTO.getPublicKeys());

        request.setAttribute("publicKeys",userDetailDTO.getPublicKeys());
        request.setAttribute("currentPage",currentPage);
        request.setAttribute("userId",id);
        boolean isNotFoundUser = userDetailDTO == null;

        if(isNotFoundUser) {
            request.setAttribute("error","Không tim thấy người dùng");
            return;
        }

        System.out.println(userDetailDTO.getUser());

        request.setAttribute("user",userDetailDTO.getUser());
        request.setAttribute("role",userDetailDTO.getRole());

        boolean isNotFoundLocation = userDetailDTO.getLocation() == null;
        if(!isNotFoundLocation)
            request.setAttribute("location",userDetailDTO.getLocation());
    }
}
