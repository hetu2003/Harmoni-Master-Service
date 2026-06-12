package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "user_workhand_category")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class UserWorkhnadCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "workhand_category_id", nullable = false)
    private Integer workhnadCategoryId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "workhand_category_id", insertable = false, updatable = false)
    private WorkhandCategory workhnadCategory;
}
