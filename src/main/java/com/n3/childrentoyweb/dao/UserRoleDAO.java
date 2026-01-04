package com.n3.childrentoyweb.dao;

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
}
