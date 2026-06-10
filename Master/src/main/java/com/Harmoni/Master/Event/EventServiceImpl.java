package com.Harmoni.Master.Event;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {

    private final EventRepository          eventRepo;
    private final EventWorkhnadRepository  eventWorkhnadRepo;
    private final EventCategoryRepository  eventCategoryRepo;
    private final EventSubcategoryRepository eventSubcategoryRepo;
    private final CityRepository           cityRepo;
    private final StateRepository          stateRepo;

    @Value("${upload.dir:src/main/resources/static/assets/uploads}")
    private String uploadDir;

    @Override
    @Transactional
    public Events createEvent(Long categoryId, Long subcategoryId, String eventName,
                              LocalDateTime startDatetime, LocalDateTime endDatetime,
                              String streetAddress, Long stateId, Long cityId, String description,
                              List<Integer> workhandCategoryIds, List<Integer> numberOfWorkhandList,
                              List<BigDecimal> priceList, Users company, MultipartFile imageFile) {

        int totalWorkhand = numberOfWorkhandList.stream().mapToInt(Integer::intValue).sum();
        int totalPrice = 0;
        for (int i = 0; i < priceList.size(); i++) {
            totalPrice += priceList.get(i).multiply(BigDecimal.valueOf(numberOfWorkhandList.get(i))).intValue();
        }

        String imagePath = saveImage(imageFile);

        Events event = Events.builder()
                .eventName(eventName)
                .description(description)
                .startDatetime(startDatetime)
                .endDatetime(endDatetime)
                .streetAddress(streetAddress)
                .stateId(stateId.intValue())
                .cityId(cityId.intValue())
                .eventCategoryId(categoryId.intValue())
                .eventSubcategoryId(subcategoryId.intValue())
                .companyId(company.getUserId().intValue())
                .totalWorkhand(totalWorkhand)
                .totalPrice(totalPrice)
                .imagePath(imagePath)
                .featured(false)
                .isActive(1)
                .createdAt(new Timestamp(System.currentTimeMillis()))
                .createdBy(company.getUserId().intValue())
                .build();

        Events saved = eventRepo.save(event);
        saveWorkhnadSlots(saved, workhandCategoryIds, numberOfWorkhandList, priceList);
        return saved;
    }

    @Override
    @Transactional
    public Events updateEvent(Long eventId, Long categoryId, Long subcategoryId, String eventName,
                              LocalDateTime startDatetime, LocalDateTime endDatetime,
                              String streetAddress, Long stateId, Long cityId, String description,
                              List<Integer> workhandCategoryIds, List<Integer> numberOfWorkhandList,
                              List<BigDecimal> priceList, Users company, MultipartFile imageFile) {

        Events event = eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));

        int totalWorkhand = numberOfWorkhandList.stream().mapToInt(Integer::intValue).sum();
        int totalPrice = 0;
        for (int i = 0; i < priceList.size(); i++) {
            totalPrice += priceList.get(i).multiply(BigDecimal.valueOf(numberOfWorkhandList.get(i))).intValue();
        }

        String imagePath = saveImage(imageFile);

        event.setEventName(eventName);
        event.setDescription(description);
        event.setStartDatetime(startDatetime);
        event.setEndDatetime(endDatetime);
        event.setStreetAddress(streetAddress);
        event.setStateId(stateId.intValue());
        event.setCityId(cityId.intValue());
        event.setEventCategoryId(categoryId.intValue());
        event.setEventSubcategoryId(subcategoryId.intValue());
        event.setTotalWorkhand(totalWorkhand);
        event.setTotalPrice(totalPrice);
        event.setModifiedBy(company.getUserId().intValue());
        event.setModifiedOn(new Timestamp(System.currentTimeMillis()));
        if (imagePath != null) {
            event.setImagePath(imagePath);
        }

        Events saved = eventRepo.save(event);
        saveWorkhnadSlots(saved, workhandCategoryIds, numberOfWorkhandList, priceList);
        return saved;
    }

    @Override
    @Transactional
    public void softDeleteEvent(Long eventId, Users company) {
        Events event = eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));
        event.setIsActive(0);
        event.setModifiedBy(company.getUserId().intValue());
        event.setModifiedOn(new Timestamp(System.currentTimeMillis()));
        eventRepo.save(event);
    }

    private void saveWorkhnadSlots(Events event, List<Integer> workhandCategoryIds,
                                   List<Integer> numberOfWorkhandList, List<BigDecimal> priceList) {
        List<EventWorkhand> existing = eventWorkhnadRepo.findByEvent(event.getId().intValue());
        if (!existing.isEmpty()) {
            eventWorkhnadRepo.deleteAll(existing);
        }
        for (int i = 0; i < workhandCategoryIds.size(); i++) {
            EventWorkhand slot = EventWorkhand.builder()
                    .event(event.getId().intValue())
                    .workhnadCategoryId(workhandCategoryIds.get(i))
                    .numberOfWorkhand(numberOfWorkhandList.get(i))
                    .price(priceList.get(i))
                    .isActive(1)
                    .createdAt(new Timestamp(System.currentTimeMillis()))
                    .build();
            eventWorkhnadRepo.save(slot);
        }
    }

    private String saveImage(MultipartFile imageFile) {
        if (imageFile == null || imageFile.isEmpty()) return null;
        try {
            String ext = "";
            String original = imageFile.getOriginalFilename();
            if (original != null && original.contains(".")) {
                ext = original.substring(original.lastIndexOf('.'));
            }
            String fileName = UUID.randomUUID() + ext;
            File dir = new File(uploadDir + "/events");
            if (!dir.exists()) dir.mkdirs();
            imageFile.transferTo(new File(dir, fileName));
            return "assets/uploads/events/" + fileName;
        } catch (IOException e) {
            throw new RuntimeException("Failed to save image: " + e.getMessage(), e);
        }
    }
}
