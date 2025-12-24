package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.RoleDAO;
import com.n3.childrentoyweb.enums.RoleEnum;

import java.util.List;

public class RoleService {
    private RoleDAO roleDAO;

    public List<RoleEnum> findAllByUserId(long userId){
        return this.roleDAO.findAllByUserId(userId);
    }
}
