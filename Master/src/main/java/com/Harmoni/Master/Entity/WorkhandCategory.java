package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "workhand_category")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class WorkhandCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "workhand_category_id")
    private Integer workhnadCategoryId;

    @Column(name = "workhand_category_name", nullable = false)
    private String workhnadCategoryName;

    @Column(name = "is_active")
    private Integer isActive;
}
