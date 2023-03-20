package com.example.spring.security.models;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.*;

@Entity
@Data
@Table(name = "cars")
public class Car {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @NotEmpty(message = "WIN не должен быть пустым!")
    @Size(min = 17, max = 17, message = "Размер WIN номера должен составлять 17 символов!")
    private String WIN_Number;
    @NotEmpty(message = "Укажите бренд автомобиля!")
    @Size(min = 1, max = 20, message = "Название производителя авто не может превышать 20 символов!")
    private String brand;
    private String model;
    @NotEmpty(message = "Укажите кузов автомобиля!")
    @Size(min = 3, max = 15, message = "Кузов авто не может превышать 15 символов!")
    private String body;
    @NotEmpty(message = "Укажите класс автомобиля!")
    @Size(min = 5, max = 20, message = "Класс авто не может превышать 20 символов!")
    private String level;
    @NotEmpty(message = "Укажите год выпуска автомобиля!")
    @Future(message = "Год авто не может быть в будущем!")
    private int year;
    @NotEmpty(message = "Укажите пробег автомобиля!")
    private int mileage;
    @NotEmpty(message = "Укажите пробег автомобиля!")
    @Size(min = 3, max = 15, message = "Цвет авто не может превышать 15 символов!")
    private String color;
    @NotEmpty(message = "Укажите тип КП автомобиля!")
    @Size(min = 3, max = 15, message = "Тип КП не может превышать 15 символов!")
    private String transmission;
    @NotEmpty(message = "Укажите привод автомобиля!")
    @Size(min = 3, max = 15, message = "Привод не может превышать 15 символов!")
    private String drive;
    @NotEmpty(message = "Укажите мощность автомобиля!")
    @Min(value = 30)
    @Max(value = 5000)
    private int power;
    @NotEmpty(message = "Укажите цену проката за день для автомобиля!")
    @Min(value = 500)
    @Max(value = 200000)
    private int price;
    @NotEmpty(message = "Укажите статус автомобиля!")
    @Size(min = 3, max = 15, message = "Статус не может превышать 15 символов!")
    private String status;
    @NotEmpty(message = "Укажите статус автомобиля!")
    private String image;
    @NotEmpty(message = "Укажите описание автомобиля!")
    @Size(min = 3, max = 10000, message = "Описание не может превышать 10000 символов!")
    private String description;

    public Car() {
    }
    public Car(String WIN_Number, String brand, String model, String body, String level, int year, int mileage, String color, String transmission, String drive, int power, int price, String status, String image, String description) {
        this.WIN_Number = WIN_Number;
        this.brand = brand;
        this.model = model;
        this.body = body;
        this.level = level;
        this.year = year;
        this.mileage = mileage;
        this.color = color;
        this.transmission = transmission;
        this.drive = drive;
        this.power = power;
        this.price = price;
        this.status = status;
        this.image = image;
        this.description = description;
    }
}
