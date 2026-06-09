package com.Harmoni.Master.Event;

import com.Harmoni.Master.Entity.*;
import com.Harmoni.Master.Repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class EventService {

    private final EventRepository eventRepo;
    private final EventWorkhnadRepository eventWorkhnadRepo;
    private final EventCategoryRepository categoryRepo;
    private final EventSubcategoryRepository subcategoryRepo;
    private final CityRepository cityRepo;
    private final StateRepository stateRepo;

    @Value("${upload.dir:src/main/resources/static/assets/uploads}")
    private String uploadDir;

    @Transactional
    public Events createEvent(Long categoryId, Long subcategoryId, String eventName,
                              LocalDateTime startDatetime, LocalDateTime endDatetime,
                              String streetAddress, Long stateId, Long cityId, String description,
                              List<Integer> workhandCategoryIds, List<Integer> numberOfWorkhandList,
                              List<BigDecimal> priceList, Users company, MultipartFile imageFile) {

        EventCategory category = categoryRepo.findById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("Category not found: " + categoryId));
        EventSubcategory subcat = subcategoryRepo.findById(subcategoryId)
                .orElseThrow(() -> new IllegalArgumentException("Subcategory not found: " + subcategoryId));
        City city = cityRepo.findById(cityId)
                .orElseThrow(() -> new IllegalArgumentException("City not found: " + cityId));
        State state = stateRepo.findById(stateId)
                .orElseThrow(() -> new IllegalArgumentException("State not found: " + stateId));

        int totalWorkhand = numberOfWorkhandList.stream().mapToInt(Integer::intValue).sum();
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (int i = 0; i < priceList.size(); i++) {
            totalPrice = totalPrice.add(priceList.get(i).multiply(BigDecimal.valueOf(numberOfWorkhandList.get(i))));
        }

        String imagePath = saveImage(imageFile);

        Events event = Events.builder()
                .eventName(eventName)
                .eventCategoryId(category.getEventCategoryId().intValue())
                .eventSubcategoryId(subcat.getEventSubcategoryId().intValue())
                .description(description)
                .startDatetime(startDatetime)
                .endDatetime(endDatetime)
                .totalWorkhand(totalWorkhand)
                .totalPrice(totalPrice.intValue())
                .streetAddress(streetAddress)
                .cityId(city.getId().intValue())
                .stateId(state.getId().intValue())
                .companyId(company.getUserId().intValue())
                .imagePath(imagePath)
                .build();
        event.setIsActive(1);
        event.setCreatedBy(company.getUserId().intValue());
        event.setModifiedBy(company.getUserId().intValue());
        eventRepo.save(event);

        saveWorkhnadSlots(event, workhandCategoryIds, numberOfWorkhandList, priceList);
        return event;
    }

    @Transactional
    public Events updateEvent(Long eventId, Long categoryId, Long subcategoryId, String eventName,
                              LocalDateTime startDatetime, LocalDateTime endDatetime,
                              String streetAddress, Long stateId, Long cityId, String description,
                              List<Integer> workhandCategoryIds, List<Integer> numberOfWorkhandList,
                              List<BigDecimal> priceList, Users company, MultipartFile imageFile) {

        Events event = eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));

        EventCategory category = categoryRepo.findById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("Category not found: " + categoryId));
        EventSubcategory subcat = subcategoryRepo.findById(subcategoryId)
                .orElseThrow(() -> new IllegalArgumentException("Subcategory not found: " + subcategoryId));
        City city = cityRepo.findById(cityId)
                .orElseThrow(() -> new IllegalArgumentException("City not found: " + cityId));
        State state = stateRepo.findById(stateId)
                .orElseThrow(() -> new IllegalArgumentException("State not found: " + stateId));

        int totalWorkhand = numberOfWorkhandList.stream().mapToInt(Integer::intValue).sum();
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (int i = 0; i < priceList.size(); i++) {
            totalPrice = totalPrice.add(priceList.get(i).multiply(BigDecimal.valueOf(numberOfWorkhandList.get(i))));
        }

        event.setEventName(eventName);
        event.setEventCategoryId(category.getEventCategoryId().intValue());
        event.setEventSubcategoryId(subcat.getEventSubcategoryId().intValue());
        event.setDescription(description);
        event.setStartDatetime(startDatetime);
        event.setEndDatetime(endDatetime);
        event.setTotalWorkhand(totalWorkhand);
        event.setTotalPrice(totalPrice.intValue());
        event.setStreetAddress(streetAddress);
        event.setCityId(city.getId().intValue());
        event.setStateId(state.getId().intValue());
        event.setModifiedBy(company.getUserId().intValue());

        String newImage = saveImage(imageFile);
        if (newImage != null) event.setImagePath(newImage);

        eventRepo.save(event);

        List<EventWorkhand> oldSlots = eventWorkhnadRepo.findByEvent(event.getId().intValue());
        eventWorkhnadRepo.deleteAll(oldSlots);
        saveWorkhnadSlots(event, workhandCategoryIds, numberOfWorkhandList, priceList);
        return event;
    }

    @Transactional
    public void softDeleteEvent(Long eventId, Users company) {
        Events event = eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));
        event.setIsActive(0);
        event.setModifiedBy(company.getUserId().intValue());
        eventRepo.save(event);
        List<EventWorkhand> slots = eventWorkhnadRepo.findByEvent(event.getId().intValue());
        eventWorkhnadRepo.deleteAll(slots);
    }

    // ── helpers ──────────────────────────────────────────────────────────────

    private void saveWorkhnadSlots(Events event, List<Integer> categoryIds,
                                   List<Integer> counts, List<BigDecimal> prices) {
        for (int i = 0; i < categoryIds.size(); i++) {
            EventWorkhand slot = EventWorkhand.builder()
                    .event(event.getId().intValue())
                    .workhnadCategoryId(categoryIds.get(i))
                    .numberOfWorkhand(counts.get(i))
                    .price(prices.get(i))
                    .build();
            eventWorkhnadRepo.save(slot);
        }
    }

    private String saveImage(MultipartFile file) {
        if (file == null || file.isEmpty()) return null;
        try {
            Path dir = Paths.get(uploadDir, "events");
            Files.createDirectories(dir);
            String ext = "";
            String orig = file.getOriginalFilename();
            if (orig != null && orig.contains(".")) ext = orig.substring(orig.lastIndexOf('.'));
            String filename = UUID.randomUUID() + ext;
            Files.write(dir.resolve(filename), file.getBytes());
            return "assets/uploads/events/" + filename;
        } catch (IOException e) {
            System.err.println("Image upload failed: " + e.getMessage());
            return null;
        }
    }
}
