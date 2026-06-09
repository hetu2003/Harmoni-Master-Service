package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.EventCategory;
import com.Harmoni.Master.Entity.EventSubcategory;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface EventRepository extends JpaRepository<Events, Long> {

    Page<Events> findByCompanyOrderByStartDatetimeDesc(Users company, Pageable pageable);
    List<Events> findByCompanyOrderByStartDatetimeDesc(Users company);

    Page<Events> findByStartDatetimeAfterAndEventCategoryOrderByStartDatetime(
            LocalDateTime now, EventCategory eventCategory, Pageable pageable);

    Page<Events> findByStartDatetimeAfterOrderByStartDatetime(LocalDateTime now, Pageable pageable);

    @Query("SELECT e FROM Events e WHERE LOWER(e.eventName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(e.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Events> searchByKeyword(@Param("keyword") String keyword);

    @Query("SELECT e FROM Events e WHERE (LOWER(e.eventName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(e.description) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND e.startDatetime > :now")
    Page<Events> searchUpcoming(@Param("keyword") String keyword, @Param("now") LocalDateTime now, Pageable pageable);

    @Query("SELECT e FROM Events e WHERE (LOWER(e.eventName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(e.description) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND e.startDatetime > :now AND e.eventCategory = :cat")
    Page<Events> searchUpcomingByCategory(@Param("keyword") String keyword, @Param("now") LocalDateTime now,
                                           @Param("cat") EventCategory cat, Pageable pageable);

    List<Events> findByCompanyAndEventSubcategoryOrderByStartDatetime(
            Users company, EventSubcategory eventSubcategory);

    long countByFeaturedTrue();

    List<Events> findByFeaturedTrueOrderByStartDatetimeAsc();
}
