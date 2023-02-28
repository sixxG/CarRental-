package com.example.spring.security.repositories;

import com.example.spring.security.models.Car;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CarRepository extends JpaRepository<Car, Integer> {
    Car findById(int id);
}
