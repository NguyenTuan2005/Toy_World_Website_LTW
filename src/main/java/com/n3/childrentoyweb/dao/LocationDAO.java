package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Location;

public class LocationDAO extends BaseDAO{


    public Location findByUserId(Long userId) {
        String sql = """
            SELECT l.id, l.address, l.province
            FROM locations l 
            JOIN users u ON l.id = u.location_id
            WHERE l.is_active = 1 AND u.id = :userId AND u.is_active = 1
        """;

        return super.getJdbi().withHandle(handle -> handle.createQuery(sql)
                        .bind("userId", userId)
                        .mapToBean(Location.class)
                        .findOne()
                        .orElse(null)
        );

    }

    public Long save(Location location) {
        String sql = """
        INSERT INTO locations (address, province)
        VALUES (:address, :province)
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("address", location.getAddress())
                        .bind("province", location.getProvince())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Long.class)
                        .one()
        );
    }

}
