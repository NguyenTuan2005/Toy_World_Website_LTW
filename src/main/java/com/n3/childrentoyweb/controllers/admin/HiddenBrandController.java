package com.n3.childrentoyweb.controllers.admin;

import com.n3.childrentoyweb.exception.ObjectNotFoundException;
import com.n3.childrentoyweb.models.Brand;
import com.n3.childrentoyweb.services.BrandService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "HiddenBrand", value = "/admin/hidden-brands")
public class HiddenBrandController extends HttpServlet {

    private BrandService brandService;

    public void init(){
        this.brandService = new BrandService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{

            long brandId = Long.parseLong(req.getParameter("brandId"));
            Brand brand = this.brandService.findById(brandId).orElseThrow(ObjectNotFoundException::new);
            brand.revertActive();
            boolean isUpdated =  this.brandService.update(brand);
            req.setAttribute("isUpdated",isUpdated);
            System.out.println("isUpdated "+isUpdated);

        }catch (ObjectNotFoundException e){
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        } catch (Exception e){
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer);
    }
}
