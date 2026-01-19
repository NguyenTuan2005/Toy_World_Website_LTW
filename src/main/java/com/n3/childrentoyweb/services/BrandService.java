package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.BrandDAO;
import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.BrandCriteria;
import com.n3.childrentoyweb.dto.BrandFilterDTO;
import com.n3.childrentoyweb.dto.ManageBrandDTO;
import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.models.Brand;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public class BrandService {
    private BrandDAO brandDAO;

    public BrandService() {
        this.brandDAO = new BrandDAO();
    }

    public List<Brand> findAll() {
        return brandDAO.findALl();
    }

    public List<BrandFilterDTO> findBrandProductCount(){
        return brandDAO.findBrandProductCount();
    }


    public Pagination<ManageBrandDTO> findAllBrandsForManagements(int page, int pageSize){
        int totalElements = this.brandDAO.countAllBrands();

        int totalPages = totalElements / pageSize;

        List<ManageBrandDTO> manageBrandDTOS= this.brandDAO.findAllBrandsForManagements(page,pageSize);

        return new Pagination<>(manageBrandDTOS,page,totalElements,totalPages);
    }

    public Optional<Brand> findById(long id){
        return Optional.ofNullable(this.brandDAO.findById(id));
    }

    public boolean update(Brand brand) {
       return this.brandDAO.update(brand) > 0;
    }

    public void save(Brand brand) {
        this.brandDAO.save(brand);
    }

    public Pagination<ManageBrandDTO> findBrandsByCriteria(BrandCriteria brandCriteria) {
        List<ManageBrandDTO> manageBrandDTOS = this.brandDAO.findBrandsByCriteria(brandCriteria);
        return new Pagination<>(manageBrandDTOS,1, manageBrandDTOS.size(), 1);
    }



}
