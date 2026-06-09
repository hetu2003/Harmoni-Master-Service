package com.Harmoni.Master.EventList;

import com.Harmoni.Master.Entity.EventCategory;
import com.Harmoni.Master.Entity.Events;
import org.springframework.data.domain.Page;

import java.util.List;

public interface EventListService {
    Page<Events> getUpcomingEvents(int page, int pageSize, Long catId);
    List<EventCategory> getAllCategories();
    Page<Events> searchUpcomingEvents(String keyword, Long catId, int page, int pageSize);
}
