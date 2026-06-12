package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.WorkhandCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WorkhandCategoryRepository extends JpaRepository<WorkhandCategory, Integer> {
    List<WorkhandCategory> findByIsActive(Integer isActive);
}
