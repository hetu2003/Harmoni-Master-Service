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

    /* ── Raw FK columns (used for inserts / updates) ── */

    @Column(name = "city_id")
    private Integer cityId;

    @Column(name = "state_id")
    private Integer stateId;

    @Column(name = "event_category_id")
    private Integer eventCategoryId;

    @Column(name = "event_subcategory_id")
    private Integer eventSubcategoryId;

    @Column(name = "company_id")
    private Integer companyId;

    /* ── Read-only JPA associations for JSP / EL navigation ── */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "city_id", insertable = false, updatable = false)
    private City city;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "state_id", insertable = false, updatable = false)
    private State state;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "event_category_id", insertable = false, updatable = false)
    private EventCategory eventCategory;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "event_subcategory_id", insertable = false, updatable = false)
    private EventSubcategory eventSubcategory;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "company_id", insertable = false, updatable = false)
    private Users company;

    @Column(name = "image_path")
    private String imagePath;

    @Builder.Default
    @Column(name = "is_featured")
    private Boolean featured = false;

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

    /** Alias so JSPs can reference ${ev.eventId} */
    public Long getEventId() {
        return this.id;
    }
}
