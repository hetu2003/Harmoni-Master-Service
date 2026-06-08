package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.City;
import com.Harmoni.Master.Entity.State;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CityRepository extends JpaRepository<City, Long> {
    List<City> findByState(State state);
    List<City> findByStateStateId(Long stateId);
}
