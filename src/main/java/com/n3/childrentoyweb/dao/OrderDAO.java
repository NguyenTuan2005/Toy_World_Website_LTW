package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Order;
import com.n3.childrentoyweb.models.OrderDetail;

import java.time.LocalDate;

public class OrderDAO extends BaseDAO{

    public long countAllInMonth(int year, int month){
        String sql = """
                SELECT COUNT(*)
                FROM orders
                WHERE YEAR(created_at) = :year AND MONTH(created_at) = :month AND is_active = 1;
                    """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("year", year)
                        .bind("month", month)
                        .mapTo(Long.class)
                        .one()
        );
    }

    public double calculateRevenueInMonth(int year, int month) {
        String sql = """
            SELECT COALESCE(SUM(total_price), 0)
            FROM orders
            WHERE YEAR(created_at) = :year 
              AND MONTH(created_at) = :month 
              AND status != 'DA_HUY' 
              AND is_active = 1;
            """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("year", year)
                        .bind("month", month)
                        .mapTo(Double.class)
                        .one()
        );
    }


    public long save(Order order) {
        String sql = """
                insert into orders (user_id, total_price, status)
                values (:userId, :totalPrice, :status)
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("userId", order.getUserId())
                        .bind("totalPrice", order.getTotalPrice())
                        .bind("status", order.getStatus())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Long.class)
                        .one()
        );
    }

    public void saveOrderDetail(OrderDetail detail) {
        String sql = """
                insert into order_details (order_id, product_id, quantity)
                values (:orderId, :productId, :quantity)
                """;

        this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("orderId", detail.getOrderId())
                        .bind("productId", detail.getProductId())
                        .bind("quantity", detail.getQuantity())
                        .execute()
        );
    }

    public int countOrdersByMonth(int month) {

        LocalDate start = LocalDate.of(LocalDate.now().getYear(), month, 1);
        LocalDate end = start.plusMonths(1);

        String sql = """
        SELECT COUNT(*) 
        FROM orders
        WHERE created_at >= :start
        AND created_at < :end
    """;

        return getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("start", start.atStartOfDay())
                        .bind("end", end.atStartOfDay())
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public double sumRevenueByMonth(int month) {

        LocalDate start = LocalDate.of(LocalDate.now().getYear(), month, 1);
        LocalDate end = start.plusMonths(1);

        String sql = """
        SELECT COALESCE(SUM(total_price), 0)
        FROM orders
        WHERE created_at >= :start
        AND created_at < :end
    """;

        return getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("start", start.atStartOfDay())
                        .bind("end", end.atStartOfDay())
                        .mapTo(Double.class)
                        .one()
        );
    }


    public static void main(String[] args) {
        System.out.println(new OrderDAO().countOrdersByMonth(1));
    }

}
