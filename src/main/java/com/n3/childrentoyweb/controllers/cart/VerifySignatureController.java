package com.n3.childrentoyweb.controllers.cart;

import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderSignatureDAO;
import com.n3.childrentoyweb.dto.orderSignature.OrderSignatureDTO;
import com.n3.childrentoyweb.enums.SignatureStatus;
import com.n3.childrentoyweb.exception.DataInvalidException;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.OrderService;
import com.n3.childrentoyweb.services.OrderSignatureService;
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
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

@WebServlet(name = "verifySignature", value = "/verify-signature")
@MultipartConfig
public class VerifySignatureController extends HttpServlet {
    private OrderService orderService;
    private UserService userService;
    private UserOrderService userOrderService;
    private OrderSignatureService orderSignatureService;

    @Override
    public void init() {
        this.userOrderService = new UserOrderService();
        this.orderService = new OrderService();
        this.userService = new UserService();
        this.orderSignatureService = new OrderSignatureService(new OrderSignatureDAO(), new OrderDAO());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser;
        long orderId = -1;
        try {
            if ((currentUser = (User) request.getSession().getAttribute("currentUser")) == null)
                throw new DataInvalidException("Bạn hãy vui lòng đăng nhập");
            orderId = Long.parseLong(request.getParameter("orderId"));



            Part signaturePart = request.getPart("signatureFile");
            String signatureBase64 = new String(signaturePart.getInputStream().readAllBytes(), StandardCharsets.UTF_8);

            boolean isValid = orderSignatureService.verifyOrder(currentUser.getId(), orderId, signatureBase64);


            if (isValid) {
                userOrderService.updateOrderSignatureStatus(currentUser.getId(), orderId, SignatureStatus.SIGNED, signatureBase64);

                response.sendRedirect(request.getContextPath() + "/checkout?orderId=" + orderId);
            } else {
                request.getSession().setAttribute("error", "Chữ ký không hợp lệ, xác thực thất bại");
                response.sendRedirect(request.getContextPath() + "/sign-order?orderId=" + orderId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Chữ ký không hợp lệ, xác thực thất bại");
            if (orderId > 0) {
                response.sendRedirect(request.getContextPath() + "/sign-order?orderId=" + orderId);
            } else {
                response.sendRedirect(request.getContextPath() + "/my-shopping-cart");
            }
        }
    }

}
