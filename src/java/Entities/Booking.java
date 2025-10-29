/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author tuanthanh
 */
public class Booking {

    private Long bookingId;
    private Long customerId;
    private Long carId;
    private double price;
    private LocalDate startDate;
    private LocalDate returnDate;
    private String bookingStatus; // pending, confirmed, completed, cancelled
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Booking() {
    }

    public Booking(Long bookingId, Long customerId, LocalDate startDate, LocalDate returnDate, String bookingStatus, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.startDate = startDate;
        this.returnDate = returnDate;
        this.bookingStatus = bookingStatus;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getBookingId() {
        return bookingId;
    }

    public void setBookingId(Long bookingId) {
        this.bookingId = bookingId;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
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

    public Long getCarId() {
        return carId;
    }

    public void setCarId(Long carId) {
        this.carId = carId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    @Override
    public String toString() {
        return "Booking{"
                + "bookingId=" + bookingId
                + ", customerId=" + customerId
                + ", startDate=" + startDate
                + ", returnDate=" + returnDate
                + ", bookingStatus='" + bookingStatus + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
