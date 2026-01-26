package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderDetailDAO;
import com.n3.childrentoyweb.dto.OrderItemDTO;
import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.exception.ForbiddenException;
import com.n3.childrentoyweb.exception.InvalidOrderStateException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Order;

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


    public static void main(String[] args) {
        System.out.println(new UserOrderService().findOrdersByUserAndOrderId(2L, 57L));
        System.out.println(new UserOrderService().findOrdersByUserId(2L));
    }
}
