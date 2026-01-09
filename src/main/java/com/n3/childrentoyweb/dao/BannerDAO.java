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

    public Banner findBannerForCurrentPromotion(){
        String sql = """
        select b.id, b.title, b.img_path, b.group_tag, b.sort_order, b.event_id, b.is_active
        from banners b where b.group_tag = 'KHUYEN_MAI'
        and b.is_active = 1
        Limit 1
        """;
        return this.getJdbi().withHandle(handle-> handle.createQuery(sql)
                .mapToBean(Banner.class)
                .one()
        );
    }

    public int countAll() {

        String sql = "select count(*) from banners";

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }


    public void update(Banner b) {

        String sql = """
        update banners
        set title = :title,
            img_path = :imgPath,
            group_tag = :groupTag,
            sort_order = :sortOrder,
            event_id = :eventId,
            is_active = :isActive
        where id = :id
        """;

        this.getJdbi().useHandle(h ->
                h.createUpdate(sql)
                        .bind("id", b.getId())
                        .bind("title", b.getTitle())
                        .bind("imgPath", b.getImgPath())
                        .bind("groupTag", b.getGroupTag())
                        .bind("sortOrder", b.getSortOrder())
                        .bind("eventId", b.getEventId())
                        .bind("isActive", b.getActive())
                        .execute()
        );
    }
    public Banner findById(Long id) {

        String sql = "select * from banners where id = :id";

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            Banner b = new Banner();
                            b.setId(rs.getLong("id"));
                            b.setTitle(rs.getString("title"));
                            b.setImgPath(rs.getString("img_path"));
                            b.setGroupTag(rs.getString("group_tag"));
                            b.setSortOrder(rs.getInt("sort_order"));
                            b.setEventId(rs.getLong("event_id"));
                            b.setActive(rs.getBoolean("is_active"));
                            b.setCreatedAt(
                                    rs.getTimestamp("created_at").toLocalDateTime()
                            );
                            return b;
                        })
                        .one()
        );
    }

    public List<Banner> findPaging(int currentPage, int pageSize) {

        int offset = (currentPage - 1) * pageSize;

        String sql = """
        select * from banners
        order by sort_order asc
        limit :limit offset :offset
        """;

        return this.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .map((rs, ctx) -> {
                            Banner b = new Banner();
                            b.setId(rs.getLong("id"));
                            b.setTitle(rs.getString("title"));
                            b.setImgPath(rs.getString("img_path"));
                            b.setGroupTag(rs.getString("group_tag"));
                            b.setSortOrder(rs.getInt("sort_order"));
                            b.setEventId(rs.getLong("event_id"));
                            b.setActive(rs.getBoolean("is_active"));
                            b.setCreatedAt(
                                    rs.getTimestamp("created_at").toLocalDateTime()
                            );
                            return b;
                        })
                        .list()
        );
    }



    public static void main(String[] args) {
      var i =  new BannerDAO().findBannerForCurrentPromotion();
        System.out.println(i);
    }
}
