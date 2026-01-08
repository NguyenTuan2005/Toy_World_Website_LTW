package com.n3.childrentoyweb.dao;

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


}
