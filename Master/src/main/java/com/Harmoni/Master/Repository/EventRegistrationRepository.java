package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.EventRegistration;
import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EventRegistrationRepository extends JpaRepository<EventRegistration, Long> {

    // Check if workhand already registered for an event
    List<EventRegistration> findByWorkhandAndEvent(Users workhand, Events event);

    // All registrations for a workhand (paginated for history page)
    Page<EventRegistration> findByWorkhand(Users workhand, Pageable pageable);

    // All registrations for an event (for vendor requests list)
    List<EventRegistration> findByEvent(Events event);

    // All registrations for an event, ordered by event_workhand_id desc (pending requests view)
    List<EventRegistration> findByEventOrderByEventWorkhnadIdDesc(Events event);

    // Approved registrations for an event
    List<EventRegistration> findByEventAndRegistrationStatusTrue(Events event);

    // Approved registrations ordered for the approved-requests view
    List<EventRegistration> findByEventAndRegistrationStatusTrueOrderByEventWorkhandEventWorkhnadIdAsc(Events event);

    // Count approved registrations for a specific event_workhand slot (capacity check)
    long countByEventWorkhandAndRegistrationStatusTrue(EventWorkhand eventWorkhand);

    // Approved registrations for a specific workhand on a specific event (feedback eligibility)
    List<EventRegistration> findByWorkhandAndRegistrationStatusTrueAndEvent(Users workhand, Events event);

    // Average rating for a workhand across all paid registrations
    @Query("SELECT AVG(er.rating) FROM EventRegistration er " +
            "WHERE er.workhand = :w AND er.registrationStatus = true AND er.rating IS NOT NULL")
    Double findAverageRatingByWorkhand(@Param("w") Users workhand);
}
