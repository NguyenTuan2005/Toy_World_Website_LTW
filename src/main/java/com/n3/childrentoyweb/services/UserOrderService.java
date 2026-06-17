package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderDetailDAO;
import com.n3.childrentoyweb.dao.OrderSignatureDAO;
import com.n3.childrentoyweb.dto.OrderItemDTO;
import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.dto.orderSignature.OrderSignatureDTO;
import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.enums.SignatureStatus;
import com.n3.childrentoyweb.exception.ForbiddenException;
import com.n3.childrentoyweb.exception.InvalidOrderStateException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Order;
import com.n3.childrentoyweb.models.OrderSignature;

import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

public class UserOrderService {
    private OrderDAO orderDAO;
    private OrderDetailDAO orderDetailDAO;
    private OrderSignatureDAO orderSignatureDAO;

    public UserOrderService() {
        this.orderDAO = new OrderDAO();
        this.orderDetailDAO = new OrderDetailDAO();
        this.orderSignatureDAO = new OrderSignatureDAO();
    }

    public List<UserOrderDTO> findOrdersByUserId(Long userId) {
        List<UserOrderDTO> orders = orderDAO.findOrdersByUserId(userId);

        for (UserOrderDTO order : orders) {
            List<OrderItemDTO> items = orderDetailDAO.findOrderItems(order.getId());
            order.setItems(items);
        }

        return orders;
    }

    public UserOrderDTO findOrdersByUserAndOrderId(Long userId, Long orderId) {
        UserOrderDTO order = orderDAO.findOrdersByUserAndOrderId(userId, orderId).orElseThrow(() -> new ObjectNotFoundException("Không tìm thấy đơn hàng"));
        List<OrderItemDTO> items = orderDetailDAO.findOrderItems(order.getId());
        order.setItems(items);
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
