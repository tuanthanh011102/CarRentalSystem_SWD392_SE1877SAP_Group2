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
public class BookingItem {

    private Long bookingItemId;
    private Long bookingId;
    private Long carId;
    private LocalDate startDate;
    private LocalDate endDate;
    private BigDecimal price;
    private String status; // active, completed, cancelled
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public BookingItem() {
    }

    public BookingItem(Long bookingItemId, Long bookingId, Long carId, LocalDate startDate, LocalDate endDate, BigDecimal price, String status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.bookingItemId = bookingItemId;
        this.bookingId = bookingId;
        this.carId = carId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.price = price;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getBookingItemId() {
        return bookingItemId;
    }

    public void setBookingItemId(Long bookingItemId) {
        this.bookingItemId = bookingItemId;
    }

    public Long getBookingId() {
        return bookingId;
    }

    public void setBookingId(Long bookingId) {
        this.bookingId = bookingId;
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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
        return "BookingItem{"
                + "bookingItemId=" + bookingItemId
                + ", bookingId=" + bookingId
                + ", carId=" + carId
                + ", startDate=" + startDate
                + ", endDate=" + endDate
                + ", price=" + price
                + ", status='" + status + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
