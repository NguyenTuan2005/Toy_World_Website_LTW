package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.dto.UserCriteria;
import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import com.n3.childrentoyweb.utils.MD5Util;
import java.util.List;

public class UserDAO extends BaseDAO {

    public User findByEmail(String email) {
        String sql = """
        select id, first_name, last_name, phone, gender, password, email, location_id
        from users
        where email = :email AND is_active = 1
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("email", email)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public List<ManageUserDTO> findAllUserForManagement(int page, int pageSize){
        int offset = (page - 1) * pageSize;
        String sql = """
                select
                    u.id,
                    u.email,
                    u.first_name,
                    u.last_name,
                    u.phone,
                    u.gender,
                    l.province,
                    u.created_at,
                    u.is_active
                from users u
                join locations l on l.id = u.location_id
                where  l.is_active = 1
                order by u.created_at
                limit :limit offset :offsets
                """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit",pageSize)
                        .bind("offsets",offset)
                        .map((rs, ctx) -> {
                            ManageUserDTO manageUserDTO = new ManageUserDTO();
                            manageUserDTO.setUserId(rs.getLong("id"));
                            manageUserDTO.setFirstName(rs.getString("first_name"));
                            manageUserDTO.setLastName(rs.getString("last_name"));
                            manageUserDTO.setSex(rs.getString("gender"));
                            manageUserDTO.setProvince(rs.getString("province"));
                            manageUserDTO.setEmail(rs.getString("email"));
                            manageUserDTO.setPhone(rs.getString("phone"));
                            manageUserDTO.setActive(rs.getBoolean("is_active"));
                            manageUserDTO.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                            return manageUserDTO;
                        })
                        .list()
        );
    }

    public int countAllUsers(){
        String sql = """
                select count(u.id)
                from users u
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(int.class)
                        .one()
        );
    }

    public int countAllInMonth(int year, int month){
        String sql = """
                SELECT COUNT(u.id)
                FROM users u
                JOIN user_roles ur ON u.id = ur.user_id 
                                    AND ur.is_active = 1
                WHERE YEAR(u.created_at) = :year 
                    AND MONTH(u.created_at) = :month 
                    AND u.is_active = 1
                    AND ur.role_id = 1;
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("year", year)
                        .bind("month", month)
                        .mapTo(int.class)
                        .one()
        );
    }

    public long save(User user) {
        String sql = """
            Insert into users (first_name, last_name, phone, gender, password, email, location_id)
            Values (:firstName, :lastName, :phone, :gender, :password, :email, :locationId) 
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("firstName", user.getFirstName())
                        .bind("lastName", user.getLastName())
                        .bind("phone", user.getPhone())
                        .bind("gender", user.getGender())
                        .bind("email", user.getEmail())
                        .bind("password", MD5Util.encryptMd5(user.getPassword()))
                        .bind("locationId", user.getLocationId())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Long.class)
                        .one()
                );
    }

    public List<ManageUserDTO> findByCriteria(UserCriteria userCriteria) {

        StringBuilder sql = new StringBuilder("""
                    select
                    u.id,
                    u.email,
                    u.first_name,
                    u.last_name,
                    u.phone,
                    u.gender,
                    l.province,
                    u.created_at,
                    u.is_active
                from users u
                join locations l on l.id = u.location_id
                where  1 = 1
                """);

        sql.append(userCriteria.getIdForSql());
        sql.append(userCriteria.getPhoneForSql());
        sql.append(userCriteria.getFullNameForSql());
        sql.append(userCriteria.getEmailForSql());
        sql.append(" limit 10");



        System.out.println(sql);
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .map((rs, ctx) -> {
                            ManageUserDTO manageUserDTO = new ManageUserDTO();
                            manageUserDTO.setUserId(rs.getLong("id"));
                            manageUserDTO.setFirstName(rs.getString("first_name"));
                            manageUserDTO.setLastName(rs.getString("last_name"));
                            manageUserDTO.setSex(rs.getString("gender"));
                            manageUserDTO.setProvince(rs.getString("province"));
                            manageUserDTO.setEmail(rs.getString("email"));
                            manageUserDTO.setPhone(rs.getString("phone"));
                            manageUserDTO.setActive(rs.getBoolean("is_active"));
                            manageUserDTO.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                            return manageUserDTO;
                        })
                        .list());
    }


    public boolean delete(long id){
        return this.getJdbi().withHandle(handle ->
                handle.createUpdate("""
                                            UPDATE users
                                            SET is_active = 0
                                            WHERE id = :id
                                        """)
                        .bind("id", id)
                        .execute()
                ) > 0;
    }

    public boolean activeUser(long id) {
        return this.getJdbi().withHandle(handle ->
                handle.createUpdate("""
                                            UPDATE users
                                            SET is_active = 1
                                            WHERE id = :id
                                        """)
                        .bind("id", id)
                        .execute()
        ) > 0;
    }

    public User findById(long id){
        String sql = """
        select id, first_name, last_name, phone, gender, password, email, location_id, is_active, created_at
        from users
        where id = :id
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            User user = new User();
                            user.setId(rs.getLong("id"));
                            user.setFirstName(rs.getString("first_name"));
                            user.setLastName(rs.getString("last_name"));
                            user.setPhone(rs.getString("phone"));
                            user.setPassword(rs.getString("password"));
                            user.setGender(rs.getString("gender"));
                            user.setEmail(rs.getString("email"));
                            user.setLocationId(rs.getLong("location_id"));
                            user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                            user.setActive(rs.getBoolean("is_active"));
                            return user;
                        })
                        .findOne()
                        .orElse(null)
        );
    }


    public void update(User user) {
            String sql = """
                            UPDATE users
                            SET first_name  = :firstName,
                                last_name   = :lastName,
                                phone       = :phone,
                                gender      = :gender,
                                password    = :password,
                                email       = :email,
                                is_active   = :isActive,
                                location_id = :locationId
                            WHERE id = :id
                        """;

             this.getJdbi().withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("id", user.getId())
                            .bind("firstName", user.getFirstName())
                            .bind("lastName", user.getLastName())
                            .bind("phone", user.getPhone())
                            .bind("gender", user.getGender())
                            .bind("password", user.getPassword())
                            .bind("email", user.getEmail())
                            .bind("locationId",user.getLocationId())
                            .bind("isActive",user.getActive())
                            .execute()
            );
    }
    public int countAllAdmins() {
        String sql = """
                        select count(ur.id)
                        from user_roles ur
                                 join roles r on ur.role_id = r.id
                        where r.role_name = 'ROLE_ADMIN'
                          and r.is_active = 1
                          and ur.is_active = 1
                    """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public int countNewUsersInMonth() {
        String sql = """
                select  count(u.id)
                from users u
                where u.created_at >= DATE_FORMAT(NOW(), '%Y-%m-01')
                  AND u.created_at <  DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 1 MONTH);
                    """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }



    public void createNewUser(User user, Location location, List<Long> roles) {

        this.getJdbi().useTransaction(handle -> {

            Long locationId = handle.createUpdate("""
                INSERT INTO locations (address, province)
                VALUES (:address, :province)
                """)
                    .bind("address", location.getAddress())
                    .bind("province", location.getProvince())
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Long.class)
                    .one();

            System.out.println("location Id : "+ locationId);

            Long userId = handle.createUpdate("""
                INSERT INTO users (first_name, last_name, phone, gender, password, email, location_id)
                VALUES (:firstName, :lastName, :phone, :gender, :password, :email, :locationId)
                """)
                    .bindBean(user)
                    .bind("locationId", locationId)
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Long.class)
                    .one();

            System.out.println("user id : "+ userId);
            for (Long roleId : roles) {
                handle.createUpdate("""
                    INSERT INTO user_roles (user_id, role_id)
                    VALUES (:userId, :roleId)
                    """)
                        .bind("userId", userId)
                        .bind("roleId", roleId)
                        .execute();
            }

        });
    }

    public void updateLocation(User user, Location location) {
        String sql = """
                update users
                set location_id = :locationId
                where id = :userId
                """;

        this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("locationId", location.getId())
                        .bind("userId", user.getId())
                        .execute()
        );
    }
}
