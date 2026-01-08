package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.enums.RoleEnum;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.UserRole;

public class UserRoleDAO extends  BaseDAO{

    public void save(UserRole userRole){
     this.getJdbi().withHandle(handle ->    handle.createUpdate("""
                    INSERT INTO user_roles (user_id, role_id)
                    VALUES (:userId, :roleId)
                    """)
                .bind("userId", userRole.getUserId())
                .bind("roleId", userRole.getRoleId())
                .execute());
    }

    public long findId(String roleName) {
        String sql = """
                select id
                from roles
                where role_name = :roleName
                """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("roleName", roleName)
                        .mapTo(Long.class)
                        .findOne()
                        .orElseThrow(() -> new ObjectNotFoundException("Không tìm thấy giá trị id cho role tên : " + roleName)));
    }
}
