package com.n3.childrentoyweb.controllers.antbmhttt;

import com.n3.childrentoyweb.models.Cart;
import com.n3.childrentoyweb.models.CurrentUser;
import com.n3.childrentoyweb.models.PublicKey;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.PublicKeyService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;

@WebServlet(name = "atbmhttt", value= "/public-key")
public class PublicKeyController extends HttpServlet {

    private final PublicKeyService publicKeyService;

    public PublicKeyController() {
        super();
        this.publicKeyService = new PublicKeyService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session =  req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        Optional<LocalDateTime> latestCreatePublicKey =  Optional.ofNullable(this.publicKeyService.findLatestCreatePublicKey(currentUser.getId()));
        if (latestCreatePublicKey.isEmpty()){
            req.setAttribute("latestCreate",null);
        }else
            req.setAttribute("latestCreate",latestCreatePublicKey.get().toString());
        req.getRequestDispatcher("/create-public-key.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session =  req.getSession();

        User currentUser = (User) session.getAttribute("currentUser");

        String publicKey = req.getParameter("publicKey");

        Long userId = currentUser.getId();

        System.out.println("Public Key:");
        System.out.println(publicKey);
        System.out.println("User ID"+userId);

        boolean isSuccess = false;

        if (publicKey == null){
            req.setAttribute("success", isSuccess);
            req.getRequestDispatcher("/save-public-key-status.jsp").forward(req, resp);
            return;
        }


        PublicKey newPublicKey = new PublicKey(LocalDateTime.now(),userId,publicKey);
        boolean isSavedPublicKey =  this.publicKeyService.saveAndDisableOldKey(newPublicKey) > 0;


        if (!isSavedPublicKey){
            req.getRequestDispatcher("/public-key-policy.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("success", true);
        req.getRequestDispatcher("/save-public-key-status.jsp").forward(req, resp);
    }
}
