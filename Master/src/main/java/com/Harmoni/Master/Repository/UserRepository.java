package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.Role;
import com.Harmoni.Master.Entity.Users;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
import java.util.Optional;

/**
 * Unified repository for the users table.
 * Covers both WORKHAND and COMPANY accounts.
 */
public interface UserRepository extends JpaRepository<Users, Long> {

    Optional<Users> findByUsername(String username);

    @Query("SELECT u FROM Users u JOIN FETCH u.role WHERE u.username = :username")
    Optional<Users> findByUsernameWithRole(@Param("username") String username);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    List<Users> findByRole(Role role);

    Optional<Users> findByUserId(Long userId);

    List<Users> findByRoleRoleName(String roleName);
    Page<Users> findByRoleRoleName(String roleName, Pageable pageable);
    long countByRoleRoleName(String roleName);

    List<Users> findByRoleRoleNameAndNameContainingIgnoreCase(String roleName, String keyword);

    Page<Users> findByNameContainingIgnoreCase(String keyword, Pageable pageable);
    Page<Users> findByRoleRoleNameAndNameContainingIgnoreCase(String roleName, String keyword, Pageable pageable);

    Page<Users> findAllByOrderByCreatedAtDesc(Pageable pageable);
}
