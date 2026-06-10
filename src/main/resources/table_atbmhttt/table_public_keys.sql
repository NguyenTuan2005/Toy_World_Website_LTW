CREATE TABLE `public_keys`
(
    `id`         bigint   NOT NULL AUTO_INCREMENT,
    `user_id`    bigint   NOT NULL,
    `public_key` text     NOT NULL,
    `is_active`  tinyint(1) DEFAULT '1',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `lost_at` datetime DEFAULT  NULL,
    PRIMARY KEY (`id`), KEY          `user_id` (`user_id`),
    CONSTRAINT `public_keys_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

CREATE TABLE `order_payloads`
(
    `id`              bigint NOT NULL AUTO_INCREMENT,
    `order_id`        bigint NOT NULL,
    `public_key_id`   bigint NOT NULL,

    order_payload NVARCHAR(MAX) NOT NULL,

    signature_value NVARCHAR(MAX),
    algorithm VARCHAR(50) NOT NULL,
    signed_at DATETIME,
    verification_status VARCHAR(20),
    `created_at`      datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    UNIQUE KEY `uk_order_public_key`
        (`order_id`, `public_key_id`),

    KEY `idx_public_key_id` (`public_key_id`),

    CONSTRAINT `fk_order_payload_order`
        FOREIGN KEY (`order_id`)
            REFERENCES `orders` (`id`),

    CONSTRAINT `fk_order_payload_public_key`
        FOREIGN KEY (`public_key_id`)
            REFERENCES `public_keys` (`id`)
);
-- update table 10-t6-2026
alter table public_keys add column lost varchar(100)

alter table users add column  is_lost_key   tinyint(1) DEFAULT '0',
