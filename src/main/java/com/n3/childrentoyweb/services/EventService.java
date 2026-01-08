package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dao.EventDAO;
import com.n3.childrentoyweb.dao.Pagination;
import com.n3.childrentoyweb.models.Event;

import java.util.List;

public class EventService {
    private EventDAO eventDAO;

    public EventService(){
        this.eventDAO = new EventDAO();
    }

    public int getTotalEvent() {
        return eventDAO.countTotalEvent();
    }

    public int getOngoingEvent() {
        return eventDAO.countOngoingEvent();
    }

    public int getUpcomingEvent() {
        return eventDAO.countUpcomingEvent();
    }

    public int getEndedEvent() {
        return eventDAO.countEndedEvent();
    }

    public Long createEvent(Event event){
        return eventDAO.save(event);
    }

    public void updateEvent(Event event){
        eventDAO.update(event);
    }

    public Pagination<Event> findEventForManagement(int page, int pageSize){
        List<Event> events = this.eventDAO.findEventForManagement(page,pageSize);
        int totalElements = this.eventDAO.countTotalEvent();
        int totalPages = totalElements / pageSize;
        return new Pagination<>(events,page,totalElements,totalPages);
    }

}
