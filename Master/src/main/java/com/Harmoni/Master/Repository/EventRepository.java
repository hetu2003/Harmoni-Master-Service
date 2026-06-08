package com.Harmoni.Master.Repository;

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

    Page<Events> findByStartDatetimeAfterOrderByStartDatetime(LocalDateTime now, Pageable pageable);

    List<Events> findByStartDatetimeAfterOrderByStartDatetime(LocalDateTime now);


    List<Events> findByCompanyOrderByStartDatetimeDesc(Users company);

    Page<Events> findByCompanyOrderByStartDatetimeDesc(Users company, Pageable pageable);


    List<Events> findByCompanyAndEventsSubcategoryOrderByStartDatetime(Users company, EventSubcategory sub);


    @Query("SELECT e FROM Events e WHERE e.startDatetime > :now AND e.eventSubcategory = :sub")
    List<Events> findUpcomingBySubcategory(@Param("now") LocalDateTime now, @Param("sub") EventSubcategory sub);


    @Query("SELECT e FROM Events e WHERE " +
            "LOWER(e.eventName) LIKE LOWER(CONCAT('%',:kw,'%')) OR " +
            "LOWER(e.company.name) LIKE LOWER(CONCAT('%',:kw,'%')) OR " +
            "LOWER(e.city.cityName) LIKE LOWER(CONCAT('%',:kw,'%')) OR " +
            "LOWER(e.state.stateName) LIKE LOWER(CONCAT('%',:kw,'%'))")
    List<Events> searchByKeyword(@Param("kw") String keyword);


    List<Events> findTop6ByStartDatetimeAfterOrderByStartDatetime(LocalDateTime now);
}
