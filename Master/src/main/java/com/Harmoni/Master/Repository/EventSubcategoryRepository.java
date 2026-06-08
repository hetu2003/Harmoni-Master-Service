package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.EventCategory;
import com.Harmoni.Master.Entity.EventSubcategory;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface EventSubcategoryRepository extends JpaRepository<EventSubcategory, Long> {
    List<EventSubcategory> findByEventCategory(EventCategory eventCategory);
    List<EventSubcategory> findByEventCategoryEventCategoryId(Long categoryId);
}
