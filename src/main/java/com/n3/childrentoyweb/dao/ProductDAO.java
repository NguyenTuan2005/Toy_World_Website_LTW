package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.HomeProductDTO;
import com.n3.childrentoyweb.dto.ProductDetailDTO;
import com.n3.childrentoyweb.dto.ProductListDTO;
import com.n3.childrentoyweb.dto.ProductPromotionDTO;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.utils.JsonColumnMapper;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Optional;

public class ProductDAO  extends BaseDAO{

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

    public List<ProductListDTO> findAllByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        String sql = """
        SELECT p.id,
               p.name,
               p.price AS originPrice,
               p.quantity,
               b.name AS brand,
               c.name AS category,
               pm.discount_percent AS discountPercent,
               pm.discount_price AS maxDiscountPrice,
               pa.img_path AS imgPath
        FROM products p
        JOIN brands b ON p.brand_id = b.id
        JOIN categories c ON p.category_id = c.id
        LEFT JOIN promotions pm ON p.promotion_id = pm.id
        LEFT JOIN product_assets pa ON p.id = pa.product_id
        WHERE p.id IN (<ids>)
        ORDER BY p.id
        """;

        return this.getJdbi().withHandle(handle -> {

            List<Long> ids = handle.createQuery("""
            SELECT id
            FROM products
            WHERE is_active = 1
            ORDER BY id
            LIMIT :pageSize OFFSET :offset
            """).bind("pageSize", pageSize)
                    .bind("offset", offset)
                    .mapTo(Long.class)
                    .list();

            if (ids.isEmpty()) return List.of();


            return handle.createQuery(sql)
                        .bindList("ids", ids)
                        .reduceRows(new LinkedHashMap<Long, ProductListDTO>(), (map, rowView) -> {

                            Long productId = rowView.getColumn("id", Long.class);

                            ProductListDTO dto = map.computeIfAbsent(productId, id -> {
                                ProductListDTO p = new ProductListDTO();
                                p.setId(id);
                                p.setName(rowView.getColumn("name", String.class));

                                long originPrice = rowView.getColumn("originPrice", Long.class);
                                p.setOriginPrice(originPrice);

                                Double discountPercent =
                                        rowView.getColumn("discountPercent", Double.class);
                                Long maxDiscountPrice =
                                        rowView.getColumn("maxDiscountPrice", Long.class);

                                p.setDiscountPercent(discountPercent != null ? discountPercent : 0);
                                p.setMaxDiscountPrice(maxDiscountPrice != null ? maxDiscountPrice : 0);

                                long finalPrice;
                                if (discountPercent != null && discountPercent > 0) {
                                    long discounted = Math.round(originPrice * (1 - discountPercent / 100));
                                    if (maxDiscountPrice != null && discounted > maxDiscountPrice) {
                                        finalPrice = maxDiscountPrice;
                                    } else {
                                        finalPrice = discounted;
                                    }
                                } else if (maxDiscountPrice != null && maxDiscountPrice > 0) {
                                    finalPrice = maxDiscountPrice;
                                } else {
                                    finalPrice = originPrice;
                                }
                                p.setFinalPrice(finalPrice);

                                p.setQuantity(rowView.getColumn("quantity", Integer.class));
                                p.setBrand(rowView.getColumn("brand", String.class));
                                p.setCategory(rowView.getColumn("category", String.class));

                                p.setImgPaths(new ArrayList<>());
                                return p;
                            });

                            String img = rowView.getColumn("imgPath", String.class);
                            if (img != null) {
                                dto.getImgPaths().add(img);
                            }

                            return map;
                        })
                        .values()
                        .stream()
                        .toList();
        });
    }

    public List<ProductListDTO> findByFilter(List<Integer> brandIds, int pageSize, int offset) {
        if(brandIds == null || brandIds.isEmpty()){
            throw new IllegalArgumentException("BrandIds must not be empty");
        }

        String sql = """
        SELECT p.id,
               p.name,
               p.price AS originPrice,
               p.quantity,
               b.name AS brand,
               c.name AS category,
               pm.discount_percent AS discountPercent,
               pm.discount_price AS maxDiscountPrice,
               pa.img_path AS imgPath
        FROM products p
        JOIN brands b ON p.brand_id = b.id
        JOIN categories c ON p.category_id = c.id
        LEFT JOIN promotions pm ON p.promotion_id = pm.id
        LEFT JOIN product_assets pa ON p.id = pa.product_id
        WHERE p.id IN (<ids>)
        ORDER BY p.id
        """;

        return this.getJdbi().withHandle(handle -> {

            List<Long> ids = handle.createQuery("""
            SELECT id
            FROM products
            WHERE is_active = 1
                AND brand_id IN (<brandIds>)
            ORDER BY id
            LIMIT :pageSize OFFSET :offset
            """).bind("pageSize", pageSize)
                    .bind("offset", offset)
                    .bindList("brandIds", brandIds)
                    .mapTo(Long.class)
                    .list();

            if (ids.isEmpty()) return List.of();


            return handle.createQuery(sql)
                    .bindList("ids", ids)
                    .reduceRows(new LinkedHashMap<Long, ProductListDTO>(), (map, rowView) -> {

                        Long productId = rowView.getColumn("id", Long.class);

                        ProductListDTO dto = map.computeIfAbsent(productId, id -> {
                            ProductListDTO p = new ProductListDTO();
                            p.setId(id);
                            p.setName(rowView.getColumn("name", String.class));

                            long originPrice = rowView.getColumn("originPrice", Long.class);
                            p.setOriginPrice(originPrice);

                            Double discountPercent =
                                    rowView.getColumn("discountPercent", Double.class);
                            Long maxDiscountPrice =
                                    rowView.getColumn("maxDiscountPrice", Long.class);

                            p.setDiscountPercent(discountPercent != null ? discountPercent : 0);
                            p.setMaxDiscountPrice(maxDiscountPrice != null ? maxDiscountPrice : 0);

                            p.setQuantity(rowView.getColumn("quantity", Integer.class));
                            p.setBrand(rowView.getColumn("brand", String.class));
                            p.setCategory(rowView.getColumn("category", String.class));

                            p.setImgPaths(new ArrayList<>());
                            return p;
                        });

                        String img = rowView.getColumn("imgPath", String.class);
                        if (img != null) {
                            dto.getImgPaths().add(img);
                        }

                        return map;
                    })
                    .values()
                    .stream()
                    .toList();
        });
    }


    public int countAll() {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = 1";

        return super.getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public List<HomeProductDTO> findSignatureProduct(int page, int pageSize, String brandName){
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
                        .bind("brandName", "%"+brandName+"%")
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

    public List<HomeProductDTO> findNewImportProductsInMonth(int page, int pageSize){
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
                   rest_info AS restInfo,
                   brand_id AS brandId,
                   category_id AS categoryId
            FROM products
            WHERE is_active = 1 AND id = :id
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id",id)
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
                        .bind("id",id)
                        .registerColumnMapper(new JsonColumnMapper())
                        .registerRowMapper(BeanMapper.factory(ProductDetailDTO.class))
                        .mapTo(ProductDetailDTO.class)
                        .findOne()
        );

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
                    .map(((rs, ctx) ->{
                        ProductPromotionDTO productPromotionDTO = new ProductPromotionDTO();
                        productPromotionDTO.setId(rs.getLong("id"));
                        productPromotionDTO.setName(rs.getString("name"));
                        productPromotionDTO.setOriginalPrice(rs.getDouble("price"));
                        productPromotionDTO.setFirstImg(rs.getString("img_url"));
                        return productPromotionDTO;
                    } ))
                    .list();
        }) ;
    }

    public int countByFilter(List<Integer> brandIds) {

        if (brandIds != null && !brandIds.isEmpty()) {
            String sql = """
            SELECT COUNT(*)
            FROM products
            WHERE brand_id IN (<brandIds>)
              AND is_active = 1
            """;

            return getJdbi().withHandle(h ->
                    h.createQuery(sql)
                            .bindList("brandIds", brandIds)
                            .mapTo(Integer.class)
                            .one()
            );
        }

        String sql = """
        SELECT COUNT(*)
        FROM products
        WHERE is_active = 1
        """;

        return getJdbi().withHandle(h ->
                h.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }


    public static void main(String[] args) {
        System.out.println(new ProductDAO().findByFilter(List.of(1,2,3,5,6,7,8,9),10,0));
    }


}
