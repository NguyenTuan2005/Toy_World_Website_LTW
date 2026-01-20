package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Brand;
import com.n3.childrentoyweb.services.BrandService;
import com.n3.childrentoyweb.services.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

@WebServlet(value = "/admin/update-brands")
@MultipartConfig(
        maxFileSize = 5242880,      // 5MB
        maxRequestSize = 10485760,  // 10MB
        fileSizeThreshold = 0
)
public class UpdateBrandController extends HttpServlet {

    private CloudinaryService cloudinaryService;
    private BrandService brandService;

    @Override
    public void init() throws ServletException {
        this.cloudinaryService = new CloudinaryService();
        this.brandService = new BrandService();
    }



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Update brand  :))))");
        if(req.getParameter("brandId") == null || false){
            req.setAttribute("notify", "Sai thông tin");
            req.getRequestDispatcher("/adminPages/new-brand.jsp").forward(req, resp);
            return;
        }

        String brandName = req.getParameter("brandName");
        boolean isValidBrandName = brandName != null && !brandName.isEmpty();

        if (!isValidBrandName) {
            req.setAttribute("notify", "Tên không hợp lệ");
            req.getRequestDispatcher("/adminPages/update-brand.jsp").forward(req, resp);
            return;
        }
        String url = null;
        Part filePart = req.getPart("imgFile");

        if (filePart != null)
           url =  cloudinaryService.upload(filePart);

        boolean isActive = Boolean.parseBoolean(req.getParameter("active"));

        long id = Long.parseLong(req.getParameter("brandId"));
        Brand brand = this.brandService.findById(id).orElseThrow(ObjectNotFoundException::new);

        brand.setName(brandName);
        brand.setActive(isActive);
        if(url != null)
            brand.setImgPath(url);

        brandService.update(brand);

        req.setAttribute("notify", "Đã thêm thành công");
        resp.sendRedirect(req.getContextPath() + "/admin/update-brands?brandId="+req.getParameter("brandId"));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getParameter("brandId") == null){
            throw  new ObjectNotFoundException();
        }
        long  brandId = Long.parseLong(req.getParameter("brandId"));
        Brand brand = this.brandService.findById(brandId).orElseThrow(ObjectNotFoundException::new);

        req.setAttribute("brand",brand);
        req.getRequestDispatcher("/adminPages/update-brand.jsp").forward(req,resp);
    }


}
