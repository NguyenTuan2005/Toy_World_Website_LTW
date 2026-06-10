package com.n3.childrentoyweb.controllers.antbmhttt;

import com.n3.childrentoyweb.dto.UserPublicKeyDTO;
import com.n3.childrentoyweb.services.PublicKeyService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/user-lost-key")
public class AdminManagementLostKeyController extends HttpServlet {

    private final PublicKeyService publicKeyService =  new PublicKeyService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page =1;
        if(req.getParameter("page") != null){
            page = Integer.parseInt(req.getParameter("page"));
        }
        List<UserPublicKeyDTO> userPublicKeyDTOS = publicKeyService.findAllUserPublicKeyInfoLost(page,20);
        req.setAttribute("losts",userPublicKeyDTOS);
        req.getRequestDispatcher("/adminPages/user-lost-key.jsp").forward(req,resp);
    }
}
