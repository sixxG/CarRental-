package com.example.spring.security.services;

import com.example.spring.security.models.Role;
import com.example.spring.security.models.User;
import com.example.spring.security.repositories.RoleRepository;
import com.example.spring.security.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;

    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public boolean addUser(User user, Map<String, String> rolesList) {

        Set<String> roles = roleRepository.findAll().stream()
                .map(role -> role.getName())
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key: rolesList.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(roleRepository.findByName(key));
            }
        }
        userRepository.save(user);

        if (userRepository.findByUsername(user.getUsername()) == null) {
            return false;
        }

        return true;
    }

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = findByUsername(username);

        if(user == null) {
            throw  new UsernameNotFoundException(String.format("User '%s' not found", username));
        }

        //Перегоняем исеров наших в юхеров для Spring Security
        return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(),
                mapRolesToAuthorities(user.getRoles()));
    }

    private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Collection<Role> roles) {
        return roles.stream().map(r -> new SimpleGrantedAuthority(r.getName())).collect(Collectors.toList());
    }
}
