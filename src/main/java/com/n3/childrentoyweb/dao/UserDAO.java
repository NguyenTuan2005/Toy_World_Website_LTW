package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.User;

public class UserDAO extends BaseDAO {
    public User findByEmail(String email) {
        String sql = """
        select first_name, last_name, phone, gender, password, email, location_id
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
}
