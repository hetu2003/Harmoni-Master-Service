package com.Harmoni.Master.EventList;

import com.Harmoni.Master.Entity.EventCategory;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Repository.EventCategoryRepository;
import com.Harmoni.Master.Repository.EventRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EventListServiceImpl implements EventListService {

    private final EventRepository eventRepo;
    private final EventCategoryRepository eventCategoryRepo;

    @Override
    public Page<Events> getUpcomingEvents(int page, int pageSize, Long catId) {
        LocalDateTime now = LocalDateTime.now();
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by("startDatetime").ascending());
        if (catId != null) {
            EventCategory cat = eventCategoryRepo.findById(catId).orElse(null);
            if (cat != null) {
                return eventRepo.findByStartDatetimeAfterAndEventCategoryOrderByStartDatetime(now, cat, pageable);
            }
        }
        return eventRepo.findByStartDatetimeAfterOrderByStartDatetime(now, pageable);
    }

    @Override
    public List<EventCategory> getAllCategories() {
        return eventCategoryRepo.findAll();
    }

    @Override
    public Page<Events> getRecentlyClosedEvents(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by("endDatetime").descending());
        return eventRepo.findRecentlyClosed(LocalDateTime.now(), pageable);
    }

    @Override
    public Page<Events> searchUpcomingEvents(String keyword, Long catId, int page, int pageSize) {
        LocalDateTime now = LocalDateTime.now();
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by("startDatetime").ascending());
        if (catId != null) {
            EventCategory cat = eventCategoryRepo.findById(catId).orElse(null);
            if (cat != null) {
                return eventRepo.searchUpcomingByCategory(keyword.trim(), now, cat, pageable);
            }
        }
        return eventRepo.searchUpcoming(keyword.trim(), now, pageable);
    }
}
