package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.models.Event;

import java.util.List;

public class EventDAO  extends BaseDAO{

    public int countTotalEvent() {
        String sql = "select count(*) from events";

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }
    public int countOngoingEvent() {
        String sql = """
            select count(*) 
            from events
            where opened_at <= now()
              and closed_at >= now()
              and is_active = 1
            """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }
    public int countUpcomingEvent() {
        String sql = """
            select count(*)
            from events
            where opened_at > now()
            """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public int countEndedEvent() {
        String sql = """
            select count(*)
            from events
            where closed_at < now()
            """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public Long save(Event event) {

        String sql = """
        insert into events
        (name, opened_at, closed_at, description, type_event, is_active)
        values
        (:name, :openedAt, :closedAt, :description, :typeEvent, :isActive)
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("name", event.getName())
                        .bind("openedAt", event.getOpenedAt())
                        .bind("closedAt", event.getClosedAt())
                        .bind("description", event.getDescription())
                        .bind("typeEvent", event.getTypeEvent())
                        .bind("isActive", event.getActive())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Long.class)
                        .one()
        );
    }
    public void update(Event event) {

        String sql = """
        update events
        set name = :name,
            opened_at = :openedAt,
            closed_at = :closedAt,
            description = :description,
            type_event = :typeEvent,
            is_active = :isActive
        where id = :id
        """;

        this.getJdbi().useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", event.getId())
                        .bind("name", event.getName())
                        .bind("openedAt", event.getOpenedAt())
                        .bind("closedAt", event.getClosedAt())
                        .bind("description", event.getDescription())
                        .bind("typeEvent", event.getTypeEvent())
                        .bind("isActive", event.getActive())
                        .execute()
        );
    }

    public List<Event> findEventForManagement(int page, int pageSize){
        int offset = (page - 1) * pageSize;

        String sql = """
        select *
        from events
        order by created_at desc
        limit :limit offset :offset
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .map((rs, ctx) -> {
                            Event e = new Event();
                            e.setId(rs.getLong("id"));
                            e.setName(rs.getString("name"));
                            e.setOpenedAt(rs.getTimestamp("opened_at").toLocalDateTime());
                            e.setClosedAt(rs.getTimestamp("closed_at").toLocalDateTime());
                            e.setDescription(rs.getString("description"));
                            e.setTypeEvent(rs.getString("type_event"));
                            e.setActive(rs.getBoolean("is_active"));
                            e.setStatus();
                            return e;
                        })
                        .list()
        );
    }


    public Event findById(Long id) {
        String sql = """
                        SELECT *
                        FROM events
                        WHERE id = :id
                    """;
        return this.getJdbi().withHandle(handle -> handle.createQuery(sql)
                .bind("id",id)
                .map((rs,stx)->{
                    Event e = new Event();
                    e.setId(rs.getLong("id"));
                    e.setName(rs.getString("name"));
                    e.setOpenedAt(rs.getTimestamp("opened_at").toLocalDateTime());
                    e.setClosedAt(rs.getTimestamp("closed_at").toLocalDateTime());
                    e.setDescription(rs.getString("description"));
                    e.setTypeEvent(rs.getString("type_event"));
                    e.setActive(rs.getBoolean("is_active"));
                    e.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());

                    return e;
                }).one()
        );
    }

    public List<Event> findByName(String name) {


        String sql = """
        select *
        from events
        where name like :name
        limit :limit
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit", 10)
                        .bind("name", "%"+name+"%")
                        .map((rs, ctx) -> {
                            Event e = new Event();
                            e.setId(rs.getLong("id"));
                            e.setName(rs.getString("name"));
                            e.setOpenedAt(rs.getTimestamp("opened_at").toLocalDateTime());
                            e.setClosedAt(rs.getTimestamp("closed_at").toLocalDateTime());
                            e.setDescription(rs.getString("description"));
                            e.setTypeEvent(rs.getString("type_event"));
                            e.setActive(rs.getBoolean("is_active"));
                            return e;
                        })
                        .list()
        );

    }

    public List<Event> findActiveEvent() {

        String sql = """
        select *
        from events
        where opened_at <= now()
        limit :limit
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit", 20)
                        .map((rs, ctx) -> {
                            Event e = new Event();
                            e.setId(rs.getLong("id"));
                            e.setName(rs.getString("name"));
                            e.setOpenedAt(rs.getTimestamp("opened_at").toLocalDateTime());
                            e.setClosedAt(rs.getTimestamp("closed_at").toLocalDateTime());
                            e.setDescription(rs.getString("description"));
                            e.setTypeEvent(rs.getString("type_event"));
                            e.setActive(rs.getBoolean("is_active"));
                            return e;
                        })
                        .list()
        );
    }
}
