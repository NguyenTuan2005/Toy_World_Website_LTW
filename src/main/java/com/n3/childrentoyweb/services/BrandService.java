package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.BrandDAO;
import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.ManageBrandDTO;
import com.n3.childrentoyweb.dto.ManageUserDTO;
import com.n3.childrentoyweb.models.Brand;

import java.util.List;
import java.util.Optional;

public class BrandService {
    private BrandDAO brandDAO;

    public BrandService() {
        this.brandDAO = new BrandDAO();
    }

    public List<Brand> findAll() {
        return brandDAO.findALl();
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
}
