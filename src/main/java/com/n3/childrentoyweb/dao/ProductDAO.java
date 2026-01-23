package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.*;
import com.n3.childrentoyweb.enums.ProductStatus;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.utils.JsonColumnMapper;
import com.n3.childrentoyweb.utils.JsonUtil;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;
import org.jdbi.v3.core.statement.Query;

import java.util.*;

public class ProductDAO extends BaseDAO {

    public List<ProductListDTO> findAll() {
        String sql = """
                    SELECT p.id, 
                           p.name, 
                           p.price AS originPrice, 
                           pa.img_path AS imgPath,
                           p.quantity,
                           b.name AS brand,
                           c.name AS category,
                           pm.discount_percent AS discountPercent,
                           pm.discount_price AS maxDiscountPrice
                    FROM products p
                    JOIN brands b ON p.brand_id = b.id
                    JOIN categories c ON p.category_id = c.id
                    JOIN promotions pm ON p.promotion_id = pm.id
                    JOIN product_assets pa ON p.id = pa.product_id
                    WHERE p.is_active = 1
                """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .registerRowMapper(BeanMapper.factory(ProductListDTO.class))
                        .mapTo(ProductListDTO.class)
                        .list()
        );
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = 1";

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public List<HomeProductDTO> findSignatureProduct(int page, int pageSize, String brandName) {
        int offset = (page - 1) * pageSize;

        String sql = """
                  SELECT
                    p.id,
                    p.name,
                    p.price AS original_price,
                    prom.discount_percent,
                    (
                        select pa.img_path
                        from  product_assets pa
                        where pa.product_id =p.id
                        and pa.is_active =1
                        limit 1
                    ) as "img_url",
                    b.name as brand_name
                FROM products p
                JOIN brands b ON b.id = p.brand_id
                JOIN promotions prom
                      ON prom.id = p.promotion_id
                      AND prom.is_active = 1
                      AND prom.expired_at >= NOW()
                WHERE p.is_active = 1 AND b.name like :brandName
                ORDER BY prom.discount_percent, prom.discount_price desc
                LIMIT :limit OFFSET :offset
                """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .bind("brandName", "%" + brandName + "%")
                        .map((rs, ctx) -> {
                            HomeProductDTO dto = new HomeProductDTO();

                            dto.setId(rs.getInt("id"));
                            dto.setName(rs.getString("name"));
                            dto.setOriginalPrice(rs.getDouble("original_price"));
                            dto.setDiscountPercent(rs.getFloat("discount_percent"));
                            dto.setImageUrl(rs.getString("img_url"));
                            dto.setBrandName(rs.getString("brand_name"));
                            dto.setCurrentPrice();
                            return dto;
                        })
                        .list()
        );
    }

    public List<HomeProductDTO> findNewImportProductsInMonth(int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        String sql = """
                  SELECT
                    p.id,
                    p.name,
                    p.price AS original_price,
                    prom.discount_percent,
                    (
                        select pa.img_path
                        from  product_assets pa
                        where pa.product_id =p.id
                        and pa.is_active =1
                        limit 1
                    ) as "img_url",
                    b.name as brand_name
                FROM products p
                JOIN brands b ON b.id = p.brand_id
                JOIN promotions prom
                      ON prom.id = p.promotion_id
                      AND prom.is_active = 1
                      AND prom.expired_at >= NOW()
                WHERE p.is_active = 1
                AND p.created_at >= DATE_FORMAT(NOW(), '%Y-%m-01')
                AND p.created_at <  DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 1 MONTH)
                LIMIT :limit OFFSET :offset
                """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .map((rs, ctx) -> {
                            HomeProductDTO dto = new HomeProductDTO();

                            dto.setId(rs.getInt("id"));
                            dto.setName(rs.getString("name"));
                            dto.setOriginalPrice(rs.getDouble("original_price"));
                            dto.setDiscountPercent(rs.getFloat("discount_percent"));
                            dto.setImageUrl(rs.getString("img_url"));
                            dto.setBrandName(rs.getString("brand_name"));
                            dto.setCurrentPrice();
                            return dto;
                        })
                        .list()
        );
    }

    public Optional<Product> findById(Long id) {
        String sql = """
                    SELECT id, name, price, quantity, description,
                           promotion_id AS promotionId,
                           rest_info AS restInfo,
                           brand_id AS brandId,
                           category_id AS categoryId
                    FROM products
                    WHERE is_active = 1 AND id = :id
                """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .registerColumnMapper(new JsonColumnMapper())
                        .registerRowMapper(BeanMapper.factory(Product.class))
                        .mapTo(Product.class)
                        .findOne()
        );
    }

    public Optional<ProductDetailDTO> findDetailById(Long id) {
        String sql = """
                    SELECT p.id, p.name, 
                           p.price AS originalPrice,
                           p.quantity, 
                           p.description,
                           p.rest_info AS restInfo,
                           p.brand_id AS brandId,
                           b.name AS brandName,
                           p.category_id AS categoryId,
                           c.name AS categoryName,
                           pm.id AS promotionId,
                           pm.discount_percent AS discountPercent,
                           pm.discount_price AS discountPrice
                    FROM products p
                    JOIN brands b ON p.brand_id = b.id
                    JOIN categories c ON p.category_id = c.id
                    LEFT JOIN promotions pm ON p.promotion_id = pm.id
                    WHERE p.is_active = 1 AND p.id = :id
                """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .registerColumnMapper(new JsonColumnMapper())
                        .registerRowMapper(BeanMapper.factory(ProductDetailDTO.class))
                        .mapTo(ProductDetailDTO.class)
                        .findOne()
        );

    }

    public List<ProductListDTO> findRelatedByCategoryAndBrand(Long categoryId, Long brandId, Long excludeProductId, int limit) {
        String sql = """
                SELECT p.id,
                       p.name,
                       p.price AS originPrice,
                       p.quantity,
                       b.name AS brand,
                       c.name AS category,
                       pm.discount_percent AS discountPercent,
                       pm.discount_price AS maxDiscountPrice,
                       (
                       SELECT pa.img_path
                       FROM product_assets pa
                       WHERE pa.product_id = p.id
                             AND pa.is_active = 1
                       LIMIT 1
                        ) AS imgPath
                FROM products p
                JOIN brands b ON p.brand_id = b.id
                JOIN categories c ON p.category_id = c.id
                LEFT JOIN promotions pm ON p.promotion_id = pm.id
                WHERE p.is_active = 1
                  AND p.category_id = :categoryId
                  AND p.brand_id = :brandId
                  AND p.id <> :excludeId
                ORDER BY p.created_at DESC
                LIMIT :limit
                """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryId", categoryId)
                        .bind("brandId", brandId)
                        .bind("excludeId", excludeProductId)
                        .bind("limit", limit)
                        .registerRowMapper(BeanMapper.factory(ProductListDTO.class))
                        .mapTo(ProductListDTO.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        System.out.println(new ProductDAO().findRelatedByCategoryAndBrand(1L, 1L, 1L, 10));
    }

    public long countProductInMonth(int year, int month) {
        String sql = """
                SELECT COUNT(*)
                FROM products p
                WHERE YEAR(p.created_at) = :year AND MONTH(p.created_at) = :month AND p.is_active = 1;
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("year", year)
                        .bind("month", month)
                        .mapTo(Long.class)
                        .one()
        );
    }

    public List<ProductPromotionDTO> findProductsByPromotionId(Long promotionId) {
        String sql = """
                select
                   p.id,
                   p.name,
                   p.price,
                        (
                      select pa.img_path
                      from  product_assets pa
                      where pa.product_id =p.id
                      and pa.is_active =1
                      limit 1
                  ) as "img_url"
                from products p
                where p.quantity >0
                and p.promotion_id = :promotionId
                and p.is_active = 1
                """;

        return this.getJdbi().withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind("promotionId", promotionId)
                    .map(((rs, ctx) -> {
                        ProductPromotionDTO productPromotionDTO = new ProductPromotionDTO();
                        productPromotionDTO.setId(rs.getLong("id"));
                        productPromotionDTO.setName(rs.getString("name"));
                        productPromotionDTO.setOriginalPrice(rs.getDouble("price"));
                        productPromotionDTO.setFirstImg(rs.getString("img_url"));
                        return productPromotionDTO;
                    }))
                    .list();
        });
    }

    public int countByFilter(List<Integer> brandIds,
                             List<Integer> categoryIds,
                             List<PriceRangeFilterDTO> priceRanges) {

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM products WHERE is_active = 1"
        );

        return this.getJdbi().withHandle(h -> {
            var query = h.createQuery("");

            if (brandIds != null && !brandIds.isEmpty()) {
                sql.append(" AND brand_id IN (<brandIds>)");
            }

            if (categoryIds != null && !categoryIds.isEmpty()) {
                sql.append(" AND category_id IN (<categoryIds>)");
            }

            if (priceRanges != null && !priceRanges.isEmpty()) {
                sql.append(" AND (");
                for (int i = 0; i < priceRanges.size(); i++) {
                    if (i > 0) sql.append(" OR ");
                    sql.append("(price >= :min").append(i)
                            .append(" AND price <= :max").append(i).append(")");
                }
                sql.append(")");
            }

            query = h.createQuery(sql.toString());

            // bind list
            if (brandIds != null && !brandIds.isEmpty()) {
                query.bindList("brandIds", brandIds);
            }

            if (categoryIds != null && !categoryIds.isEmpty()) {
                query.bindList("categoryIds", categoryIds);
            }

            if (priceRanges != null && !priceRanges.isEmpty()) {
                for (int i = 0; i < priceRanges.size(); i++) {
                    query.bind("min" + i, priceRanges.get(i).getMin());
                    query.bind("max" + i, priceRanges.get(i).getMax());
                }
            }

            return query.mapTo(Integer.class).one();
        });
    }

    //filter
    public List<ProductListDTO> findByFilter(
            List<Integer> brandIds,
            List<Integer> categoryIds,
            List<PriceRangeFilterDTO> priceRanges,
            String sortType,
            int pageSize,
            int offset
    ) {

        return getJdbi().withHandle(handle -> {

            StringBuilder sql = new StringBuilder("""
            SELECT p.id,
                   p.name,
                   p.price AS originPrice,
                   GREATEST(p.price - LEAST( ROUND(p.price * COALESCE(pm.discount_percent, 0) / 100),
                                       COALESCE( NULLIF(pm.discount_price, 0), ROUND(p.price * pm.discount_percent / 100))
                                   ),
                                   0
                   ) AS finalPrice,
                   p.quantity,
                   b.name AS brand,
                   c.name AS category,
                   COALESCE(pm.discount_percent, 0) AS discountPercent,
                   COALESCE(pm.discount_price, 0) AS maxDiscountPrice,
                   (
                       SELECT pa.img_path
                       FROM product_assets pa
                       WHERE pa.product_id = p.id
                             AND pa.is_active = 1
                       LIMIT 1
                   ) AS imgPath
            FROM products p
            JOIN brands b ON p.brand_id = b.id
            JOIN categories c ON p.category_id = c.id
            LEFT JOIN promotions pm ON p.promotion_id = pm.id
            WHERE p.is_active = 1
        """);

            appendBrandFilter(sql, brandIds);
            appendCategoryFilter(sql, categoryIds);
            appendFinalPriceFilter(sql, priceRanges);

            sql.append(" ORDER BY ").append(convertSortTypeToOrderBy(sortType));
            sql.append(" LIMIT :limit OFFSET :offset");

            Query query = handle.createQuery(sql.toString())
                    .bind("limit", pageSize)
                    .bind("offset", offset);

            bindBrand(query, brandIds);
            bindCategory(query, categoryIds);
            bindFinalPrice(query, priceRanges);

            return query
                    .mapToBean(ProductListDTO.class)
                    .list();
        });
    }


    private void appendBrandFilter(StringBuilder sql, List<Integer> brandIds) {
        if (brandIds != null && !brandIds.isEmpty()) {
            sql.append(" AND brand_id IN (<brandIds>)");
        }
    }

    private void appendCategoryFilter(StringBuilder sql, List<Integer> categoryIds) {
        if (categoryIds != null && !categoryIds.isEmpty()) {
            sql.append(" AND category_id IN (<categoryIds>)");
        }
    }

    private void appendFinalPriceFilter(StringBuilder sql, List<PriceRangeFilterDTO> priceRanges) {
        if (priceRanges == null || priceRanges.isEmpty()) return;

        sql.append("""
                AND (
                """);

        for (int i = 0; i < priceRanges.size(); i++) {
            sql.append("""
                            (
                                p.price
                                - LEAST(
                                    ROUND(p.price * COALESCE(pm.discount_percent, 0) / 100),
                                    COALESCE(pm.discount_price, 0)
                                )
                                BETWEEN :min""").append(i)
                    .append(" AND :max").append(i)
                    .append(")");

            if (i < priceRanges.size() - 1) {
                sql.append(" OR ");
            }
        }

        sql.append(")");
    }


    private void bindBrand(Query query, List<Integer> brandIds) {
        if (brandIds != null && !brandIds.isEmpty()) {
            query.bindList("brandIds", brandIds);
        }
    }

    private void bindCategory(Query query, List<Integer> categoryIds) {
        if (categoryIds != null && !categoryIds.isEmpty()) {
            query.bindList("categoryIds", categoryIds);
        }
    }

    private void bindFinalPrice(Query query, List<PriceRangeFilterDTO> priceRanges) {
        if (priceRanges == null) return;

        int i = 0;
        for (PriceRangeFilterDTO range : priceRanges) {
            query.bind("min" + i, range.getMin());
            query.bind("max" + i, range.getMax());
            i++;
        }
    }

    private String convertSortTypeToOrderBy(String sort) {
        String orderBy;
        switch (sort) {
            case "name_asc":
                orderBy = "p.name ASC";
                break;
            case "name_desc":
                orderBy = "p.name DESC";
                break;
            case "price_asc":
                orderBy = "finalPrice ASC";
                break;
            case "price_desc":
                orderBy = "finalPrice DESC";
                break;
            case "discount":
                orderBy = "discountPercent DESC";
                break;
            default:
                orderBy = "p.created_at DESC";
                break;
        }
        return orderBy;

    }

    public List<ProductManagementDTO> findAllProductsForManagement(int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        String sql = """
                select p.id as productId,
                       p.name,
                       (
                        select img_path
                        from product_assets
                        where product_id = p.id
                        and is_active = 1
                        limit 1
                       ) as imgPath,
                       p.price,
                       b.name as brand,
                       c.name as category,
                       p.quantity
                from products p
                join brands b on b.id = p.brand_id
                join categories c on c.id = p.category_id
                limit :limit offset :offset
                """;
        return this.getJdbi().withHandle(handle ->
                    handle.createQuery(sql)
                            .bind("limit", pageSize)
                            .bind("offset", offset)
                            .map((rs, ctx) -> {
                                ProductManagementDTO productManagementDTO = new ProductManagementDTO();
                                productManagementDTO.setProductId(rs.getInt("productId"));
                                productManagementDTO.setName(rs.getString("name"));
                                productManagementDTO.setImgPath(rs.getString("imgPath"));
                                productManagementDTO.setPrice(rs.getDouble("price"));
                                productManagementDTO.setBrand(rs.getString("brand"));
                                productManagementDTO.setCategory(rs.getString("category"));
                                int quantity = rs.getInt("quantity");
                                productManagementDTO.setQuantity(quantity);
                                productManagementDTO.setStatus(quantity == 0 ? ProductStatus.OUT_OF_STOCK.getStatus() : ProductStatus.AVAILABLE.getStatus());
                                return productManagementDTO;
                            })
                            .list()
                );
    }

    public List<ProductManagementDTO> findByCriteria(ProductCriteria productCriteria) {
        StringBuilder sql = new StringBuilder("""
                select p.id as productId,
                       p.name,
                       (
                        select img_path
                        from product_assets
                        where product_id = p.id
                        and is_active = 1
                        limit 1
                       ) as imgPath,
                       p.price,
                       b.name as brand,
                       c.name as category,
                       p.quantity
                from products p
                join brands b on b.id = p.brand_id
                join categories c on c.id = p.category_id
                where 1 = 1
                """);
        sql.append(productCriteria.getIdForSql());
        sql.append(productCriteria.getNameForSql());
        sql.append(" limit 10");

        return this.getJdbi().withHandle(handle ->
                    handle.createQuery(sql)
                            .map((rs, ctx) -> {
                                ProductManagementDTO productManagementDTO = new ProductManagementDTO();
                                productManagementDTO.setProductId(rs.getInt("productId"));
                                productManagementDTO.setName(rs.getString("name"));
                                productManagementDTO.setImgPath(rs.getString("imgPath"));
                                productManagementDTO.setPrice(rs.getDouble("price"));
                                productManagementDTO.setBrand(rs.getString("brand"));
                                productManagementDTO.setCategory(rs.getString("category"));
                                int quantity = rs.getInt("quantity");
                                productManagementDTO.setQuantity(quantity);
                                productManagementDTO.setStatus(quantity == 0 ? ProductStatus.OUT_OF_STOCK.getStatus() : ProductStatus.AVAILABLE.getStatus());
                                return productManagementDTO;
                            })
                            .list()
                );
    }

    public long save(Product product) {
        String sql = """
                INSERT INTO `products` (`price`, `promotion_id`, `quantity`, `name`, `rest_info`, `description`, `brand_id`, `category_id`)
                VALUES (:price, :promotionId, :quantity, :name, :restInfo, :description, :brandId, :categoryId)
                """;

        return this.getJdbi().withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("price", product.getPrice())
                            .bind("promotionId", product.getPromotionId())
                            .bind("quantity", product.getQuantity())
                            .bind("name", product.getName())
                            .bind("restInfo", JsonUtil.parseProductRestInfo(product.getRestInfo()))
                            .bind("description", product.getDescription())
                            .bind("brandId", product.getBrandId())
                            .bind("categoryId", product.getCategoryId())
                            .executeAndReturnGeneratedKeys("id")
                            .mapTo(Long.class)
                            .one()
                );
    }

    public Product findProductForManagementById(long productId) {
        String sql = """
                select p.id,
                       p.name,
                       p.price,
                       p.brand_id as brandId,
                       p.category_id as categoryId,
                       p.promotion_id as promotionId,
                       p.quantity,
                       p.description,
                       p.rest_info as restInfo,
                       p.is_active as isActive
                from products p
                where p.id = :id
                """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", productId)
                        .map((rs, ctx) -> {
                            Product product = new Product();
                            product.setId(rs.getLong("id"));
                            product.setName(rs.getString("name"));
                            product.setPrice(rs.getDouble("price"));
                            product.setBrandId(rs.getLong("brandId"));
                            product.setCategoryId(rs.getLong("categoryId"));
                            product.setPromotionId(rs.getLong("promotionId"));
                            product.setQuantity(rs.getInt("quantity"));
                            product.setDescription(rs.getString("description"));
                            product.setRestInfo(JsonUtil.parseProductRestInfo(rs.getString("restInfo")));
                            product.setActive(rs.getBoolean("isActive"));
                            return product;
                        })
                        .one()
        );
    }

    public void update(Product product) {
        String sql = """
                UPDATE products
                SET name = :name,
                    price = :price,
                    quantity = :quantity,
                    description = :description,
                    rest_info = :restInfo,
                    brand_id = :brandId,
                    category_id = :categoryId,
                    promotion_id = :promotionId,
                    is_active = :isActive
                WHERE id = :id
                """;

        this.getJdbi().useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("name", product.getName())
                        .bind("price", product.getPrice())
                        .bind("quantity", product.getQuantity())
                        .bind("description", product.getDescription())
                        .bind("restInfo", JsonUtil.parseProductRestInfo(product.getRestInfo()))
                        .bind("brandId", product.getBrandId())
                        .bind("categoryId", product.getCategoryId())
                        .bind("promotionId", product.getPromotionId())
                        .bind("isActive", product.getActive())
                        .bind("id", product.getId())
                        .execute()
        );
    }
}
