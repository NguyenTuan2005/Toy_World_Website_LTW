
CREATE TABLE users (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       first_name VARCHAR(255) NOT NULL,
                       last_name VARCHAR(255) NOT NULL,
                       phone VARCHAR(100),
                       gender VARCHAR(100),
                       password VARCHAR(255) NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       location_id BIGINT,
                       is_active TINYINT(1) DEFAULT 1,
                       created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE locations (
                           id BIGINT AUTO_INCREMENT PRIMARY KEY,
                           address VARCHAR(255) NOT NULL,
                           province VARCHAR(100) NOT NULL,
                           is_active TINYINT(1) DEFAULT 1,
                           created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       role_name VARCHAR(255) NOT NULL,
                       is_active TINYINT(1) DEFAULT 1,
                       created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_roles (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            user_id BIGINT NOT NULL,
                            role_id BIGINT NOT NULL,
                            is_active TINYINT(1) DEFAULT 1,
                            created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE wish_lists (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            user_id BIGINT NOT NULL,
                            product_id BIGINT NOT NULL,
                            is_active TINYINT(1) DEFAULT 1,
                            created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE carts (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       user_id BIGINT,
                       is_active TINYINT(1) DEFAULT 1,
                       created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cart_items (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            cart_id BIGINT,
                            product_id BIGINT,
                            quantity INT,
                            is_active TINYINT(1) DEFAULT 1,
                            created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        user_id BIGINT,
                        total_price DECIMAL(15,2) NOT NULL,
                        status VARCHAR(255) NOT NULL DEFAULT 'CHUAN_BI_HANG',
                        is_active TINYINT(1) DEFAULT 1,
                        created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments (
                          id BIGINT AUTO_INCREMENT PRIMARY KEY,
                          payment_method_id BIGINT,
                          order_id BIGINT NOT NULL,
                          balance DECIMAL(15,2) NOT NULL,
                          status VARCHAR(255) NOT NULL,
                          is_active TINYINT(1) DEFAULT 1,
                          created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_details (
                               id BIGINT AUTO_INCREMENT PRIMARY KEY,
                               order_id BIGINT,
                               product_id BIGINT,
                               quantity INT NOT NULL DEFAULT 1,
                               is_active TINYINT(1) DEFAULT 1,
                               created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE shippings (
                           id BIGINT AUTO_INCREMENT PRIMARY KEY,
                           order_id BIGINT,
                           partner_id BIGINT,
                           tracking_code VARCHAR(100),
                           shipping_fee DECIMAL(10,2) DEFAULT 0,
                           shipping_status VARCHAR(50) DEFAULT 'pending',
                           estimated_delivery DATETIME DEFAULT NULL,
                           start_shipped_at DATETIME DEFAULT NULL,
                           delivered_at DATETIME DEFAULT NULL,
                           is_active TINYINT(1) DEFAULT 1,
                           created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_methods (
                                 id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                 name VARCHAR(100),
                                 is_active TINYINT(1) DEFAULT 1,
                                 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            name VARCHAR(255) NOT NULL,
                            is_active TINYINT(1) DEFAULT 1,
                            created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE brands (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        img_path VARCHAR(255),
                        is_active TINYINT(1) DEFAULT 1,
                        created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE events (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        opened_at DATETIME NOT NULL,
                        closed_at DATETIME NOT NULL,
                        description VARCHAR(255),
                        type_event VARCHAR(255) NOT NULL,
                        is_active TINYINT(1) DEFAULT 1,
                        created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE banners (
                         id BIGINT AUTO_INCREMENT PRIMARY KEY,
                         title VARCHAR(255),
                         img_path VARCHAR(255) NOT NULL,
                         group_tag VARCHAR(100),
                         sort_order INT DEFAULT 0,
                         event_id BIGINT,
                         is_active TINYINT(1) DEFAULT 1,
                         created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE promotions (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            name VARCHAR(100) NOT NULL,
                            expired_at DATETIME NOT NULL,
                            discount_percent DOUBLE,
                            discount_price DECIMAL(15,2),
                            event_id BIGINT NOT NULL,
                            is_active TINYINT(1) DEFAULT 1,
                            created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
                          id BIGINT AUTO_INCREMENT PRIMARY KEY,
                          price DECIMAL(15,2) NOT NULL,
                          promotion_id BIGINT,
                          quantity INT NOT NULL DEFAULT 0,
                          name VARCHAR(255),
                          rest_info JSON,
                          description MEDIUMTEXT,
                          brand_id BIGINT,
                          category_id BIGINT,
                          is_active TINYINT(1) DEFAULT 1,
                          created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_assets (
                                id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                img_path VARCHAR(255) NOT NULL,
                                product_id BIGINT,
                                is_active TINYINT(1) DEFAULT 1,
                                created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_comments (
                               id BIGINT AUTO_INCREMENT PRIMARY KEY,
                               content VARCHAR(255) NOT NULL,
                               user_id BIGINT,
                               product_id BIGINT,
                               is_active TINYINT(1) DEFAULT 1,
                               created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE category_hbs (
                              id BIGINT AUTO_INCREMENT PRIMARY KEY,
                              name VARCHAR(255) NOT NULL,
                              is_active TINYINT(1) DEFAULT 1,
                              created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE handbook_categories (
                                     id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                     category_id BIGINT,
                                     handbook_id BIGINT,
                                     is_active TINYINT(1) DEFAULT 1,
                                     created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE handbooks (
                           id BIGINT AUTO_INCREMENT PRIMARY KEY,
                           user_id BIGINT NOT NULL,
                           title VARCHAR(255),
                           views BIGINT DEFAULT 0,
                           status VARCHAR(50) NOT NULL,
                           is_active TINYINT(1) DEFAULT 1,
                           created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE paragraphs (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            header TEXT,
                            description TEXT,
                            image_path VARCHAR(255),
                            image_description VARCHAR(100),
                            display_index INT NOT NULL,
                            handbook_id BIGINT NOT NULL,
                            is_active TINYINT(1) DEFAULT 1,
                            created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- FOREIGN KEYS
ALTER TABLE users ADD FOREIGN KEY (location_id) REFERENCES locations (id);
ALTER TABLE user_roles ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE user_roles ADD FOREIGN KEY (role_id) REFERENCES roles (id);
ALTER TABLE wish_lists ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE wish_lists ADD FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE carts ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE cart_items ADD FOREIGN KEY (cart_id) REFERENCES carts (id);
ALTER TABLE cart_items ADD FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE orders ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE payments ADD FOREIGN KEY (payment_method_id) REFERENCES payment_methods (id);
ALTER TABLE payments ADD FOREIGN KEY (order_id) REFERENCES orders (id);
ALTER TABLE order_details ADD FOREIGN KEY (order_id) REFERENCES orders (id);
ALTER TABLE order_details ADD FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE shippings ADD FOREIGN KEY (order_id) REFERENCES orders (id);
ALTER TABLE banners ADD FOREIGN KEY (event_id) REFERENCES events (id);
ALTER TABLE promotions ADD FOREIGN KEY (event_id) REFERENCES events (id);
ALTER TABLE products ADD FOREIGN KEY (promotion_id) REFERENCES promotions (id);
ALTER TABLE products ADD FOREIGN KEY (brand_id) REFERENCES brands (id);
ALTER TABLE products ADD FOREIGN KEY (category_id) REFERENCES categories (id);
ALTER TABLE product_assets ADD FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE user_comments ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE user_comments ADD FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE handbook_categories ADD FOREIGN KEY (category_id) REFERENCES category_hbs (id);
ALTER TABLE handbook_categories ADD FOREIGN KEY (handbook_id) REFERENCES handbooks (id);
ALTER TABLE handbooks ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE paragraphs ADD FOREIGN KEY (handbook_id) REFERENCES handbooks (id);