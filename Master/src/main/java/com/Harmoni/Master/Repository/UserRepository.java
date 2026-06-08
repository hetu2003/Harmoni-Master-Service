package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.Role;
import com.Harmoni.Master.Entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

/**
 * Unified repository for the users table.
 * Covers both WORKHAND and COMPANY accounts.
 */
public interface UserRepository extends JpaRepository<Users, Long> {

    Optional<Users> findByUsername(String username);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    List<Users> findByRole(Role role);

    Optional<Users> findByUserId(Long userId);
}
