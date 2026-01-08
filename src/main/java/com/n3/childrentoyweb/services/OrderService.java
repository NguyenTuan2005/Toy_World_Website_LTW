package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderDetailDAO;
import com.n3.childrentoyweb.models.Order;
import com.n3.childrentoyweb.models.OrderDetail;

public class OrderService {
    private OrderDAO orderDAO;
    private OrderDetailDAO orderDetailDAO;


    public OrderService(){
        this.orderDAO = new OrderDAO();
        this.orderDetailDAO = new OrderDetailDAO();
    }

    public long countAllInMonth(int year, int month){
        return this.orderDAO.countAllInMonth(year, month);
    }

    public double calculateRevenueInMonth(int year, int month) {
        return this.orderDAO.calculateRevenueInMonth(year, month);
    }

    public long save(Order order) {
        return this.orderDAO.save(order);
    }

    public void saveOrderDetail(OrderDetail detail) {
        this.orderDAO.saveOrderDetail(detail);
    }
}
