package com.n3.childrentoyweb.controllers.antbmhttt;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.PublicKeyService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


@WebServlet(name = "atbmhttt", value= "/lost-private-key")
public class LostKeyController extends HttpServlet {
    private final PublicKeyService publicKeyService = new PublicKeyService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session =  req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        publicKeyService.lostKey(currentUser.getId());
        String username = currentUser.getFirstName()+" "+currentUser.getLastName();
        req.setAttribute("username",username);
        req.getRequestDispatcher("/user-lost-key.jsp").forward(req, resp);
    }
}
