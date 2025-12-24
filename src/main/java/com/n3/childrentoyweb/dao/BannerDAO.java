package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.enums.BannerGroupTag;
import com.n3.childrentoyweb.models.Banner;

import java.util.List;

public class BannerDAO extends BaseDAO{
    public List<Banner> findAllByGroupTag(BannerGroupTag groupTag){
        String sql = """
        select b.id, b.title, b.img_path, b.group_tag, b.sort_order, b.event_id, b.is_active
        from banners b where b.group_tag = :tag
        and b.is_active = 1
        order by b.sort_order
        """;
        return this.getJdbi().withHandle(handle-> handle.createQuery(sql)
                .bind("tag", groupTag.getTag())
                .mapToBean(Banner.class)
                .list()
                );

    }
}
