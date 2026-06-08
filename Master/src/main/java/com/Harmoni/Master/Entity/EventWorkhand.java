package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(name = "event_workhands")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class EventWorkhand {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "event_workhand_id")
    private Long eventWorkhnadId;

    @Column(name = "event_id")
    private Integer event;

    @Column(name = "workhand_category_id", nullable = false)
    private Integer workhnadCategoryId;

    @Column(name = "number_of_workhand", nullable = false)
    private Integer numberOfWorkhand = 11;

    @Column(name = "price", precision = 10, scale = 2, nullable = false)
    private BigDecimal price;

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

