package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.WishListDAO;
import com.n3.childrentoyweb.dto.WishlistProductDTO;
import com.n3.childrentoyweb.models.WishList;

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

    public List<WishlistProductDTO> findUserWishlist(Long userId) {
        if (userId == null) {
            throw new IllegalArgumentException("ID người dùng không được null");
        }
        return wishListDAO.findWishlistByUserId(userId);
    }


    public void removeFromWishlist(Long userId, Long productId) {

        if (userId == null || productId == null || productId <= 0) {
            throw new IllegalArgumentException("Id người dùng và sản phẩm không hợp lệ");
        }

        wishListDAO.delete(userId, productId);
    }


}
