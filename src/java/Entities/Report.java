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
public class Report {

    private Long reportId;
    private Long userId;
    private String reportType; // revenue, user_activity, booking, dispute
    private LocalDate startDate;
    private LocalDate endDate;
    private LocalDateTime generatedAt;
    private String summary;

    public Report() {
    }

    public Report(Long reportId, Long userId, String reportType, LocalDate startDate, LocalDate endDate, LocalDateTime generatedAt, String summary) {
        this.reportId = reportId;
        this.userId = userId;
        this.reportType = reportType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.generatedAt = generatedAt;
        this.summary = summary;
    }

    public Long getReportId() {
        return reportId;
    }

    public void setReportId(Long reportId) {
        this.reportId = reportId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
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

    public LocalDateTime getGeneratedAt() {
        return generatedAt;
    }

    public void setGeneratedAt(LocalDateTime generatedAt) {
        this.generatedAt = generatedAt;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    @Override
    public String toString() {
        return "Report{"
                + "reportId=" + reportId
                + ", userId=" + userId
                + ", reportType='" + reportType + '\''
                + ", startDate=" + startDate
                + ", endDate=" + endDate
                + ", generatedAt=" + generatedAt
                + ", summary='" + summary + '\''
                + '}';
    }
}
