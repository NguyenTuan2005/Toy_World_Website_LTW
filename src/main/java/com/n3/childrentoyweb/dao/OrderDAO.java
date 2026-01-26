package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.AdminOrderListDTO;
import com.n3.childrentoyweb.dto.UserOrderDTO;
import com.n3.childrentoyweb.models.Order;
import com.n3.childrentoyweb.models.OrderDetail;
import java.time.LocalDate;
import java.util.List;

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
                insert into orders (user_id, total_price, discount_price, status)
                values (:userId, :totalPrice, :discount_price, :status)
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("userId", order.getUserId())
                        .bind("totalPrice", order.getTotalPrice())
                        .bind("discount_price", order.getDiscountPrice())
                        .bind("status", order.getStatus())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Long.class).one());
    }

    public void update(Order order) {
        String sql = """
        UPDATE orders
        SET status = :orderStatus,
            created_at = :createdAt
        WHERE id = :id
        """;

        this.getJdbi().useHandle(h ->
                h.createUpdate(sql)
                        .bind("id", order.getId())
                        .bind("orderStatus", order.getStatus())
                        .bind("createdAt", order.getCreatedAt())
                        .execute()
        );
    }

    public void saveOrderDetail(OrderDetail detail) {
        String sql = """
                insert into order_details (order_id, product_id, quantity)
                values (:orderId, :productId, :quantity)
                """;

        this.getJdbi().withHandle(handle -> handle.createUpdate(sql).bind("orderId", detail.getOrderId()).bind("productId", detail.getProductId()).bind("quantity", detail.getQuantity()).execute());
    }

    public List<AdminOrderListDTO> findAll(String searchKeyword, String where, String orderBy, int pageSize, int offset) {
        String sql = """
                    SELECT o.id,
                           CONCAT(u.last_name, ' ', u.first_name) AS customerName,
                           u.email AS customerEmail,
                           u.phone AS customerPhoneNumber,
                           o.created_at AS createdAt,
                           o.status AS orderStatus,
                           p.status AS paymentStatus,
                           o.total_price AS totalPrice
                    FROM orders o
                    JOIN users u ON o.user_id = u.id
                    JOIN payments p ON o.id = p.order_id
                    WHERE o.is_active = 1 %s
                    ORDER BY %s
                    LIMIT :limit OFFSET :offset;
                """.formatted(where, orderBy);

        return this.getJdbi().withHandle(handle -> {
            var q = handle.createQuery(sql)
                    .bind("limit", pageSize)
                    .bind("offset", offset);

            if (searchKeyword != null) {
                q.bind("kw", searchKeyword);
            }
            return q.mapToBean(AdminOrderListDTO.class).list();
        });
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM orders WHERE is_active = 1";

        return this.getJdbi().withHandle(handle -> handle.createQuery(sql).mapTo(Integer.class).one());
    }

    public Order findById(long id) {
        String sql = "SELECT * FROM orders WHERE id = :id AND is_active = 1";
        return this.getJdbi().withHandle(handle -> handle.createQuery(sql).bind("id", id).mapToBean(Order.class).one());
    }

    public boolean delete(Long orderId) {
        String sql = """
            UPDATE orders
            SET is_active = 0
            WHERE id = :id
              AND is_active = 1
        """;

        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", orderId)
                        .execute() > 0
        );
    }

    public List<UserOrderDTO> findOrdersByUserId(Long userId) {
        String sql = """
            SELECT o.id,
                   o.status AS orderStatus,
                   p.status AS paymentStatus,
                   o.created_at,
                   o.total_price
            FROM orders o
            JOIN payments p ON o.id = p.order_id
            WHERE o.user_id = :userId AND o.is_active = 1
            ORDER BY o.created_at DESC
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .map((rs, ctx) -> {
                            UserOrderDTO dto = new UserOrderDTO();
                            dto.setId(rs.getLong("id"));
                            dto.setOrderStatus(rs.getString("orderStatus"));
                            dto.setPaymentStatus(rs.getString("paymentStatus"));
                            dto.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                            dto.setTotalPrice(rs.getLong("total_price"));
                            return dto;
                        })
                        .list()
        );
    }

    public List<UserOrderDTO> findOrdersByUserAndOrderId(Long userId, Long orderId) {
        String sql = """
            SELECT o.id,
                   o.status AS orderStatus,
                   p.status AS paymentStatus,
                   o.created_at,
                   o.total_price
            FROM orders o
            JOIN payments p ON o.id = p.order_id
            WHERE o.user_id = :userId 
                    AND o.id = :orderId
                    AND o.is_active = 1
            ORDER BY o.created_at DESC
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .bind("orderId", orderId)
                        .map((rs, ctx) -> {
                            UserOrderDTO dto = new UserOrderDTO();
                            dto.setId(rs.getLong("id"));
                            dto.setOrderStatus(rs.getString("orderStatus"));
                            dto.setPaymentStatus(rs.getString("paymentStatus"));
                            dto.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                            dto.setTotalPrice(rs.getLong("total_price"));
                            return dto;
                        })
                        .list()
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
}
