package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dao.RoleDAO;
import com.n3.childrentoyweb.dao.UserDAO;
import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.dto.UserCriteria;
import com.n3.childrentoyweb.enums.RoleEnum;
import com.n3.childrentoyweb.exception.EmailAlreadyExistsException;
import com.n3.childrentoyweb.models.User;

import java.util.List;

public class UserService {
    private UserDAO userDAO;
    private RoleDAO roleDAO;

    public UserService() {
        this.userDAO = new UserDAO();
        this.roleDAO = new RoleDAO();
    }

    public void isEmailExist(String email) {
        if (userDAO.findByEmail(email) != null) {
            throw new EmailAlreadyExistsException("Email này đã tồn tại");
        }
    }

    public List<ManageUserDTO> findAllUserForManagement(int page, int pageSize){
        List<ManageUserDTO> manageUserDTOS = this.userDAO.findAllUserForManagement(page, pageSize);
        for(ManageUserDTO manageUserDTO : manageUserDTOS){
            String role = this.roleDAO.findAllByUserId(manageUserDTO.getUserId()).stream().filter(RoleEnum::isAdmin).map(Enum::toString).findFirst().get();
            manageUserDTO.setRole(role);
        }
        return manageUserDTOS;
    }

    public Pagination<ManageUserDTO> findAllUsersForManagements(int page, int pageSize){
        List<ManageUserDTO> manageUserDTOS = this.userDAO.findAllUserForManagement(page, pageSize);
        for(ManageUserDTO manageUserDTO : manageUserDTOS){
            String role = this.roleDAO.findAllByUserId(manageUserDTO.getUserId()).stream().map(RoleEnum::getRoleName).findFirst().orElse("USER");
            manageUserDTO.setRole(role);
        }
        int totalElements =this.userDAO.countAllUsers();
        int totalPages =  totalElements / pageSize;
        return  new Pagination<ManageUserDTO>(manageUserDTOS,page,totalElements,totalPages);
    }

    public void save(User user) {
        Long userId = userDAO.saveAndReturnId(user);
        roleDAO.assignRoleToUser(userId, 1L);
    }


    public Pagination<ManageUserDTO> findByCriteria(UserCriteria userCriteria){
        List<ManageUserDTO> manageUserDTOS = this.userDAO.findByCriteria(userCriteria);
        for(ManageUserDTO manageUserDTO : manageUserDTOS){
            String role = this.roleDAO.findAllByUserId(manageUserDTO.getUserId()).stream().filter(RoleEnum::isAdmin).map(RoleEnum::getRoleName).findFirst().orElse("USER");
            manageUserDTO.setRole(role);
        }
        int totalElements =this.userDAO.countAllUsers();
        int totalPages =  totalElements / 10;
        return  new Pagination<ManageUserDTO>(manageUserDTOS,10,totalElements,totalPages);
    }
}
