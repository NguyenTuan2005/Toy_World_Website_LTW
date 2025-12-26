package com.n3.childrentoyweb.controllers;

import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.LocationService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(value = "/account")
public class MyAccountController extends HttpServlet {
    private LocationService locationService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.locationService = new LocationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        User currentUser  = (User) session.getAttribute("currentUser");

        Location currentUserLocation = locationService.findByUserId(currentUser.getId());

        session.setAttribute("currentUserLocation",currentUserLocation);

        request.getRequestDispatcher("/my-account.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}