package com.example.spring.security.repositories;

import com.example.spring.security.models.Car;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface CarRepository extends JpaRepository<Car, Integer> {
    Car findById(int id);
    List<Car> findAllByStatus(String status);
    Page<Car> findByLevel(String level, Pageable pageable);
    int countByStatus(String status);
    //reports
    @Query("SELECT c FROM Car c LEFT JOIN Contract con ON con.car.id = c.id WHERE con.id IS NULL")
    List<Object[]> findNotRentalCars();
    @Query("SELECT c.level, COUNT(c) FROM Car c GROUP BY c.level")
    List<Object[]> countByCarLevel();
    @Query("SELECT c.transmission, COUNT(c) FROM Car c GROUP BY c.transmission")
    List<Object[]> countByCarTransmission();
    @Query("SELECT c.drive, COUNT(c) FROM Car c GROUP BY c.drive")
    List<Object[]> countByCarDrive();
    @Query("SELECT c.body, COUNT(c) FROM Car c GROUP BY c.body")
    List<Object[]> countByCarBody();
    @Query("SELECT c.brand FROM Car c GROUP BY c.brand")
    Set<String> getCarsBrand();
    @Query("SELECT AVG(c.price) FROM Car c")
    Double getAveragePrice();
    @Query("SELECT AVG(c.year) FROM Car c")
    int getAverageYear();
    @Query("SELECT AVG(c.mileage) FROM Car c")
    int getAverageMileage();
    Car findFirstByOrderByYearAsc();
    Car findFirstByOrderByYearDesc();
    Car findFirstByOrderByPriceAsc();
    Car findFirstByOrderByPriceDesc();
    Car findFirstByOrderByMileageAsc();
    Car findFirstByOrderByMileageDesc();
}
