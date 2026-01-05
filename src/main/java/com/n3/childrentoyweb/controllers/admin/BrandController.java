package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.dto.BrandCriteria;
import com.n3.childrentoyweb.dto.ManageBrandDTO;
import com.n3.childrentoyweb.services.BrandService;
import com.n3.childrentoyweb.services.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BrandManage",value = "/admin/brands")
public class BrandController extends HttpServlet {
    public static final int  PAGE_SIZE = 10;
    private BrandService brandService;
    private CloudinaryService cloudinaryService;

    public void init(){
        this.brandService = new BrandService();
        this.cloudinaryService = new CloudinaryService();
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page =1;
        if(req.getParameter("page") != null){
            page = Integer.parseInt(req.getParameter("page"));
        }
        this.addBrandIntoTable(page,req);

        req.getRequestDispatcher("/adminPages/brands.jsp").forward(req,resp);
    }

    //FInd by brandCriteria
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        System.out.println(" keyword : "+keyword);
        BrandCriteria brandCriteria = new BrandCriteria(keyword);
        System.out.println(brandCriteria);
        this.findBrandsByCriteria(brandCriteria,req);

        req.getRequestDispatcher("/adminPages/brands.jsp").forward(req,resp);
    }

    private void findBrandsByCriteria(BrandCriteria brandCriteria,HttpServletRequest request){
        Pagination<ManageBrandDTO> manageBrandDTOPagination = this.brandService.findBrandsByCriteria(brandCriteria);

        request.setAttribute("brandManages",manageBrandDTOPagination.getData());
        request.setAttribute("currentPage",manageBrandDTOPagination.getCurrentPage());
        request.setAttribute("totalElements",manageBrandDTOPagination.getTotalElements());
        request.setAttribute("totalPages",manageBrandDTOPagination.getTotalPages());
        request.setAttribute("pageSize",PAGE_SIZE);
        request.setAttribute("find_brand","active");
    }

    public void addBrandIntoTable(int page, HttpServletRequest request){
        Pagination<ManageBrandDTO> manageBrandDTOPagination = this.brandService.findAllBrandsForManagements(page,PAGE_SIZE);
        List<ManageBrandDTO> manageBrandDTOS = manageBrandDTOPagination.getData();

        request.setAttribute("brandManages",manageBrandDTOS);
        request.setAttribute("currentPage",manageBrandDTOPagination.getCurrentPage());
        request.setAttribute("totalElements",manageBrandDTOPagination.getTotalElements());
        request.setAttribute("totalPages",manageBrandDTOPagination.getTotalPages());
        request.setAttribute("pageSize",PAGE_SIZE);
    }



}
