package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.PublicKeyDAO;
import com.n3.childrentoyweb.models.PublicKey;

import java.time.LocalDateTime;

public class PublicKeyService {
    private PublicKeyDAO publicKeyDAO;

    public PublicKeyService(){
        this.publicKeyDAO = new PublicKeyDAO();
    }

    public Long saveAndDisableOldKey(PublicKey publicKey){
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
}
