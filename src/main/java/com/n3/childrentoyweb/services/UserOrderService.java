package com.n3.childrentoyweb.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderDetailDAO;
import com.n3.childrentoyweb.dto.OrderItemDTO;
import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.dto.orderSignature.OrderSignatureDTO;
import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.exception.ForbiddenException;
import com.n3.childrentoyweb.exception.InvalidOrderStateException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Order;

import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.List;

public class UserOrderService {

    private OrderDAO orderDAO;
    private OrderDetailDAO orderDetailDAO;

    public UserOrderService() {
        this.orderDAO = new OrderDAO();
        this.orderDetailDAO = new OrderDetailDAO();
    }

    public List<UserOrderDTO> findOrdersByUserId(Long userId) {
        List<UserOrderDTO> orders = orderDAO.findOrdersByUserId(userId);

        for (UserOrderDTO order : orders) {
            List<OrderItemDTO> items = orderDetailDAO.findOrderItems(order.getId());
            order.setItems(items);
        }

        return orders;
    }

    public List<UserOrderDTO> findOrdersByUserAndOrderId(Long userId, Long orderId) {
        List<UserOrderDTO> orders = orderDAO.findOrdersByUserAndOrderId(userId, orderId);

        for (UserOrderDTO order : orders) {
            List<OrderItemDTO> items = orderDetailDAO.findOrderItems(order.getId());
            order.setItems(items);
        }

        return orders;
    }

    public void cancelOrder(Long orderId, Long userId){

        Order order = orderDAO.findById(orderId);

        if (order == null)
            throw new ObjectNotFoundException("Order not found");

        if (!order.getUserId().equals(userId))
            throw new ForbiddenException("Không có quyền hủy đơn này");

        if (order.getStatus() == OrderStatus.COMPLETED.getStatus() || order.getStatus() == OrderStatus.IN_PROCESS.getStatus())
            throw new InvalidOrderStateException("Đơn hàng không thể hủy ở trạng thái hiện tại");

        order.setStatus(OrderStatus.CANCELED.getStatus());
        System.out.println(order.getStatus());
        orderDAO.update(order);
    }

    public OrderSignatureDTO findOrderWithSignatureByUserAndOrderId(Long userId, Long orderId){

        OrderSignatureDTO orderSignatureDTO = orderDAO.findOrderSignatureByUserAndOrderId(userId, orderId);
        return orderSignatureDTO;
    }

    public static void main(String[] args) {
        try {
            UserOrderService userOrderService = new UserOrderService();
            OrderSignatureDTO order = userOrderService.findOrderWithSignatureByUserAndOrderId(1L, 85L);


            String signingPayload = order.getOrderSigningPayload();
            String publicKeyBase64 = order.getPublicKey();
            String algorithm = order.getAlgorithm();

            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(publicKeyBase64));
            KeyFactory keyFactory = KeyFactory.getInstance("DSA");

            PublicKey publicKey = keyFactory.generatePublic(keySpec);


//            Part signaturePart = request.getPart("signatureFile");
//            String signatureBase64 = new String(signaturePart.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//            System.out.println("signatureBase64 len: " + signatureBase64.length());

            String signatureBase64 = "MCwCFAmzpjOGjuLtEEwlVfxtAKaV4uOMAhQXNdWHUZbu5vC3IYvkuZ/RqRJp1g==";

            Signature signature = Signature.getInstance(algorithm);
            signature.initVerify(publicKey);

            signature.update(signingPayload.getBytes());
            boolean isValid = signature.verify(Base64.getDecoder().decode(signatureBase64));

            if (isValid) {
                System.out.println("valid xác thực ôk skibidi");
            } else {
                System.out.println(" lỗi");
            }

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeySpecException e) {
            throw new RuntimeException(e);
        } catch (SignatureException e) {
            throw new RuntimeException(e);
        }catch (Exception e) {
            e.printStackTrace();
        }

    }

}
