package com.n3.childrentoyweb.controllers.account;

import com.n3.childrentoyweb.models.Location;
import com.n3.childrentoyweb.models.User;
import com.n3.childrentoyweb.services.LocationService;
import com.n3.childrentoyweb.services.UserService;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet(value = "/account/profile/edit")
public class EditProfileController extends HttpServlet {
    private LocationService locationService;
    private UserService userService;
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.locationService = new LocationService();
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User currentUser  = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Long userId = currentUser.getId();

        Location currentUserLocation = locationService.findByUserId(userId);
        session.setAttribute("currentUserLocation",currentUserLocation);


        request.getRequestDispatcher("/myAccount/account-edit-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User currentUser = (User) request.getSession().getAttribute("currentUser");
        Location currentLocation = (Location) request.getSession().getAttribute("currentUserLocation");

        if (currentUser == null || currentLocation == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String province = request.getParameter("province");

        try {

            userService.update(currentUser.getId(), firstName, lastName, phone);

            Location location = new Location(address, province);
            location.setId(currentLocation.getId());
            locationService.update(location);


            Optional<User> updatedUser = userService.findById(currentUser.getId());
            User updatedCurrentUser = updatedUser.orElseThrow();
            updatedCurrentUser.setPassword(null);
            Location updatedUserLocation = locationService.findByUserId(currentUser.getId());

            request.getSession().setAttribute("currentUser", updatedCurrentUser);
            request.getSession().setAttribute("currentUserLocation", updatedUserLocation);

            response.sendRedirect(request.getContextPath() + "/account/profile");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/account/profile");
        }


    }
}