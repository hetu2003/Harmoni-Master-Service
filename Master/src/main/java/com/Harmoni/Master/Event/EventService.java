package com.Harmoni.Master.Event;

import com.Harmoni.Master.Entity.*;
import com.Harmoni.Master.Repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EventService {

    private final EventRepository eventRepo;
    private final EventWorkhnadRepository eventWorkhnadRepo;
    private final EventCategoryRepository categoryRepo;
    private final EventSubcategoryRepository subcategoryRepo;
    private final CityRepository cityRepo;
    private final StateRepository stateRepo;


    @Transactional
    public Events createEvent(Long categoryId, Long subcategoryId, String eventName, LocalDateTime startDatetime, LocalDateTime endDatetime,
                              String streetAddress, Long stateId, Long cityId, String description, List<Integer> workhandCategoryIds,
                              List<Integer> numberOfWorkhandList, List<BigDecimal> priceList, Users company) {

        EventCategory category = categoryRepo.findById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("Category not found: " + categoryId));
        EventSubcategory subcat = subcategoryRepo.findById(subcategoryId)
                .orElseThrow(() -> new IllegalArgumentException("Subcategory not found: " + subcategoryId));
        City city = cityRepo.findById(cityId)
                .orElseThrow(() -> new IllegalArgumentException("City not found: " + cityId));
        State state = stateRepo.findById(stateId)
                .orElseThrow(() -> new IllegalArgumentException("State not found: " + stateId));

        int totalWorkhand = numberOfWorkhandList.stream().mapToInt(Integer::intValue).sum();
        BigDecimal totalPrice = priceList.stream().reduce(BigDecimal.ZERO, BigDecimal::add);

        Events event = Events.builder()
                .eventName(eventName)
                .eventCategory(category.getEventCategoryId().intValue())
                .eventSubcategory(subcat.getEventSubcategoryId().intValue())
                .description(description)
                .startDatetime(startDatetime)
                .endDatetime(endDatetime)
                .totalWorkhand(totalWorkhand)
                .totalPrice(totalPrice.intValue())
                .streetAddress(streetAddress)
                .city(city.getCityId().intValue())
                .state(state.getStateId().intValue())
                .company(company.getUserId().intValue())
                .build();
        event.setIsActive(1);
        event.setCreatedBy(company.getUserId().intValue());
        event.setModifiedBy(company.getUserId().intValue());
        eventRepo.save(event);

        saveWorkhnadSlots(event, workhandCategoryIds, numberOfWorkhandList, priceList, company);
        return event;
    }

    // ─────────────────────────────────────────────────────────────
    // UPDATE — edit event details + replace workhand slots
    // ─────────────────────────────────────────────────────────────

    @Transactional
    public Events updateEvent(Long eventId,
                             Long categoryId,
                             Long subcategoryId,
                             String eventName,
                             LocalDateTime startDatetime,
                             LocalDateTime endDatetime,
                             String streetAddress,
                             Long stateId,
                             Long cityId,
                             String description,
                             List<Integer> workhandCategoryIds,
                             List<Integer> numberOfWorkhandList,
                             List<BigDecimal> priceList,
                             Users company) {

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
        BigDecimal totalPrice = priceList.stream().reduce(BigDecimal.ZERO, BigDecimal::add);

        event.setEventName(eventName);
        event.setEventCategory(category.getEventCategoryId().intValue());
        event.setEventSubcategory(subcat.getEventSubcategoryId().intValue());
        event.setDescription(description);
        event.setStartDatetime(startDatetime);
        event.setEndDatetime(endDatetime);
        event.setTotalWorkhand(totalWorkhand);
        event.setTotalPrice(totalPrice.intValue());
        event.setStreetAddress(streetAddress);
        event.setCity(city.getCityId().intValue());
        event.setState(state.getStateId().intValue());
        event.setModifiedBy(company.getUserId().intValue());
        eventRepo.save(event);

        // Replace workhand slots: delete existing, insert new
        List<EventWorkhand> oldSlots = eventWorkhnadRepo.findByEvent(event.getId().intValue());
        eventWorkhnadRepo.deleteAll(oldSlots);
        saveWorkhnadSlots(event, workhandCategoryIds, numberOfWorkhandList, priceList, company);

        return event;
    }

    // ─────────────────────────────────────────────────────────────
    // DELETE (soft) — set is_active = 0 on event and its slots
    // ─────────────────────────────────────────────────────────────

    @Transactional
    public void softDeleteEvent(Long eventId, Users company) {
        Events event = eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));

        event.setIsActive(0);
        event.setModifiedBy(company.getUserId().intValue());
        eventRepo.save(event);

        // Soft-delete workhand slots too
        List<EventWorkhand> slots = eventWorkhnadRepo.findByEvent(event.getId().intValue());
        slots.forEach(slot -> {
            // EventWorkhand doesn't extend Auditable, so just delete physically
        });
        eventWorkhnadRepo.deleteAll(slots);
    }

    // ─────────────────────────────────────────────────────────────
    // Private helpers
    // ─────────────────────────────────────────────────────────────

    private void saveWorkhnadSlots(Events event,
                                   List<Integer> categoryIds,
                                   List<Integer> counts,
                                   List<BigDecimal> prices,
                                   Users company) {
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
}
