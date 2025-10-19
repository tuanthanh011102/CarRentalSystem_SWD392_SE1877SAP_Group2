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
public class Owner {

    private Long ownerId;
    private Long userId;
    private String name;
    private String contact;
    private String address;
    private String cccdId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Owner() {
    }

    public Owner(Long ownerId, Long userId, String name, String contact, String address, String cccdId, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.ownerId = ownerId;
        this.userId = userId;
        this.name = name;
        this.contact = contact;
        this.address = address;
        this.cccdId = cccdId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Long ownerId) {
        this.ownerId = ownerId;
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

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
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
        return "Owner{"
                + "ownerId=" + ownerId
                + ", userId=" + userId
                + ", name='" + name + '\''
                + ", contact='" + contact + '\''
                + ", address='" + address + '\''
                + ", cccdId='" + cccdId + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
