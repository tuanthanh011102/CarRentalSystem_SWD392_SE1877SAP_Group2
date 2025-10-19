/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.time.LocalDateTime;

/**
 *
 * @author tuanthanh
 */
public class Customer {

    private Long customerId;
    private Long userId;
    private String name;
    private String phone;
    private String address;
    private String cccdId;
    private String email;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Customer() {
    }

    public Customer(Long customerId, Long userId, String name, String phone, String address, String cccdId, String email, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.customerId = customerId;
        this.userId = userId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.cccdId = cccdId;
        this.email = email;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCccdId() {
        return cccdId;
    }

    public void setCccdId(String cccdId) {
        this.cccdId = cccdId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
        return "Customer{"
                + "customerId=" + customerId
                + ", userId=" + userId
                + ", name='" + name + '\''
                + ", phone='" + phone + '\''
                + ", address='" + address + '\''
                + ", cccdId='" + cccdId + '\''
                + ", email='" + email + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
