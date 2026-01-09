package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.WishListDAO;
import com.n3.childrentoyweb.models.WishList;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

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

    public boolean toggleWishList(long userId, long productId) {
        Optional<WishList> existing = wishListDAO.findByUserIdAndProductId(userId, productId);
        if(existing.isEmpty()) {
            WishList newWish = new WishList(userId, productId);
            wishListDAO.save(newWish);
            return true;

        } else {
            WishList w = existing.get();
            w.revertActive();
            wishListDAO.update(w);
            return w.getActive();

        }
    }

    public static void main(String[] args) {
        WishListService wishListService = new WishListService();

        System.out.println(wishListService.toggleWishList(1, 1));
    }


}
