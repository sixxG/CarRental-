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
    @NotBlank(message = "WIN номер авто обязателен!")
    @Size(min = 17, max = 17, message = "Размер WIN номера должен составлять 17 символов!")
    private String WIN_Number;
    @NotBlank(message = "Укажите бренд автомобиля!")
    @Size(min = 1, max = 20, message = "Название производителя авто не может превышать 20 символов!")
    private String brand;
    private String model;
    @NotBlank(message = "Укажите кузов автомобиля!")
    @Size(min = 3, max = 15, message = "Кузов авто не может превышать 15 символов!")
    private String body;
    @NotEmpty(message = "Укажите класс автомобиля!")
    @Size(min = 5, max = 20, message = "Класс авто не может превышать 20 символов!")
    private String level;

    @Min(value = 1800, message = "Год выпуска должен быть больше 1800")
    @Max(value = 2030, message = "Год выпуска авто не должен превышать 2030")
    private int year;
    @Min(value = 1000, message = "Пробег автомобиля должен быть больше 1000км")
    @Max(value = 1000000, message = "Пробег автомобиля не может превышать 1млн км")
    private int mileage;
    @NotBlank(message = "Укажите цвет автомобиля!")
    @Size(min = 3, max = 15, message = "Цвет авто должен быть в пределах 3-15 символов!")
    private String color;
    @NotBlank(message = "Укажите тип КП автомобиля!")
    @Size(min = 3, max = 15, message = "Тип КП не может превышать 15 символов!")
    private String transmission;
    @NotBlank(message = "Укажите привод автомобиля!")
    @Size(min = 3, max = 15, message = "Привод не может превышать 15 символов!")
    private String drive;

    @Min(value = 30, message = "Мощность автомобиля должна быть больше 30лс!")
    @Max(value = 2500, message = "Мощность автомобиля не может превышать 2500лс!")
    private int power;

    @Min(value = 498, message = "Цена аренды авто за 1 день не должна быть меньше 498 руб!")
    @Max(value = 200000, message = "Цена аренды авто за 1 день не должна превышать 250тыс. руб.!")
    private int price;
    @NotBlank(message = "Укажите статус автомобиля!")
    @Size(min = 3, max = 15, message = "Статус не может превышать 15 символов!")
    private String status;

    private String image;

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

    public Car(int id, String WIN_Number, String brand, String model, String body, String level, int year, int mileage, String color, String transmission, String drive, int power, int price, String status, String image, String description) {
        this.id = id;
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
