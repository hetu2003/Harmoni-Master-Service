package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.EventRegistration;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EventRegistrationRepository extends JpaRepository<EventRegistration, Long> {

    List<EventRegistration> findByWorkhandAndEvent(Integer workhandId, Integer eventId);

    List<EventRegistration> findByEventOrderByEventWorkhandAsc(Integer eventId);

    List<EventRegistration> findByEventAndRegistrationStatusTrueOrderByEventWorkhandAsc(Integer eventId);

    List<EventRegistration> findByEventAndRegistrationStatusTrue(Integer eventId);

    List<EventRegistration> findByWorkhandAndRegistrationStatusTrue(Integer workhandId);

    /** Paginated history for a workhand's own profile page */
    Page<EventRegistration> findByWorkhand(Integer workhandId, Pageable pageable);

    long countByEvent(Integer eventId);

    long countByEventAndRegistrationStatusTrue(Integer eventId);

    long countByEventAndPaymentStatusTrue(Integer eventId);

    long countByEventWorkhandAndRegistrationStatusTrue(Integer eventWorkhandId);

    @Query("SELECT AVG(er.rating) FROM EventRegistration er WHERE er.workhand = :workhandId AND er.rating IS NOT NULL")
    Double findAverageRatingByWorkhand(@Param("workhandId") Integer workhandId);

    List<EventRegistration> findByEventOrderByRegistrationDateDesc(Integer eventId);

    @Query("SELECT er FROM EventRegistration er WHERE er.workhand = :workhandId AND er.event = :eventId AND er.registrationStatus = true")
    List<EventRegistration> findApprovedByWorkhandAndEvent(
            @Param("workhandId") Integer workhandId,
            @Param("eventId") Integer eventId);

    List<EventRegistration> findByEventAndApplicationStatus(Integer eventId, String applicationStatus);

    long countByEventAndApplicationStatus(Integer eventId, String applicationStatus);

    long countByEventWorkhandAndApplicationStatus(Integer eventWorkhandId, String applicationStatus);

    /** Count all registrations for admin stats */
    long countByRegistrationStatusTrue();
    long countByPaymentStatusTrue();
}
