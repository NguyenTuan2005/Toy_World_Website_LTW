package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.utils.MD5Util;

public class UserDAO extends BaseDAO {

    public User findByEmail(String email) {
        String sql = """
        select id, first_name, last_name, phone, gender, password, email, location_id
        from users
        where email = :email
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("email", email)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public void save(User user) {
        String sql = """
            Insert into user (first_name, last_name, phone, gender, password, email, location_id)
            Values (:firstName, :lastName, :phone, :gender, :password, :email, :locationId) 
        """;

        super.getJdbi().useHandle(handle ->
                handle.createQuery(sql)
                        .bind("firstName", user.getFirstName())
                        .bind("lastName", user.getLastName())
                        .bind("phone", user.getPhone())
                        .bind("gender", user.getGender())
                        .bind("email", user.getEmail())
                        .bind("password", MD5Util.md5HashToString(user.getPassword()))
                        .bind("locationId", user.getLocationId())
                );
    }
}
