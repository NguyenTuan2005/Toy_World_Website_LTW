package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.BannerDAO;
import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;

import java.util.List;
import java.util.Optional;

public class BannerService {
    private BannerDAO bannerDAO;

    public BannerService() {
        this.bannerDAO = new BannerDAO();
    }

    public List<Banner> findAllBanners(BannerGroupTag bannerGroupTag) {
        return this.bannerDAO.findAllByGroupTag(bannerGroupTag);
    }

    public Optional<Banner> findBannerForCurrentPromotion() {
        return Optional.of(this.bannerDAO.findBannerForCurrentPromotion());
    }

    public void updateBanner(Banner banner) {
        bannerDAO.update(banner);
    }

    public Banner getBannerById(Long id) {
        return bannerDAO.findById(id);
    }

    public Pagination<Banner> findBannerPaging(int currentPage, int pageSize) {
        List<Banner> banners = bannerDAO.findPaging(currentPage, pageSize);
        int totalElements = this.bannerDAO.countAll();
        int totalPages = totalElements / pageSize;
        return new Pagination<>(banners,currentPage,totalElements,totalPages);
    }

    public int countAllBanner() {
        return bannerDAO.countAll();
    }

}
