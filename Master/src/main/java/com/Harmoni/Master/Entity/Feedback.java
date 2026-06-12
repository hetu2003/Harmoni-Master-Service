package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;
import java.time.LocalDate;

@Entity
@Table(name = "feedbacks")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Feedback {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "feedback_id")
    private Long feedbackId;

    @Column(name = "feedback", nullable = false, columnDefinition = "TEXT")
    private String feedback;

    @Column(name = "feedback_date", nullable = false)
    private LocalDate feedbackDate;

    /* Raw FK for writes */
    @Column(name = "event_id")
    private Integer event;

    @Column(name = "workhand_id")
    private Integer workhnadId;

    @Column(name = "company_id")
    private Integer company;

    /* Read-only navigation for JSP: ${fb.workhand.name} */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "workhand_id", insertable = false, updatable = false)
    private Users workhand;

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

    @PrePersist
    protected void onCreate() {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        if (createdAt == null) createdAt = now;
        if (modifiedOn == null) modifiedOn = now;
    }

    @PreUpdate
    protected void onUpdate() {
        modifiedOn = new Timestamp(System.currentTimeMillis());
    }
}
