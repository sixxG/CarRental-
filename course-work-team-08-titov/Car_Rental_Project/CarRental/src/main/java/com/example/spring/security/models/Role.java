package com.example.spring.security.models;

import lombok.Data;

import javax.persistence.*;

@Entity
//Для генерации геттеров и сеттеров
@Data
@Table(name = "roles")
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
}
