package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.OrderDetailDTO;
import com.n3.childrentoyweb.dto.OrderItemDTO;

import java.util.List;
import java.util.Optional;

public class OrderDetailDAO extends BaseDAO {

    public Optional<OrderDetailDTO> findOrderDetail(Long orderId) {
        String sql = """
        
        SELECT
            o.id,
            u.id AS customerId,
            u.last_name AS customerLastName,
            u.first_name AS customerFirstName,
            u.email AS customerEmail,
            u.phone AS customerPhone,
            l.id AS locationId,
            l.address,
            l.province,
            o.created_at,
            o.status AS orderStatus,
            pay.status AS paymentStatus,
            o.total_price,
            COALESCE(o.discount_price, 0) AS discountPrice
        FROM orders o
        JOIN users u ON o.user_id = u.id
        JOIN locations l ON u.location_id = l.id
        JOIN payments pay ON o.id = pay.order_id
        WHERE o.id = :orderId
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .mapToBean(OrderDetailDTO.class)
                        .findOne()
        );
    }

    public List<OrderItemDTO> findOrderItems(Long orderId) {
        String sql = """
        SELECT
            od.product_id,
            p.name AS productName,
            (SELECT img_path 
             FROM product_assets 
             WHERE product_id = od.product_id 
             LIMIT 1) AS imgPath,
            p.price,
            od.quantity
        FROM order_details od
        JOIN products p ON od.product_id = p.id
        JOIN orders o ON od.order_id = o.id
        WHERE od.order_id = :orderId AND od.is_active = 1
        """;


        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .mapToBean(OrderItemDTO.class)
                        .list()
        );
    }


    public static void main(String[] args) {
        System.out.println(new OrderDetailDAO().findOrderDetail(1L));
    }

}
