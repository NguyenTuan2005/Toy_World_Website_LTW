package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.enums.RoleEnum;

import java.util.List;

public class RoleDAO extends BaseDAO{

    public List<RoleEnum> findAllByUserId(long userId){
        String sql = """
                    select r.role_name
                    from roles r
                    join user_roles ur ON r.id = ur.role_id
                    join users u on u.id = ur.user_id
                    where r.is_active = 1 and ur.is_active = 1 and u.is_active = 1 and u.id = :userId
                    """;
        return this.getJdbi().withHandle(handle -> handle.createQuery(sql)
                .bind("userId",userId)
                .map(rowView ->  RoleEnum.valueOf(rowView.getColumn(1,String.class))).list()
        );
    }

    public static void main(String[] args) {
        System.out.println(new RoleDAO().findAllByUserId(1L));
    }

    public List<Long> findAllRoleIdsByRoleName(String[] roles) {
        String sql = """
                        select r.id
                        from roles r
                        where r.role_name in (<roles>)
                    """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bindList("roles", roles)
                        .mapTo(Long.class)
                        .list()
        );
    }

    public Long findRoleIdByRoleName(RoleEnum role) {
        String sql = """
                        select r.id
                        from roles r
                        where r.role_name = :role
                    """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("role", role)
                        .mapTo(Long.class)
                        .one()
        );
    }


    public void assignRoleToUser(long userId, long roleId) {
        String sql = """
                Insert into user_roles (user_id, role_id)
                Values (:userId, :roleId)
                """;

        this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("userId", userId)
                        .bind("roleId", roleId)
                        .execute()
        );
    }
}
