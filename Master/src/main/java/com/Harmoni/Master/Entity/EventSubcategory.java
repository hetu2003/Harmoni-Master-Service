package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "event_subcategory")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class EventSubcategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "event_subcategory_id")
    private Long eventSubcategoryId;

    @Column(name = "event_subcategory_name", nullable = false, length = 255)
    private String eventSubcategoryName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "event_category_id")
    private EventCategory eventCategory;
}
