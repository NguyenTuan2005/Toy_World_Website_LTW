package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderDetailDAO;
import com.n3.childrentoyweb.dto.AdminOrderListDTO;
import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.exception.InvalidOrderStateException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Order;
import com.n3.childrentoyweb.models.OrderDetail;

import java.util.List;
import java.util.Optional;

public class OrderService {
    private static final int PAGE_SIZE = 10;
    private OrderDAO orderDAO;


    public OrderService(){
        this.orderDAO = new OrderDAO();
    }

    public List<AdminOrderListDTO> findAll(String searchKeyword, String sortType, int page){
        if (page < 1) page = 1;
        int offset = (page - 1) * PAGE_SIZE;

        String orderBy = buildOrderBy(sortType);

        String where = "";
        String searchKeywordParam = null;

        if (searchKeyword != null && !searchKeyword.isBlank()) {
            where = buildSearchWhere(searchKeyword);
            searchKeywordParam = "%" + searchKeyword.trim() + "%";
        }

        return this.orderDAO.findAll(searchKeywordParam, where, orderBy, PAGE_SIZE, offset);
    }

    private String buildSearchWhere(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return "";
        }
        return """
        AND (
            o.id LIKE :kw
            OR u.email LIKE :kw
            OR u.phone LIKE :kw
            OR CONCAT(u.last_name, ' ', u.first_name) LIKE :kw
        )
    """;
    }

    private String buildOrderBy(String sort) {
        return switch (sort) {
            case "processing" -> "o.status = 'CHUAN_BI_HANG' DESC";
            case "shipping" -> "o.status = 'DANG_GIAO' DESC";
            case "delivered" -> "o.status = 'DA_GIAO' DESC";
            case "cancelled" -> "o.status = 'DA_HUY' DESC";
            case "paid" -> "p.status = 'DA_THANH_TOAN' DESC";
            case "unpaid" -> "p.status = 'CHUA_THANH_TOAN' DESC";
            case "price_desc" -> "o.total_price DESC";
            case "price_asc" -> "o.total_price ASC";
            default -> "o.created_at DESC";
        };
    }

    public int countAll() {
        return orderDAO.countAll();
    }

    public int getTotalPages() {
        int totalItems = countAll();
        return (int) Math.ceil((double) totalItems / PAGE_SIZE);
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

    public void deleteOrder(Long orderId) {
        Order order = orderDAO.findById(orderId);

        if (order==null) {
            throw new ObjectNotFoundException("Order không tồn tại");
        }

        if (order.getStatus().equals(OrderStatus.IN_PROCESS.getStatus())) {
            throw new InvalidOrderStateException("Đơn hàng đang giao, không thể xóa");
        }

        orderDAO.delete(orderId);
    }

}
