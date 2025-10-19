/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author tuanthanh
 */
public class Car {

    private Long carId;
    private Long ownerId;
    private String name;
    private String model;
    private String color;
    private String registrationNo;
    private BigDecimal pricePer;
    private String status; // available, rented, maintenance
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Car() {
    }

    public Car(Long carId, Long ownerId, String name, String model, String color, String registrationNo, BigDecimal pricePer, String status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.carId = carId;
        this.ownerId = ownerId;
        this.name = name;
        this.model = model;
        this.color = color;
        this.registrationNo = registrationNo;
        this.pricePer = pricePer;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getCarId() {
        return carId;
    }

    public void setCarId(Long carId) {
        this.carId = carId;
    }

    public Long getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Long ownerId) {
        this.ownerId = ownerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getRegistrationNo() {
        return registrationNo;
    }

    public void setRegistrationNo(String registrationNo) {
        this.registrationNo = registrationNo;
    }

    public BigDecimal getPricePer() {
        return pricePer;
    }

    public void setPricePer(BigDecimal pricePer) {
        this.pricePer = pricePer;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Car{"
                + "carId=" + carId
                + ", ownerId=" + ownerId
                + ", name='" + name + '\''
                + ", model='" + model + '\''
                + ", color='" + color + '\''
                + ", registrationNo='" + registrationNo + '\''
                + ", pricePer=" + pricePer
                + ", status='" + status + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
