package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.EventWorkhand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface EventWorkhnadRepository extends JpaRepository<EventWorkhand, Long> {
    List<EventWorkhand> findByEvent(Integer eventId);

    @Query("SELECT ew FROM EventWorkhand ew JOIN FETCH ew.workhnadCategory WHERE ew.eventWorkhnadId = :id")
    Optional<EventWorkhand> findByIdWithCategory(@Param("id") Long id);
}
