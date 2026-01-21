package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.*;
import com.n3.childrentoyweb.dto.OrderDetailDTO;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.Order;
import com.n3.childrentoyweb.models.Payment;
import com.n3.childrentoyweb.models.User;

public class OrderDetailService {
    private OrderDetailDAO orderDetailDAO;
    private OrderDAO orderDAO;
    private UserDAO userDAO;
    private LocationDAO locationDAO;
    private PaymentDAO paymentDAO;

    public OrderDetailService() {
        orderDetailDAO = new OrderDetailDAO();
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
        locationDAO = new LocationDAO();
        paymentDAO = new PaymentDAO();
    }

    public OrderDetailDTO findOrderDetail(Long orderId) {
        OrderDetailDTO order = orderDetailDAO.findOrderDetail(orderId)
                .orElseThrow(() -> new ObjectNotFoundException("Order Details not found"));

        order.setItems(orderDetailDAO.findOrderItems(orderId));
        return order;
    }


    public void updateOrderDetail(OrderDetailDTO orderDetail) {
        Order order = orderDAO.findById(orderDetail.getId());
        if (order == null)
            throw new ObjectNotFoundException("Không tìm thấy đơn hàng");

        order.setStatus(orderDetail.getOrderStatus());
        order.setCreatedAt(orderDetail.getCreatedAt());
        orderDAO.update(order);


        User customer = userDAO.findById(orderDetail.getCustomerId());
        if (customer == null)
            throw new ObjectNotFoundException("Không tìm thấy người dùng");

        customer.setFirstName(orderDetail.getCustomerFirstName());
        customer.setLastName(orderDetail.getCustomerLastName());
        customer.setEmail(orderDetail.getCustomerEmail());
        customer.setPhone(orderDetail.getCustomerPhone());
        userDAO.update(customer);


        Location location = locationDAO.findById(orderDetail.getLocationId());
        if (location == null)
            throw new ObjectNotFoundException("Không tìm thấy địa chỉ");

        location.setAddress(orderDetail.getAddress());
        location.setProvince(orderDetail.getProvince());
        locationDAO.update(location);

        Payment payment = paymentDAO.findByOrderId(orderDetail.getId());
        if (payment == null)
            throw new ObjectNotFoundException("Không tìm thấy thông tin thanh toán");

        payment.setStatus(orderDetail.getPaymentStatus());
        paymentDAO.update(payment);
    }
}
