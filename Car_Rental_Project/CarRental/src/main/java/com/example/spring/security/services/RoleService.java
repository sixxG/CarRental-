package com.example.spring.security.services;

import com.example.spring.security.models.Role;
import com.example.spring.security.repositories.RoleRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService {
    private final RoleRepository roleRepository;

    public RoleService(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    public List<Role> findAll() {
        return roleRepository.findAll();
    }
    public Role findByName(String name) {
        return roleRepository.findByName(name);
    }
}
