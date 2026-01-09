package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.WishListDAO;
import com.n3.childrentoyweb.models.WishList;

import java.util.List;

public class WishListService {
    private WishListDAO wishListDAO;

    public WishListService(){
        this.wishListDAO = new WishListDAO();
    }

    public void save(WishList wishList){
        if (!this.wishListDAO.exists(wishList)) {
            this.wishListDAO.save(wishList);
        }
    }

    public List<Long> findAllProductIdByUserId(Long userId){
        return this.wishListDAO.findAllProductIdByUserId(userId);
    }

}
