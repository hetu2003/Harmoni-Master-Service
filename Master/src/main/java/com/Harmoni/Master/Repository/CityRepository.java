package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.City;
import com.Harmoni.Master.Entity.State;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CityRepository extends JpaRepository<City, Long> {
    /** Find cities by State entity (uses the @ManyToOne State association). */
    List<City> findByState(State state);

    /** Find cities by state PK — used by AJAX city loader. */
    List<City> findByStateId(Long stateId);
}
