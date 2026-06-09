package com.Harmoni.Master.EventList;

import com.Harmoni.Master.Entity.EventCategory;
import com.Harmoni.Master.Entity.Events;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface EventListService {
    Page<Events> getUpcomingEvents(int page, int pageSize, Long catId);
    List<EventCategory> getAllCategories();
    List<Events> searchUpcomingEvents(String keyword, Long catId);
}
