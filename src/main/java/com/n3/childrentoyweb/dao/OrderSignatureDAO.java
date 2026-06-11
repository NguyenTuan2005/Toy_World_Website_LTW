package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.OrderSignature;

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

    public OrderSignature findOrderSignatureById(long orderId) {
        String sql = """
                    SELECT * 
                    FROM order_signatures 
                    WHERE order_id = :orderId AND is_active = 1
                    """;
        return this.getJdbi().withHandle(handle -> handle.createQuery(sql).bind("orderId", orderId).mapToBean(OrderSignature.class).one());
    }


}
