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
public class Payment {

    private Long paymentId;
    private Long bookingId;
    private BigDecimal amount;
    private String paymentMethod;
    private String status; // pending, completed, failed, refunded
    private String gatewayTxnId;
    private LocalDateTime paidAt;
    private BigDecimal refundedAmount;
    private String refundStatus; // none, partial, full
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Payment() {
    }

    public Payment(Long paymentId, Long bookingId, BigDecimal amount, String paymentMethod, String status, String gatewayTxnId, LocalDateTime paidAt, BigDecimal refundedAmount, String refundStatus, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.paymentId = paymentId;
        this.bookingId = bookingId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.gatewayTxnId = gatewayTxnId;
        this.paidAt = paidAt;
        this.refundedAmount = refundedAmount;
        this.refundStatus = refundStatus;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Long paymentId) {
        this.paymentId = paymentId;
    }

    public Long getBookingId() {
        return bookingId;
    }

    public void setBookingId(Long bookingId) {
        this.bookingId = bookingId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getGatewayTxnId() {
        return gatewayTxnId;
    }

    public void setGatewayTxnId(String gatewayTxnId) {
        this.gatewayTxnId = gatewayTxnId;
    }

    public LocalDateTime getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(LocalDateTime paidAt) {
        this.paidAt = paidAt;
    }

    public BigDecimal getRefundedAmount() {
        return refundedAmount;
    }

    public void setRefundedAmount(BigDecimal refundedAmount) {
        this.refundedAmount = refundedAmount;
    }

    public String getRefundStatus() {
        return refundStatus;
    }

    public void setRefundStatus(String refundStatus) {
        this.refundStatus = refundStatus;
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
        return "Payment{" + 
                "paymentId=" + paymentId + 
                ", bookingId=" + bookingId + 
                ", amount=" + amount + 
                ", paymentMethod=" + paymentMethod + 
                ", status=" + status + 
                ", gatewayTxnId=" + gatewayTxnId + 
                ", paidAt=" + paidAt + 
                ", refundedAmount=" + refundedAmount + 
                ", refundStatus=" + refundStatus + 
                ", createdAt=" + createdAt + 
                ", updatedAt=" + updatedAt + 
                '}';
    }

}
