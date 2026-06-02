package com.n3.childrentoyweb.controllers.antbmhttt;

import com.n3.childrentoyweb.models.PublicKey;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.PublicKeyService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.stream.Collectors;


@WebServlet("/public-key-file")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1MB
        maxFileSize = 1024 * 1024 * 5,        // 5MB
        maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class PublicKeyFileController extends HttpServlet {

    private final PublicKeyService publicKeyService = new PublicKeyService();

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        Part filePart = req.getPart("publicKeyFile");

        if (filePart == null || filePart.getSize() == 0) {
            req.setAttribute("error", "Vui lòng chọn file.");
            req.getRequestDispatcher("/create-public-key.jsp")
                    .forward(req, resp);
            return;
        }

        String publicKey;

        try (BufferedReader reader =
                     new BufferedReader(
                             new InputStreamReader(
                                     filePart.getInputStream(),
                                     StandardCharsets.UTF_8))) {

            publicKey = reader.lines()
                    .collect(Collectors.joining("\n"));
        }

        HttpSession session =  req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        Long userId = currentUser.getId();
        boolean isSuccess = false;

        if (publicKey == null){
            req.setAttribute("success", isSuccess);
            req.getRequestDispatcher("/save-public-key-status.jsp").forward(req, resp);
            return;
        }

        PublicKey newPublicKey = new PublicKey(LocalDateTime.now(),userId,publicKey);
        isSuccess = this.publicKeyService.saveAndDisableOldKey(newPublicKey) > 0;

        req.setAttribute("success", isSuccess);
        req.getRequestDispatcher("/save-public-key-status.jsp").forward(req, resp);
    }
}