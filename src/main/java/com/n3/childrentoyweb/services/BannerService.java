package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.BannerDAO;
import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;

import java.util.List;

public class BannerService {
    private BannerDAO bannerDAO;

    public BannerService() {
        this.bannerDAO = new BannerDAO();
    }

    public List<Banner> findAllBanners(BannerGroupTag bannerGroupTag) {
        return this.bannerDAO.findAllByGroupTag(bannerGroupTag);
    }


}
