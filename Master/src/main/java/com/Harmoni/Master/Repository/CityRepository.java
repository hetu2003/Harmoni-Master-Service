package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.City;
import com.Harmoni.Master.Entity.State;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface CityRepository extends JpaRepository<City, Long> {
    List<City> findByState(State state);

    @Query(value = "SELECT id, city_name, state_id FROM cities WHERE state_id = :stateId ORDER BY city_name ASC", nativeQuery = true)
    List<Object[]> findCitiesByStateId(@Param("stateId") Integer stateId);
}
