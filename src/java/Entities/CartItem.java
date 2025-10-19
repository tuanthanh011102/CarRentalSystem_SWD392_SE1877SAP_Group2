/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author tuanthanh
 */
public class CartItem {

    private Long cartItemId;
    private Long cartId;
    private Long carId;
    private LocalDate startDate;
    private LocalDate endDate;
    private BigDecimal priceSnapshot;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public CartItem() {
    }

    public CartItem(Long cartItemId, Long cartId, Long carId, LocalDate startDate, LocalDate endDate, BigDecimal priceSnapshot, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.carId = carId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.priceSnapshot = priceSnapshot;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(Long cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Long getCartId() {
        return cartId;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public Long getCarId() {
        return carId;
    }

    public void setCarId(Long carId) {
        this.carId = carId;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public BigDecimal getPriceSnapshot() {
        return priceSnapshot;
    }

    public void setPriceSnapshot(BigDecimal priceSnapshot) {
        this.priceSnapshot = priceSnapshot;
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
        return "CartItem{"
                + "cartItemId=" + cartItemId
                + ", cartId=" + cartId
                + ", carId=" + carId
                + ", startDate=" + startDate
                + ", endDate=" + endDate
                + ", priceSnapshot=" + priceSnapshot
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
