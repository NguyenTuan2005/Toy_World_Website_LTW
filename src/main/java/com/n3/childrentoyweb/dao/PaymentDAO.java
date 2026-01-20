package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.enums.PaymentMethod;
import com.n3.childrentoyweb.models.Payment;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.List;

public class PaymentDAO  extends BaseDAO{
    public List<PaymentMethod> findAllPaymentMethod() {
        String sql = """
                select name
                from payment_methods
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .map(rowView -> PaymentMethod.fromName(rowView.getColumn(1, String.class)))
                        .list()
        );
    }

    public long findPaymentMethodIdByName(String paymentMethodName) {
        String sql = """
                select id
                from payment_methods
                where name = :name
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("name", paymentMethodName)
                        .mapTo(Long.class)
                        .one()
        );
    }

    public void save(Payment payment) {
        String sql = """
                insert into payments (payment_method_id, order_id, balance, status)
                values (:paymentMethodId, :orderId, :balance, :status)
                """;

        this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("paymentMethodId", payment.getPaymentMethodId())
                        .bind("orderId", payment.getOrderId())
                        .bind("balance", payment.getBalance())
                        .bind("status", payment.getStatus())
                        .execute()
        );
    }

    public Payment findByOrderId(Long id) {
        String sql = """
                SELECT id, 
                       payment_method_id AS paymentMethodId, 
                       order_id AS orderId, 
                       balance, 
                       status
                FROM payments
                WHERE order_id = :id
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .registerRowMapper( BeanMapper.factory(Payment.class))
                        .mapTo(Payment.class)
                        .one()
        );
    }

    public void update(Payment payment) {
        String sql = """
            UPDATE payments
            SET payment_method_id = :paymentMethodId,
                order_id = :orderId,
                balance = :balance,
                status = :status
            WHERE id = :id
            """;

        this.getJdbi().useHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(payment)
                        .execute()
        );
    }



}
