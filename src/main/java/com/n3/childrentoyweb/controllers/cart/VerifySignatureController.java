package com.n3.childrentoyweb.controllers.cart;

import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.dto.orderSignature.OrderSignatureDTO;
import com.n3.childrentoyweb.exception.DataInvalidException;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.OrderService;
import com.n3.childrentoyweb.services.UserOrderService;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

@WebServlet(name = "verifySignature", value = "/verify-signature")
@MultipartConfig
public class VerifySignatureController extends HttpServlet {
    private OrderService orderService;
    private UserService userService;
    private UserOrderService userOrderService;

    @Override
    public void init() {
        this.userOrderService = new UserOrderService();
        this.orderService = new OrderService();
        this.userService = new UserService();
    }

    //TODO: code lai cho dung vai tro
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser;
        try {

            if ((currentUser = (User) request.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");

            long orderId = Long.parseLong(request.getParameter("orderId"));

            OrderSignatureDTO order = userOrderService.findOrderWithSignatureByUserAndOrderId(currentUser.getId(), orderId);


            String signingPayload = order.getOrderSigningPayload();
            String publicKeyBase64 = order.getPublicKey();
            String algorithm = order.getAlgorithm();

            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(publicKeyBase64));
            KeyFactory keyFactory = KeyFactory.getInstance("DSA");
            PublicKey publicKey = keyFactory.generatePublic(keySpec);


            Part signaturePart = request.getPart("signatureFile");
            String signatureBase64 = new String(signaturePart.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
            System.out.println("signatureBase64 len: " + signatureBase64.length());

            Signature signature = Signature.getInstance(algorithm);
            signature.initVerify(publicKey);

            signature.update(signingPayload.getBytes(StandardCharsets.UTF_8));
            boolean isValid = signature.verify(Base64.getDecoder().decode(signatureBase64));

            if (isValid) {
                System.out.println("valid xác thực ôk skibidi");
            } else {
                System.out.println("LOOIIII lỗi");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/sign-order.jsp").forward(request, response);
        }


    }

}
