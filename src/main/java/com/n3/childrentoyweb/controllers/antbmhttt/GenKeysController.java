package com.n3.childrentoyweb.controllers.antbmhttt;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.EmailService;
import com.n3.childrentoyweb.services.PublicKeyService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.*;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@WebServlet("/gen-keys")
public class GenKeysController extends HttpServlet {

    private final PublicKeyService publicKeyService = new PublicKeyService();
    private final EmailService emailService = EmailService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        KeyPairGenerator keyPairGenerator = null;
        HttpSession session =  req.getSession();

        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null){
            req.getRequestDispatcher("/login/login.jsp").forward(req,resp);
            return;
        }
        try {
            keyPairGenerator = KeyPairGenerator.getInstance("DSA");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        keyPairGenerator.initialize(1024);
        KeyPair keyPair = keyPairGenerator.generateKeyPair();
        PrivateKey privateKey = keyPair.getPrivate();
        PublicKey publicKey = keyPair.getPublic();

        req.setCharacterEncoding("UTF-8");

        Long userId = currentUser.getId();

        System.out.println("Public Key:");
        System.out.println(publicKey);
        System.out.println("User ID"+userId);


        String base64StringPublicKey = Base64.getEncoder().encodeToString(publicKey.getEncoded());
        com.n3.childrentoyweb.models.PublicKey newPublicKey = new com.n3.childrentoyweb.models.PublicKey(LocalDateTime.now(),userId,base64StringPublicKey);
        String base64StringPrivateKey = Base64.getEncoder().encodeToString(privateKey.getEncoded());
        boolean isSavedPublicKey =  this.publicKeyService.saveAndDisableOldKey(newPublicKey) > 0;


        if (!isSavedPublicKey){
            req.getRequestDispatcher("/public-key-policy.jsp").forward(req, resp);
            return;
        }
        ExecutorService executor = Executors.newFixedThreadPool(1);

        try {
            executor.submit(() -> {
                this.emailService.sendPrivateKey(currentUser.getEmail(), base64StringPrivateKey);
            });
        } finally {
            executor.shutdown();
        }


        req.setAttribute("privateKey",base64StringPrivateKey);
        req.getRequestDispatcher("/display-private-key.jsp").forward(req,resp);
    }
}
