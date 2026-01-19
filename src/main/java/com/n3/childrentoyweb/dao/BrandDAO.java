package com.n3.childrentoyweb.dao;

import com.n3.childrentoyweb.dto.BrandCriteria;
import com.n3.childrentoyweb.dto.BrandFilterDTO;
import com.n3.childrentoyweb.dto.ManageBrandDTO;
import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.models.Brand;
import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;

import java.util.List;
import java.util.Optional;

public class BrandDAO  extends BaseDAO{
    public List<Brand> findALl() {
        String sql = """
                select * from brands
                where is_active = 1
                order by name
                """;
        return this.getJdbi().withHandle(handle ->
                    handle.createQuery(sql)
                            .mapToBean(Brand.class)
                            .list()
                );
    }

    public List<BrandFilterDTO> findBrandProductCount() {
        String sql = """
        SELECT b.id ,
               b.name,
               COUNT(p.id) AS productCount
        FROM brands b
        LEFT JOIN products p ON p.brand_id = b.id
        WHERE b.is_active = 1
        GROUP BY b.id
        ORDER BY b.name
        """;

        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .registerRowMapper(BeanMapper.factory(BrandFilterDTO.class))
                        .mapToBean(BrandFilterDTO.class)
                        .list()
        );
    }

    public int countAllBrands(){
        String sql = """
                    select count(b.id)
                    from brands b
                    """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                .mapTo(int.class)
                .one());
    }

   public List<ManageBrandDTO> findAllBrandsForManagements(int page, int pageSize){
       int offset = (page - 1) * pageSize;
        String sql = """
                select b.id,
                        b.name,
                        b.img_path,
                        b.created_at,
                        b.is_active,
                        (select count(p.id)
                         from products p
                         where p.brand_id = b.id) as quantity
                 from brands b
                 limit :limit offset :offsets
                 """;

       return this.getJdbi().withHandle(handle ->
               handle.createQuery(sql)
                       .bind("limit",pageSize)
                       .bind("offsets",offset)
                       .map((rs, ctx) -> {
                           ManageBrandDTO manageBrandDTO = new ManageBrandDTO();
                           manageBrandDTO.setId(rs.getLong("id"));
                           manageBrandDTO.setName(rs.getString("name"));
                           manageBrandDTO.setLogo(rs.getString("img_path"));
                           manageBrandDTO.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                           manageBrandDTO.setStatus(rs.getBoolean("is_active"));
                           manageBrandDTO.setQuantity(rs.getInt("quantity"));
                           return manageBrandDTO;
                       })
                       .list()
       );
   }

    public Brand findById(long id) {
        String sql = """
                select * from brands
                where id =:id
                """;
        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id",id)
                        .mapToBean(Brand.class)
                        .one()
        );
    }

    public int update(Brand brand) {
        String sql = """
                update brands
                set name =:name, img_path =:logo, is_active =:isActive
                where id =:id
                """;
        return  this.getJdbi().withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind("id",brand.getId())
                            .bind("logo",brand.getImgPath())
                            .bind("isActive",brand.getActive())
                            .bind("name",brand.getName())
                            .execute()
            );
    }
    public void save(Brand brand) {
        String sql = """
        insert into brands (name, img_path, is_active)
        values (:name, :imgPath, :isActive)
        """;

        this.getJdbi().useHandle(handle ->
                handle.createUpdate(sql)
                        .bind("name", brand.getName())
                        .bind("imgPath", brand.getImgPath())
                        .bind("isActive", brand.getActive())
                        .execute()
        );
    }

    public List<ManageBrandDTO> findBrandsByCriteria(BrandCriteria brandCriteria) {
        StringBuilder sql = new StringBuilder("""
                       select b.id,
                        b.name,
                        b.img_path,
                        b.created_at,
                        b.is_active,
                        (select count(p.id)
                         from products p
                         where p.brand_id = b.id) as quantity
                 from brands b
                 where 1 = 1
                 """);
        sql.append(brandCriteria.getIdForSql());
        sql.append(brandCriteria.getNameForSql());
        sql.append(" limit 10");
        System.out.println(sql);


        return this.getJdbi().withHandle(handle ->
                handle.createQuery(sql)
                        .map((rs, ctx) -> {
                            ManageBrandDTO manageBrandDTO = new ManageBrandDTO();
                            manageBrandDTO.setId(rs.getLong("id"));
                            manageBrandDTO.setName(rs.getString("name"));
                            manageBrandDTO.setLogo(rs.getString("img_path"));
                            manageBrandDTO.setCreatedAt(LocalDateTimeConverterUtil.convertToLocalDateTime(rs.getString("created_at")));
                            manageBrandDTO.setStatus(rs.getBoolean("is_active"));
                            manageBrandDTO.setQuantity(rs.getInt("quantity"));
                            return manageBrandDTO;
                        })
                        .list()
        );
    }
}
