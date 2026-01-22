package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.CategoryDAO;
import com.n3.childrentoyweb.dto.CategoryFilterDTO;
import com.n3.childrentoyweb.models.Category;

import java.util.List;

public class CategoryService{
    private CategoryDAO categoryDAO;

    public CategoryService() {
        this.categoryDAO = new CategoryDAO();
    }

    public List<CategoryFilterDTO> findCategoryProductCount() {
        return this.categoryDAO.findCategoryProductCount();
    }

    public List<Category> findAll() {
        return this.categoryDAO.findAll();
    }
}
