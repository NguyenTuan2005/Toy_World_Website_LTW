package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.*;
import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.dto.UserCriteria;
import com.n3.childrentoyweb.dto.UserDetailDTO;
import com.n3.childrentoyweb.enums.RoleEnum;
import com.n3.childrentoyweb.exception.EmailAlreadyExistsException;
import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.models.UserRole;
import com.n3.childrentoyweb.utils.MD5Util;

import java.util.List;
import java.util.Optional;

public class UserService {
    private UserDAO userDAO;
    private RoleDAO roleDAO;
    private LocationDAO locationDAO;
    private UserRoleDAO userRoleDAO;

    public UserService() {
        this.userDAO = new UserDAO();
        this.roleDAO = new RoleDAO();
        this.locationDAO = new LocationDAO();
    }

    public void isEmailExist(String email) {
        if (userDAO.findByEmail(email) != null) {
            throw new EmailAlreadyExistsException("Email này đã tồn tại");
        }
    }


    public Pagination<ManageUserDTO> findAllUsersForManagements(int page, int pageSize) {
        List<ManageUserDTO> manageUserDTOS = this.userDAO.findAllUserForManagement(page, pageSize);
        for (ManageUserDTO manageUserDTO : manageUserDTOS) {
            String role = this.roleDAO.findAllByUserId(manageUserDTO.getUserId()).stream().map(RoleEnum::getRoleName).findFirst().orElse("USER");
            manageUserDTO.setRole(role);
        }
        int totalElements = this.userDAO.countAllUsers();
        int totalPages = totalElements / pageSize;
        return new Pagination<ManageUserDTO>(manageUserDTOS, page, totalElements, totalPages);
    }

    public void save(User user) {
        long userId = userDAO.saveAndReturnId(user);
        roleDAO.assignRoleToUser(userId, RoleEnum.ROLE_USER.getRoleId());
    }


    public Pagination<ManageUserDTO> findByCriteria(UserCriteria userCriteria) {
        List<ManageUserDTO> manageUserDTOS = this.userDAO.findByCriteria(userCriteria);
        for (ManageUserDTO manageUserDTO : manageUserDTOS) {
            String role = this.roleDAO.findAllByUserId(manageUserDTO.getUserId()).stream().filter(RoleEnum::isAdmin).map(RoleEnum::getRoleName).findFirst().orElse("USER");
            manageUserDTO.setRole(role);
        }
        int totalElements = this.userDAO.countAllUsers();
        int totalPages = totalElements / 10;
        return new Pagination<ManageUserDTO>(manageUserDTOS, 10, totalElements, totalPages);
    }


    public boolean delete(long id) {
        return this.userDAO.delete(id);
    }

    public boolean activeUser(long id) {
        return this.userDAO.activeUser(id);
    }

    public void update(User user) {
        this.userDAO.update(user);
    }

    public UserDetailDTO findUserDetailById(long id) {
        User user = this.userDAO.findById(id);
        Location location = this.locationDAO.findByUserId(id);
        String role = this.roleDAO.findAllByUserId(id).stream().filter(RoleEnum::isAdmin).map(RoleEnum::getRoleName).findFirst().orElse("user");
        return new UserDetailDTO(user, location, role);
    }

    public Optional<User> findById(long id) {
        return Optional.ofNullable(this.userDAO.findById(id));
    }

    public int countAllUsers() {
        return this.userDAO.countAllUsers();
    }

    public int countAllAdmins() {
        return this.userDAO.countAllAdmins();
    }

    public int countNewUsersInMonth() {
        return this.userDAO.countNewUsersInMonth();
    }

    public void createNewUser(User user, Location location, String[] roles) {
        List<Long> roleIds = this.roleDAO.findAllRoleIdsByRoleName(roles);
        this.userDAO.createNewUser(user, location, roleIds);
    }

    public void updateUser(User user, Location location, String[] roles) {
        User oldUser = this.findById(user.getId()).orElseThrow(ObjectNotFoundException::new);
        boolean isChangePassword = !oldUser.getPassword().equals(user.getPassword());

        if (isChangePassword) {
            String passwordEncoded = MD5Util.encryptMd5(user.getPassword());
            user.setPassword(passwordEncoded);
        }

        user.setLocationId(user.getLocationId());

        Location oldLocation = this.locationDAO.findByUserId(user.getLocationId());
        boolean isChangeLocation  = oldLocation == null || !oldLocation.equal(location);

        System.out.println("Change location "+isChangeLocation);

        if (isChangeLocation) {
            System.out.println("Change location "+location);
            Long locationId = this.locationDAO.save(location);
            System.out.println("locationId new " +locationId);
            user.setLocationId(locationId);
        }
        System.out.println("updated "+user);
        this.userDAO.update(user);

        List<RoleEnum> roleEnums = this.roleDAO.findAllByUserId(user.getId());
        boolean isAdmin = roleEnums.stream().anyMatch(RoleEnum::isAdmin);
        boolean isValidNewRoleAdmin =false;
        if (isAdmin) {
            for (int i = 0; i < roles.length; i++){
                if("ROLE_AMIN".contains(roles[i])){
                   isValidNewRoleAdmin = true;
                }
            }
        }

        if (isValidNewRoleAdmin){
          long roleAdminId = this.roleDAO.findRoleIdByRoleName(RoleEnum.ROLE_ADMIN);
          UserRole userRole = new UserRole(user.getId(),roleAdminId);
          this.userRoleDAO.save(userRole);
        }

    }


}
