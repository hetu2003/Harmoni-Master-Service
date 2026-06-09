package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.EventRegistration;
import com.Harmoni.Master.Entity.Users;
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

    long countByEvent(Integer eventId);

    long countByEventAndRegistrationStatusTrue(Integer eventId);

    long countByEventAndPaymentStatusTrue(Integer eventId);

    long countByEventWorkhandAndRegistrationStatusTrue(Integer eventWorkhandId);

    @Query("SELECT AVG(er.rating) FROM EventRegistration er WHERE er.workhand = :workhandId AND er.rating IS NOT NULL")
    Double findAverageRatingByWorkhand(@Param("workhandId") Integer workhandId);
    
    // Add these methods that were missing but used in the original code
    List<EventRegistration> findByEventOrderByEventWorkhandDesc(Integer eventId);
    
    // Aliases to match VendorServiceImpl exactly
    default List<EventRegistration> findByEventOrderByEventWorkhnadIdDesc(Integer eventId) {
        return findByEventOrderByEventWorkhandDesc(eventId);
    }
    
    default List<EventRegistration> findByEventAndRegistrationStatusTrueOrderByEventWorkhandEventWorkhnadIdAsc(Integer eventId) {
        return findByEventAndRegistrationStatusTrueOrderByEventWorkhandAsc(eventId);
    }
}
