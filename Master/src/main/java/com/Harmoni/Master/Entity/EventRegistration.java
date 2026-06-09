package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;
import java.time.LocalDate;

@Entity
@Table(name = "event_registrations")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EventRegistration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "registration_id")
    private Long registrationId;

    @Column(name = "registration_date", nullable = false)
    private LocalDate registrationDate;

    @Column(name = "event_id")
    private Integer event;

    @Column(name = "company_id")
    private Integer company;

    @Column(name = "workhand_id")
    private Integer workhand;
    @Column(name = "event_workhand_id")
    private Integer eventWorkhand;

    @Column(name = "registration_status", nullable = false)
    private boolean registrationStatus = false;

    @Column(name = "payment_status", nullable = false)
    private boolean paymentStatus = false;

    @Column(name = "payment_date")
    private LocalDate paymentDate;

    @Column(name = "rating")
    private Integer rating;

    @Column(name = "is_active")
    private Integer isActive;

    @Column(name = "createdat")
    private Timestamp createdAt;

    @Column(name = "createdby")
    private Integer createdBy;

    @Column(name = "modifiedby")
    private Integer modifiedBy;

    @Column(name = "modifiedon")
    private Timestamp modifiedOn;
}
