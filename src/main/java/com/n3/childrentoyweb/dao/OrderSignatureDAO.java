package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.orderSignature.OrderItemPayload;
import com.n3.childrentoyweb.dto.orderSignature.OrderSignatureDTO;
import com.n3.childrentoyweb.dto.orderSignature.OrderSigningPayload;
import com.n3.childrentoyweb.models.OrderSignature;

import java.util.List;
import java.util.Optional;

public class OrderSignatureDAO extends BaseDAO{

    public long save(OrderSignature orderSignature) {
        String sql = """
                INSERT INTO order_signatures (order_id, public_key_id, order_signing_payload, algorithm)
                VALUES (:orderId, :publicKeyId, :orderSigningPayload, :algorithm)
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("orderId", orderSignature.getOrderId())
                        .bind("publicKeyId", orderSignature.getPublicKeyId())
                        .bind("orderSigningPayload", orderSignature.getOrderSigningPayload())
                        .bind("algorithm", orderSignature.getAlgorithm())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Long.class).one());
    }

    public void update(OrderSignature orderSignature) {
        String sql = """
        UPDATE order_signatures
        SET order_id = :orderId,
            public_key_id = :publicKeyId,
            order_signing_payload = :orderSigningPayload,
            algorithm = :algorithm,
            signature_value = :signatureValue
        WHERE id = :id
        """;

        this.getJdbi().useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("orderId", orderSignature.getOrderId())
                        .bind("publicKeyId", orderSignature.getPublicKeyId())
                        .bind("orderSigningPayload", orderSignature.getOrderSigningPayload())
                        .bind("algorithm", orderSignature.getAlgorithm())
                        .bind("signatureValue", orderSignature.getSignatureValue())
                        .bind("id", orderSignature.getId())
                        .execute()
        );
    }


    public OrderSignature findOrderSignatureById(long orderId) {
        String sql = """
                    SELECT * 
                    FROM order_signatures 
                    WHERE order_id = :orderId AND is_active = 1
                    """;
        return this.getJdbi().withHandle(handle -> handle.createQuery(sql).bind("orderId", orderId).mapToBean(OrderSignature.class).one());
    }

    public Optional<OrderSigningPayload> findOrderForSigning(Long orderId) {
        String sql = """
            SELECT
                o.id AS orderId,
                o.user_id AS userId,
                o.total_price AS totalPrice
            FROM orders o
            WHERE o.id = :orderId
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .mapToBean(OrderSigningPayload.class)
                        .findOne()
        );
    }

    public List<OrderItemPayload> findOrderItemsForSigning(Long orderId) {
        String sql = """
                 SELECT
                     p.id AS productId,
                     p.name AS productName,
                     od.quantity,
                     p.price AS unitPrice,
                     (
                         SELECT pm.id
                         FROM promotions pm
                         WHERE p.promotion_id =pm.id AND pm.created_at <= NOW() AND pm.expired_at >= NOW()
                     ) AS promotionId
                 FROM order_details od
                 JOIN products p ON p.id = od.product_id
                 WHERE od.order_id=:orderId
                 ORDER BY p.id
                
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .mapToBean(OrderItemPayload.class)
                        .list()
        );
    }

    public Optional<OrderSignatureDTO> findOrderSignatureByUserAndOrderId(Long userId, Long orderId) {
        String sql = """
            SELECT o.id AS orderId,
                   pubk.public_key,
                   sig.order_signing_payload,
                   sig.algorithm
      
            FROM orders o
            JOIN order_signatures sig ON o.id = sig.order_id
            JOIN public_keys pubk ON pubk.user_id = o.user_id AND sig.public_key_id = pubk.id
            WHERE o.user_id = :userId 
                    AND o.id = :orderId
                    AND o.is_active = 1
                    AND pubk.is_active = 1
            ORDER BY o.created_at DESC
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .bind("orderId", orderId)
                        .map((rs, ctx) -> {
                            OrderSignatureDTO dto = new OrderSignatureDTO();
                            dto.setOrderId(rs.getLong("orderId"));
                            dto.setPublicKey(rs.getString("public_key"));
                            dto.setOrderSigningPayload(rs.getString("order_signing_payload"));
                            dto.setAlgorithm(rs.getString("algorithm"));
                            return dto;
                        })
                        .findOne()
        );
    }

}
