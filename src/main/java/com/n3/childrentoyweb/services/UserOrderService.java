package com.n3.childrentoyweb.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderDetailDAO;
import com.n3.childrentoyweb.dao.OrderSignatureDAO;
import com.n3.childrentoyweb.dto.OrderItemDTO;
import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.enums.SignatureStatus;
import com.n3.childrentoyweb.exception.ForbiddenException;
import com.n3.childrentoyweb.exception.InvalidOrderStateException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Order;
import com.n3.childrentoyweb.models.OrderSignature;

import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.util.List;

public class UserOrderService {
    private OrderDAO orderDAO;
    private OrderDetailDAO orderDetailDAO;
    private OrderSignatureDAO orderSignatureDAO;
    private OrderSignatureService orderSignatureService;

    public UserOrderService() {
        this.orderDAO = new OrderDAO();
        this.orderDetailDAO = new OrderDetailDAO();
        this.orderSignatureDAO = new OrderSignatureDAO();
        this.orderSignatureService = new OrderSignatureService(this.orderSignatureDAO, this.orderDAO);
    }

    public List<UserOrderDTO> findOrdersByUserId(Long userId) throws NoSuchAlgorithmException, InvalidKeySpecException, SignatureException, InvalidKeyException, JsonProcessingException {
        List<UserOrderDTO> orders = orderDAO.findOrdersByUserId(userId);

        for (UserOrderDTO order : orders) {
            order.setItems(orderDetailDAO.findOrderItems(order.getId()));

            boolean isSigned = false;
            if (order.isSigned()) {
                OrderSignature sig = orderSignatureDAO.findOrderSignatureById(order.getId());
                isSigned = (sig != null) && orderSignatureService.verifyOrder(userId, order.getId(), sig.getSignatureValue());
            }

            order.setSignatureStatus(isSigned ? SignatureStatus.SIGNED.getStatus() : SignatureStatus.UNSIGNED.getStatus());
        }

        return orders;
    }

    public UserOrderDTO findOrdersByUserAndOrderId(Long userId, Long orderId) throws NoSuchAlgorithmException, InvalidKeySpecException, SignatureException, InvalidKeyException, JsonProcessingException {
        UserOrderDTO order = orderDAO.findOrdersByUserAndOrderId(userId, orderId).orElseThrow(() -> new ObjectNotFoundException("Không tìm thấy đơn hàng"));
        List<OrderItemDTO> items = orderDetailDAO.findOrderItems(order.getId());
        order.setItems(items);

        boolean isSigned = false;
        if (order.isSigned()) {
            OrderSignature sig = orderSignatureDAO.findOrderSignatureById(order.getId());
            isSigned = (sig != null) && orderSignatureService.verifyOrder(userId, order.getId(), sig.getSignatureValue());
        }

        order.setSignatureStatus(isSigned ? SignatureStatus.SIGNED.getStatus() : SignatureStatus.UNSIGNED.getStatus());

        return order;
    }

    public void cancelOrder(Long orderId, Long userId){

        Order order = orderDAO.findById(orderId);

        if (order == null)
            throw new ObjectNotFoundException("Không tìm thấy đơn hàng");

        if (!order.getUserId().equals(userId))
            throw new ForbiddenException("Không có quyền hủy đơn này");

        if (order.getStatus() == OrderStatus.COMPLETED.getStatus() || order.getStatus() == OrderStatus.IN_PROCESS.getStatus())
            throw new InvalidOrderStateException("Đơn hàng không thể hủy ở trạng thái hiện tại");

        order.setStatus(OrderStatus.CANCELED.getStatus());
        orderDAO.update(order);
    }


    public void updateOrderSignatureStatus(Long userId, Long orderId, SignatureStatus signatureStatus, String signatureBase64){
        Order order = orderDAO.findById(orderId);

        if (order == null)
            throw new ObjectNotFoundException("Không tìm thấy đơn hàng");

        if (!order.getUserId().equals(userId))
            throw new ForbiddenException("Người dùng không có quyền cập nhật đơn này");

        order.setSignatureStatus(signatureStatus.getStatus());
        orderDAO.update(order);


        OrderSignature orderSignature = orderSignatureDAO.findOrderSignatureById(orderId);
        orderSignature.setSignatureValue(signatureBase64);
        orderSignatureDAO.update(orderSignature);

    }




}
