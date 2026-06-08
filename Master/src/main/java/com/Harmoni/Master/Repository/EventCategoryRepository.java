package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.EventCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventCategoryRepository extends JpaRepository<EventCategory, Long> {
}
