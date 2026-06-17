package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.PublicKeyDAO;
import com.n3.childrentoyweb.dao.UserDAO;
import com.n3.childrentoyweb.dto.UserPublicKeyDTO;
import com.n3.childrentoyweb.models.PublicKey;

import java.time.LocalDateTime;
import java.util.List;

public class PublicKeyService {
    private PublicKeyDAO publicKeyDAO;
    private UserDAO userDAO;
    public PublicKeyService(){
        this.publicKeyDAO = new PublicKeyDAO();
        this.userDAO = new UserDAO();
    }

    public Long saveAndDisableOldKey(PublicKey publicKey){


        boolean isHasCurrentUnLostPublicKey =this.publicKeyDAO.isUnLost(publicKey.getUserId());

        if (isHasCurrentUnLostPublicKey){
            System.out.println("PKey khả dụng, không đc thêm");
            boolean isNoPublicKey = this.publicKeyDAO.isNoKey(publicKey.getUserId());
            if (!isNoPublicKey)
                return -1l;
            else {
                System.out.println("NewUser chưa có pkey");
            }
        }

        this.userDAO.updateLostKey(publicKey.getUserId(),false);
        this.publicKeyDAO.disableAllPublicKey(publicKey.getUserId());
        return this.publicKeyDAO.save(publicKey);
    }

    public int lostKey(Long userId){
        return this.publicKeyDAO.lostKey(userId);
    }

    public PublicKey findById(Long id) {
        return this.publicKeyDAO.findById(id);
    }

    public LocalDateTime findLatestCreatePublicKey(Long userId){
        return this.publicKeyDAO.findLatestCreatePublicKey(userId);
    }

    public List<UserPublicKeyDTO> findAllUserPublicKeyInfoLost(int page, int pageSize) {
        return this.publicKeyDAO.findAllUserPublicKeyInfoLost(page,pageSize);
    }
}
