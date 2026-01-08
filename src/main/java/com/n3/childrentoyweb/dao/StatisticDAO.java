package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.OrderStatusStatDTO;
import com.n3.childrentoyweb.dto.ProductStockStatDTO;
import com.n3.childrentoyweb.dto.OrderAnalyticsDTO;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.time.LocalDate;
import java.util.List;

public class StatisticDAO extends BaseDAO{

    //revenue statistic
    public List<OrderAnalyticsDTO> revenueByDay(LocalDate from, LocalDate to) {

        String sql = """
        SELECT
            DATE(created_at) AS label,
            SUM(total_price) AS `value`
        FROM orders
        WHERE created_at >= :from
          AND created_at < :to
          AND status != 'DA_HUY'
          AND is_active = 1
        GROUP BY DATE(created_at)
        ORDER BY label
        """;

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("from", from.atStartOfDay())
                        .bind("to", to.atStartOfDay())
                        .registerRowMapper(BeanMapper.factory(OrderAnalyticsDTO.class))
                        .mapTo(OrderAnalyticsDTO.class)
                        .list()
        );
    }

    public List<OrderAnalyticsDTO> revenueByMonth(LocalDate from, LocalDate to) {
        String sql = """
        SELECT
            DATE_FORMAT(created_at, '%Y-%m') AS label,
            SUM(total_price) AS `value`
        FROM orders
        WHERE created_at >= :from
          AND created_at < :to
          AND status != 'DA_HUY'
          AND is_active = 1
        GROUP BY DATE_FORMAT(created_at, '%Y-%m')
        ORDER BY label
        """;

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("from", from.atStartOfDay())
                        .bind("to", to.atStartOfDay())
                        .registerRowMapper(BeanMapper.factory(OrderAnalyticsDTO.class))
                        .mapTo(OrderAnalyticsDTO.class)
                        .list()
        );
    }

    //order statistic
    public List<OrderAnalyticsDTO> orderByDay(LocalDate from, LocalDate to) {
        String sql = """
        SELECT
            DATE(created_at) AS label,
            COUNT(*) AS `value`
        FROM orders
        WHERE created_at >= :from
          AND created_at < :to
          AND status != 'DA_HUY'
          AND is_active = 1
        GROUP BY DATE(created_at)
        ORDER BY label
        """;

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("from", from.atStartOfDay())
                        .bind("to", to.atStartOfDay())
                        .registerRowMapper(BeanMapper.factory(OrderAnalyticsDTO.class))
                        .mapTo(OrderAnalyticsDTO.class)
                        .list()
        );
    }


    public List<OrderAnalyticsDTO> orderByMonth(LocalDate from, LocalDate to) {
        String sql = """
        SELECT
            DATE_FORMAT(created_at, '%Y-%m') AS label,
            COUNT(*) AS `value`
        FROM orders
        WHERE created_at >= :from
          AND created_at < :to
          AND status != 'DA_HUY'
          AND is_active = 1
        GROUP BY DATE_FORMAT(created_at, '%Y-%m')
        ORDER BY label
        """;

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("from", from.atStartOfDay())
                        .bind("to", to.atStartOfDay())
                        .registerRowMapper(BeanMapper.factory(OrderAnalyticsDTO.class))
                        .mapTo(OrderAnalyticsDTO.class)
                        .list()
        );
    }

    public List<ProductStockStatDTO> topStockProduct(int limit, String order){
        String sql = """
                SELECT id, name, quantity
                FROM products
                WHERE is_active = 1
                ORDER BY quantity %s
                LIMIT :limit
                """.formatted(order);;

        return this.getJdbi().withHandle( handle ->
                handle.createQuery(sql)
                        .bind("limit", limit)
                        .registerRowMapper(BeanMapper.factory(ProductStockStatDTO.class))
                        .mapTo(ProductStockStatDTO.class)
                        .list());
    }

    public List<OrderStatusStatDTO> countOrderByStatusPerDay(LocalDate fromDate, LocalDate toDate) {
        String sql = """
            SELECT 
                CAST(created_at AS DATE) AS label,
                status,
                COUNT(*) AS total
            FROM orders
            WHERE created_at >= :fromDate
                AND created_at < :toDate
                AND is_active = 1
            GROUP BY CAST(created_at AS DATE), status
            ORDER BY label
        """;

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("fromDate", fromDate)
                        .bind("toDate", toDate)
                        .registerRowMapper(BeanMapper.factory(OrderStatusStatDTO.class))
                        .mapTo(OrderStatusStatDTO.class)
                        .list()
        );
    }



    public static void main(String[] args) {
        System.out.println(new StatisticDAO().orderByDay(LocalDate.of(2026, 1, 1), LocalDate.of(2026, 1, 7)));
    }
}
