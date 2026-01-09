package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.LocationDAO;
import com.n3.childrentoyweb.models.Location;

public class LocationService {
    private LocationDAO locationDAO = new LocationDAO();

    public Location findByUserId(Long userId){
        return locationDAO.findByUserId(userId);
    }

    public long save(Location location) {
        return this.locationDAO.save(location);
    }

    public Location update(Location location) {
        this.locationDAO.update(location);
        return location;
    }
}
