package com.example.spring.security.models;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "cars")
public class Car {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String WIN_Number;
    private String brand;
    private String model;
    private String body;
    private String level;
    private int year;
    private int mileage;
    private String color;
    private String transmission;
    private String drive;
    private int power;
    private double price;
    private String status;
    private String image;
    private String description;

    public Car() {
    }
    public Car(String WIN_Number, String brand, String model, String body, String level, int year, int mileage, String color, String transmission, String drive, int power, double price, String status, String image, String description) {
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWIN_Number() {
        return WIN_Number;
    }

    public void setWIN_Number(String WIN_Number) {
        this.WIN_Number = WIN_Number;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMileage() {
        return mileage;
    }

    public void setMileage(int mileage) {
        this.mileage = mileage;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getTransmission() {
        return transmission;
    }

    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }

    public String getDrive() {
        return drive;
    }

    public void setDrive(String drive) {
        this.drive = drive;
    }

    public int getPower() {
        return power;
    }

    public void setPower(int power) {
        this.power = power;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatusn(String status) {
        this.status = status;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
