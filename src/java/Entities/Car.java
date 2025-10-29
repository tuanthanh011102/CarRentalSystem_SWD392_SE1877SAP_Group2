/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.math.BigDecimal;
import java.sql.Timestamp;
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
    private String location;
    private String thumbnail;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private float rating;
    private int totalReview;

    public Car() {
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public int getTotalReview() {
        return totalReview;
    }

    public void setTotalReview(int totalReview) {
        this.totalReview = totalReview;
    }

    public Car(Long carId, Long ownerId, String name, String model, String color, String registrationNo, BigDecimal pricePer, String status, Timestamp createdAt, Timestamp updatedAt) {
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    @Override
    public String toString() {
        return "Car{" + "carId=" + carId + ", ownerId=" + ownerId + ", name=" + name + ", model=" + model + ", color=" + color + ", registrationNo=" + registrationNo + ", pricePer=" + pricePer + ", status=" + status + ", location=" + location + ", thumbnail=" + thumbnail + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
}
