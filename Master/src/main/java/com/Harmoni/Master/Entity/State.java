package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "states")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class State {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "state_name", nullable = false, length = 255)
    private String stateName;

    /** Alias so JSPs / repositories can reference stateId */
    public Long getStateId() {
        return this.id;
    }
}
