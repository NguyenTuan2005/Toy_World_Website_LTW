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


    public Long save(Banner banner) {

        String sql = """
            INSERT INTO banners
            (title, img_path, group_tag, sort_order, event_id, is_active)
            VALUES
            (:title, :imgPath, :groupTag, :sortOrder, :eventId, :isActive)
        """;

        return getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("title", banner.getTitle())
                        .bind("imgPath", banner.getImgPath())
                        .bind("groupTag", banner.getGroupTag())
                        .bind("sortOrder", banner.getSortOrder())
                        .bind("eventId", banner.getEventId())
                        .bind("isActive", banner.getActive())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Long.class)
                        .one()
        );
    }


    // Lấy banners theo groupTag
    public List<Banner> findByGroupTag(String groupTag) {

        String sql = """
            SELECT *
            FROM banners
            WHERE group_tag = :groupTag
            ORDER BY sort_order
        """;

        return getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("groupTag", groupTag)
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

    public List<String> findAllGroupTags() {

        String sql = """
            SELECT DISTINCT group_tag
            FROM banners
            ORDER BY group_tag
        """;

        return getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(String.class)
                        .list()
        );
    }


    public List<Banner> findByTitleLike(String keyword) {

        String sql = """
        SELECT *
        FROM banners
        WHERE title LIKE :kw
        ORDER BY created_at DESC
        LIMIT 20
    """;

        return getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("kw", "%" + keyword + "%")
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

}
