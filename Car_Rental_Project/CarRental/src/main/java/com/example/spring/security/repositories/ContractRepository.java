package com.example.spring.security.repositories;

import com.example.spring.security.models.Car;
import com.example.spring.security.models.Contract;
import com.example.spring.security.models.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;

public interface ContractRepository extends JpaRepository<Contract, Integer> {
    Contract findById(int id);
    Long countByUser(User user);
    Page<Contract> findByUser(User user, Pageable pageable);
    Contract findByUserAndStatusIn(User user, List<String> conditions);
    @Modifying
    @Transactional
    @Query("UPDATE Contract c SET c.user = :deletedUser WHERE c.user = :client")
    void setUserIfUserWasDeleted(User deletedUser, User client);
    //reports
    @Query("SELECT c.car, COUNT(c.car) as rentalCount FROM Contract c GROUP BY c.car ORDER BY rentalCount DESC")
    List<Object[]> findMostRentedCarWithCount();
    @Query("SELECT COUNT(c) FROM Contract c WHERE c.car.power BETWEEN :minPower AND :maxPower")
    Long countRentsByPower(@Param("minPower") int minPower, @Param("maxPower") int maxPower);
    Contract findByCarAndStatusNotAndStatusNot(Car car, String status1, String status2);
    long countByStatus(String status);
    @Query("SELECT c.status, COUNT(c) FROM Contract c GROUP BY c.status")
    List<Object[]> countByStatusWithStatus();
    @Query("SELECT c.typeReceipt, COUNT(c) FROM Contract c GROUP BY c.typeReceipt")
    List<Object[]> countByTypeReceipt();
    @Query("SELECT c.typeReturn, COUNT(c) FROM Contract c GROUP BY c.typeReturn")
    List<Object[]> countByTypeReturn();
    @Query("SELECT c.fioManager, COUNT(c.id), SUM(c.price) FROM Contract c WHERE c.fioManager IS NOT NULL AND c.dateStart >= :startDate AND c.dateEnd <= :endDate GROUP BY c.fioManager ORDER BY COUNT(c.id) DESC")
    List<Object[]> findManagerRentCountsAndTotalPriceByDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);
    @Query("SELECT MAX(c.price) FROM Contract c")
    double findMaxPrice();
    @Query("SELECT MIN(c.price) FROM Contract c")
    double findMinPrice();
    @Query("SELECT AVG(c.price) FROM Contract c")
    double getAveragePrice();
    Contract findByPrice(double price);
    List<Contract> findByDateStartBetweenAndDateEndBetween(LocalDateTime start1, LocalDateTime end1, LocalDateTime start2, LocalDateTime end2);
    List<Contract> findByCar(Car car);
    List<Contract> findByUser(User user);
    Page<Contract> findByStatus(String status, Pageable pageable);
    @Query("SELECT c.additionalOptions FROM Contract c")
    List<String> countByAdditionalOptions();
    @Query("SELECT COUNT(c.id) FROM Contract c JOIN c.user u WHERE c.note LIKE 'Штраф%' AND TIMESTAMPDIFF(YEAR, u.birthDate, CURRENT_DATE) BETWEEN :minAge AND :maxAge")
    int countRentWithPenaltyAndUserAgeInRange(@Param("minAge") int minAge, @Param("maxAge") int maxAge);
    @Query("SELECT COUNT(c) FROM Contract c WHERE c.note LIKE %:word%")
    int countByNoteContaining(@Param("word") String word);
}
