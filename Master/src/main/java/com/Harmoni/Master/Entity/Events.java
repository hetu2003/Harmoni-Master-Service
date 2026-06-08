package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Entity
@Table(name = "events")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Events {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "event_name", nullable = false, length = 255)
    private String eventName;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "start_datetime", nullable = false)
    private LocalDateTime startDatetime;

    @Column(name = "end_datetime", nullable = false)
    private LocalDateTime endDatetime;

    @Column(name = "total_workhand")
    private Integer totalWorkhand;

    @Column(name = "total_price")
    private Integer totalPrice;

    @Column(name = "street_address", length = 250)
    private String streetAddress;

    @Column(name = "city_id")
    private Integer city;


    @Column(name = "state_id")
    private Integer state;

    @Column(name = "event_category_id")
    private Integer eventCategory;

    @Column(name = "event_subcategory_id")
    private Integer eventSubcategory;

    @Column(name = "company_id")
    private Integer company;

    @Column(name = "is_active")
    Integer isActive;

    @Column(name = "createdat")
    Timestamp createdAt;

    @Column(name = "createdby")
    Integer createdBy;

    @Column(name = "modifiedby")
    Integer modifiedBy;

    @Column(name = "modifiedon")
    Timestamp modifiedOn;
}