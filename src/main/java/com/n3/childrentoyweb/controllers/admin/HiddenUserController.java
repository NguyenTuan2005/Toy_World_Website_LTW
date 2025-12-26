package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;


@WebServlet(name = "HiddenUserManage",value = "/admin/hidden-users")
public class HiddenUserController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() {
        this.userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try{

            long userId = Long.parseLong( req.getParameter("userId"));
            User user = this.userService.findById(userId).orElseThrow(ObjectNotFoundException::new);

            user.revertActive();

            System.out.println("Load  for hiddent"+user);

            this.userService.update(user);

        }catch (ObjectNotFoundException e){
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        } catch (Exception e){
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer);
    }
}
