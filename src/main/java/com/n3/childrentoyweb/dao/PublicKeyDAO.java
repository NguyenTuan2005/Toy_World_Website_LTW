package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.UserPublicKeyDTO;
import com.n3.childrentoyweb.models.PublicKey;

import java.time.LocalDateTime;
import java.util.List;

public class PublicKeyDAO extends BaseDAO{

    public void disableAllPublicKey(Long userId){
        String sql = """
            UPDATE public_keys
            SET
                is_active = 0,
                is_user_disable = 1
            WHERE user_id = :user_id
              AND is_active = 1
            """;
        this.getJdbi().withHandle(h ->
                h.createUpdate(sql)
                        .bind("user_id", userId)
                        .execute()
        );
    }

    public int lostKey(Long userId) {
        String sql = """
            UPDATE public_keys
            SET
                is_active = 0,
                lost='LOSTED',
                lost_at = NOW()
            WHERE user_id = :user_id
              AND is_active = 1
            """;

        return this.getJdbi().withHandle(h ->
                h.createUpdate(sql)
                        .bind("user_id", userId)
                        .execute()
        );
    }

    public Long save(PublicKey publicKey) {
        String sql = """
            INSERT INTO public_keys (
                user_id,
                public_key
            )
            VALUES (
                :user_id,
                :public_key
            )
            """;

        return this.getJdbi().withHandle(h ->
                h.createUpdate(sql)
                        .bind("user_id", publicKey.getUserId())
                        .bind("public_key", publicKey.getPublicKey())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Long.class)
                        .one()
        );
    }

    public PublicKey findById(Long id) {
        String sql = """
            SELECT *
            FROM public_keys
            WHERE id = :id
            """;

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(PublicKey.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public List<PublicKey> findAll(int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        String sql = """
            SELECT *
            FROM public_keys
            ORDER BY created_at DESC
            LIMIT :limit OFFSET :offset
            """;

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .mapToBean(PublicKey.class)
                        .list()
        );
    }

    public List<UserPublicKeyDTO> findAllUserPublicKeyInfoLost(int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        String sql = """
            SELECT
                u.id AS user_id,
                pk.id AS public_key_id,
                u.email,
                CONCAT(u.first_name, ' ', u.last_name) AS full_name,
                pk.created_at,
                pk.lost_at,
                pk.lost
            FROM public_keys pk
            JOIN users u ON u.id = pk.user_id
            WHERE pk.lost = 'LOSTED'
            ORDER BY pk.created_at DESC
            LIMIT :limit OFFSET :offset
            """;

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .map((rs, ctx) -> new UserPublicKeyDTO(
                                rs.getLong("user_id"),
                                rs.getLong("public_key_id"),
                                rs.getString("email"),
                                rs.getString("full_name"),
                                rs.getObject("created_at", LocalDateTime.class),
                                rs.getObject("lost_at", LocalDateTime.class),
                                rs.getString("lost")
                        ))
                        .list()
        );
    }

    public List<PublicKey> findAllByUserId(Long userId,int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        String sql = """
            SELECT *
            FROM public_keys
            WHERE user_id = :userId
            ORDER BY created_at DESC
            LIMIT :limit OFFSET :offset
            
            """;

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .bind("userId",userId)
                        .map((rs, ctx) -> {
                            PublicKey pk = new PublicKey();

                            pk.setId(rs.getLong("id"));
                            pk.setUserId(rs.getLong("user_id"));
                            pk.setPublicKey(rs.getString("public_key"));

                            pk.setCreatedAt(
                                    rs.getTimestamp("created_at") != null
                                            ? rs.getTimestamp("created_at").toLocalDateTime()
                                            : null
                            );

                            pk.setLostAt(
                                    rs.getTimestamp("lost_at") != null
                                            ? rs.getTimestamp("lost_at").toLocalDateTime()
                                            : null
                            );

                            pk.setActive(rs.getBoolean("is_active"));

                            return pk;
                        })
                        .list()
        );
    }




    public LocalDateTime findLatestCreatePublicKey(Long userId) {
        String sql = """
        SELECT MAX(created_at)
        FROM public_keys
        WHERE user_id = :userId and is_active = 1 
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .mapTo(LocalDateTime.class)
                        .one()
        );
    }
}
