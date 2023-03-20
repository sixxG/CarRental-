package com.example.spring.security.repositories;

import com.example.spring.security.models.Contract;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContractRepository extends JpaRepository<Contract, Integer> {
    Contract findById(int id);
}
