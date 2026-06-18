package com.n3.childrentoyweb.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.n3.childrentoyweb.dao.OrderDAO;
import com.n3.childrentoyweb.dao.OrderDetailDAO;
import com.n3.childrentoyweb.dao.OrderSignatureDAO;
import com.n3.childrentoyweb.dao.PublicKeyDAO;
import com.n3.childrentoyweb.dto.AdminOrderListDTO;
import com.n3.childrentoyweb.dto.OrderDetailDTO;
import com.n3.childrentoyweb.dto.orderSignature.OrderItemPayload;
import com.n3.childrentoyweb.exception.DataInvalidException;
import com.n3.childrentoyweb.models.OrderSignature;
import com.n3.childrentoyweb.dto.orderSignature.OrderSigningPayload;
import com.n3.childrentoyweb.enums.OrderStatus;
import com.n3.childrentoyweb.enums.SignatureStatus;
import com.n3.childrentoyweb.exception.InvalidOrderStateException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.*;
import com.n3.childrentoyweb.utils.JsonUtil;

import java.util.ArrayList;
import java.util.List;

public class OrderService {
    private static final int PAGE_SIZE = 10;
    private OrderDAO orderDAO;
    private PublicKeyDAO publicKeyDAO;
    private OrderSignatureDAO orderSignatureDAO;
    private OrderDetailDAO orderDetailDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
        this.publicKeyDAO = new PublicKeyDAO();
        this.orderSignatureDAO = new OrderSignatureDAO();
        this.orderDetailDAO = new OrderDetailDAO();
    }

    public List<AdminOrderListDTO> findAll(String searchKeyword, String sortType, int page) {
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

    public long countAllInMonth(int year, int month) {
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

    public int countAllOrders(int month) {
        return this.orderDAO.countOrdersByMonth(month);
    }

    public double sumRevenueByMonth(int month) {
        return this.orderDAO.sumRevenueByMonth(month);
    }

    public void deleteOrder(Long orderId) {
        Order order = orderDAO.findById(orderId);

        if (order == null) {
            throw new ObjectNotFoundException("Order không tồn tại");
        }

        if (order.getStatus().equals(OrderStatus.IN_PROCESS.getStatus())) {
            throw new InvalidOrderStateException("Đơn hàng đang giao, không thể xóa");
        }

        orderDAO.delete(orderId);
    }

    public long createOrder(User user, Cart cart) throws JsonProcessingException {

        Order order = new Order(
                user.getId(),
                cart.getTotalPrice(),
                cart.getTotalPromotion(),
                OrderStatus.PENDING.getStatus(),
                SignatureStatus.UNSIGNED.getStatus()
        );

        long orderId = orderDAO.save(order);

        List<OrderItemPayload> orderItemPayloads = new ArrayList<>();

        for (CartItem item : cart.getCartItems()) {

            OrderDetail detail = new OrderDetail(
                    orderId,
                    item.getProductId(),
                    item.getQuantity()
            );

            this.orderDAO.saveOrderDetail(detail);

            orderItemPayloads.add(new OrderItemPayload(item.getProductId(), item.getProductName(), item.getQuantity(), item.getUnitPrice(), item.getPromotionId()));
        }


        OrderSigningPayload orderSigningPayload = new OrderSigningPayload(orderId,
                user.getId(),
                cart.getTotalPrice(),
                orderItemPayloads);

        String orderPayload = JsonUtil.convertToJsonPayload(orderSigningPayload);



        long publicKeyId = publicKeyDAO.findLatestCreatePublicKeyIdByUserId(user.getId());

        OrderSignature orderSignature = new OrderSignature(orderId, publicKeyId, orderPayload,"SHA1withDSA");

        orderSignatureDAO.save(orderSignature);

        return orderId;
    }

    public String getOrderPayload(long orderId){
        return orderSignatureDAO.findOrderSignatureById(orderId).getOrderSigningPayload();
    }

    public OrderDetailDTO findOrderDetailForCheckout(long orderId, long currentUserId){

        OrderDetailDTO order = orderDetailDAO.findOrderDetail(orderId)
                .orElseThrow(() -> new ObjectNotFoundException("Đơn hàng không tồn tại"));

        order.setItems(orderDetailDAO.findOrderItems(orderId));

        if(order.getCustomerId() != currentUserId)
            throw new DataInvalidException("Người dùng không có quyền truy cập đơn hàng này");

        if(!OrderStatus.PENDING.getStatus().equals(order.getOrderStatus()))
            throw new DataInvalidException("Đơn hàng chưa sẵn sàng thanh toán");

        if(!order.isSigned())
            throw new DataInvalidException("Đơn hàng chưa có chữ ký điện tử");

        return order;
    }

}
