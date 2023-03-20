package com.example.spring.security.models;

import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "contracts")
public class Contract {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String fioManager;

    private String additionalOptions;

    private LocalDateTime dateStart;

    private String typeReceipt;

    private LocalDateTime dateEnd;

    private String typeReturn;

    private double price;

    private String status;

    private String note;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "car_id")
    private Car car;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client_id")
    private User user;

    public Contract() {
    }

    public Contract(String fioManager, String additionalOptions, LocalDateTime dateStart, String typeReceipt,
                    LocalDateTime dateEnd, String typeReturn, double price, String status, String note, Car car, User user) {
        this.fioManager = fioManager;
        this.additionalOptions = additionalOptions;
        this.dateStart = dateStart;
        this.typeReceipt = typeReceipt;
        this.dateEnd = dateEnd;
        this.typeReturn = typeReturn;
        this.price = price;
        this.status = status;
        this.note = note;
        this.car = car;
        this.user = user;
    }
}
