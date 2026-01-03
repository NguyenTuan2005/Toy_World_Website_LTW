package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.HomeProductDTO;
import com.n3.childrentoyweb.dto.ProductDetailDTO;
import com.n3.childrentoyweb.dto.ProductPromotionDTO;
import com.n3.childrentoyweb.models.Product;
import com.n3.childrentoyweb.utils.JsonColumnMapper;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.net.URL;
import java.util.List;
import java.util.Optional;

public class ProductDAO  extends BaseDAO{

    public List<Product> findAll() {
        String sql = """
            SELECT id, name, price, quantity, description,
                   brand_id AS brandId,
                   category_id AS categoryId
            FROM products
            WHERE is_active = 1
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .registerRowMapper(BeanMapper.factory(Product.class))
                        .mapTo(Product.class)
                        .list()
        );
    }

    public List<Product> findAllByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        String sql = """
            SELECT id, name, price, quantity, description,
                   brand_id AS brandId,
                   category_id AS categoryId
            FROM products
            WHERE is_active = 1
            LIMIT :pageSize OFFSET :offset
        """;

        return super.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("offset", offset)
                        .bind("pageSize", pageSize)
                        .registerRowMapper(BeanMapper.factory(Product.class))
                        .mapTo(Product.class)
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

    public static void main(String[] args) {
        System.out.println(new ProductDAO().findProductsByPromotionId(10L));
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

}
