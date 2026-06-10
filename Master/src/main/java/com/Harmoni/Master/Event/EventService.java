package com.Harmoni.Master.Event;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public interface EventService {

    Events createEvent(Long categoryId, Long subcategoryId, String eventName,
                       LocalDateTime startDatetime, LocalDateTime endDatetime,
                       String streetAddress, Long stateId, Long cityId, String description,
                       List<Integer> workhandCategoryIds, List<Integer> numberOfWorkhandList,
                       List<BigDecimal> priceList, Users company, MultipartFile imageFile);

    Events updateEvent(Long eventId, Long categoryId, Long subcategoryId, String eventName,
                       LocalDateTime startDatetime, LocalDateTime endDatetime,
                       String streetAddress, Long stateId, Long cityId, String description,
                       List<Integer> workhandCategoryIds, List<Integer> numberOfWorkhandList,
                       List<BigDecimal> priceList, Users company, MultipartFile imageFile);

    void softDeleteEvent(Long eventId, Users company);
}
