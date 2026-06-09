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
import java.util.stream.Collectors;

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
            // The repository method expects an Integer, not an EventCategory object
            return eventRepo.findByStartDatetimeAfterAndEventCategoryOrderByStartDatetime(now, catId.intValue(), pageable);
        }
        return eventRepo.findByStartDatetimeAfterOrderByStartDatetime(now, pageable);
    }

    @Override
    public List<EventCategory> getAllCategories() {
        return eventCategoryRepo.findAll();
    }

    @Override
    public List<Events> searchUpcomingEvents(String keyword, Long catId) {
        LocalDateTime now = LocalDateTime.now();
        List<Events> results = eventRepo.searchByKeyword(keyword.trim())
                .stream()
                .filter(e -> e.getStartDatetime().isAfter(now))
                .collect(Collectors.toList());

        if (catId != null) {
            results = results.stream()
                    .filter(e -> e.getEventCategory().equals(catId.intValue()))
                    .collect(Collectors.toList());
        }
        return results;
    }
}
