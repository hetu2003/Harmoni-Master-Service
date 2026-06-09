package com.Harmoni.Master.Repository;

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

    Page<Events> findByStartDatetimeAfterAndEventCategoryOrderByStartDatetime(LocalDateTime now, Integer eventCategory, Pageable pageable);

    Page<Events> findByStartDatetimeAfterOrderByStartDatetime(LocalDateTime now, Pageable pageable);

    @Query("SELECT e FROM Events e WHERE LOWER(e.eventName) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Events> searchByKeyword(@Param("keyword") String keyword);
    
    List<Events> findByCompanyAndEventSubcategoryOrderByStartDatetime(Users company, Integer subcategoryId);
}
