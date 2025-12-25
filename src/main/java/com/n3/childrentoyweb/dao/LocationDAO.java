package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.models.User;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

public class LocationDAO extends BaseDAO{


    public Location findByLocation(Long userId) {
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

    public static void main(String[] args) {
        System.out.println(new LocationDAO().findByLocation(1L));
    }

}
