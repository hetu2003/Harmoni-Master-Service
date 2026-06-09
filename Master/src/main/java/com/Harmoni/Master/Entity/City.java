package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "cities")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class City {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "city_name", nullable = false, length = 255)
    private String cityName;

    /* Raw FK — keep for inserts */
    @Column(name = "state")
    private Integer stateRawId;

    /* Read-only JPA association */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "state", insertable = false, updatable = false)
    private State state;

    /** Alias so JSPs / repositories can reference cityId */
    public Long getCityId() {
        return this.id;
    }
}
