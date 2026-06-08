package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "event_category")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class EventCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "event_category_id")
    private Long eventCategoryId;

    @Column(name = "event_category_name", nullable = false, length = 255)
    private String eventCategoryName;
}
