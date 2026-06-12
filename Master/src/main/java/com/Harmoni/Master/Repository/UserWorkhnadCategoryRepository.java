package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.UserWorkhnadCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserWorkhnadCategoryRepository extends JpaRepository<UserWorkhnadCategory, Long> {
    List<UserWorkhnadCategory> findByUserId(Long userId);
    void deleteByUserId(Long userId);
}
