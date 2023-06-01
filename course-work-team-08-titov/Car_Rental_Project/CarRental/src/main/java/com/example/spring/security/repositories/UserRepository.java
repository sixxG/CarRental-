package com.example.spring.security.repositories;

import com.example.spring.security.models.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUsername(String username);
    User findById(int id);
    User findByEmail(String email);

    //reports
    @Query("SELECT COUNT(u.id) FROM User u JOIN u.roles r WHERE r.name = :roleName")
    Long countByRoleName(@Param("roleName") String roleName);
    @Query("SELECT u FROM User u LEFT JOIN u.roles r WHERE r.name = 'USER' AND u.birthDate = (SELECT MIN(u2.birthDate) FROM User u2 LEFT JOIN u2.roles r2 WHERE r2.name = 'USER')")
    Page findOldestUser(Pageable pageable);
    @Query("SELECT u FROM User u LEFT JOIN u.roles r WHERE r.name = 'USER' AND u.birthDate = (SELECT MAX(u2.birthDate) FROM User u2 LEFT JOIN u2.roles r2 WHERE r2.name = 'USER')")
    Page findYoungestUser(Pageable pageable);
    @Query("SELECT AVG(YEAR(CURRENT_DATE) - YEAR(u.birthDate)) FROM User u JOIN u.roles r WHERE r.name = 'USER'")
    Double getAverageAge();
}
