package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.EventWorkhand;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EventWorkhnadRepository extends JpaRepository<EventWorkhand, Long> {
    List<EventWorkhand> findByEvent(Integer eventId);
}
