/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Entities.Booking;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;

/**
 *
 * @author tuanthanh
 */
public class BookingDAO extends DAO {

    public static void main(String[] args) {
        BookingDAO bDao = new BookingDAO();
        try {
//            Booking test = new Booking();
//            test.setCustomerId((long) 2);
//            test.setStartDate(LocalDate.now());
//            test.setReturnDate(LocalDate.now());
//            System.out.println(bDao.createBooking(test));
//            System.out.println(bDao.updateBookingStatus((long) 4, "confirmed"));
            LocalDate start = LocalDate.of(2025, Month.OCTOBER, 29);
            LocalDate end = LocalDate.of(2025, Month.OCTOBER, 31);

            System.out.println(bDao.isCarBookedForDates(1, start, end));
        } catch (Exception e) {
            System.err.println(e);
        }
    }

    public boolean isCarBookedForDates(long carId, LocalDate startDate, LocalDate endDate)
            throws SQLException, Exception {
        String sql = """
        SELECT COUNT(*) 
        FROM booking 
        WHERE car_id = ? 
        AND booking_status NOT IN ('cancelled', 'rejected')
        AND (
            (start_date <= ? AND return_date >= ?) OR
            (start_date <= ? AND return_date >= ?) OR
            (start_date >= ? AND return_date <= ?)
        )
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareCall(sql);

            ps.setLong(1, carId);
            ps.setDate(2, Date.valueOf(endDate));
            ps.setDate(3, Date.valueOf(endDate));
            ps.setDate(4, Date.valueOf(startDate));
            ps.setDate(5, Date.valueOf(startDate));
            ps.setDate(6, Date.valueOf(startDate));
            ps.setDate(7, Date.valueOf(endDate));

            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            throw new Exception("Something wrong during isCarBookedForDates(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in isCarBookedForDates(): " + e.getMessage());
            }
        }
        return false;
    }

    public Booking getBookingById(long id) throws Exception {
        Booking b = null;
        String sql = """
                     SELECT * FROM booking WHERE booking_id = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setLong(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                b = new Booking();

                b.setBookingId(id);
                b.setCustomerId(rs.getLong("customer_id"));
                b.setStartDate(rs.getDate("start_date").toLocalDate());
                b.setReturnDate(rs.getDate("return_date").toLocalDate());
                b.setCarId(rs.getLong("car_id"));
                b.setPrice(rs.getDouble("price"));
                b.setBookingStatus(rs.getString("booking_status"));
                b.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                b.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
            } else {
                throw new Exception("Booking not found");
            }

        } catch (Exception e) {
            throw new Exception("Something wrong during getBookingById(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in getBookingById(): " + e.getMessage());
            }
        }

        return b;
    }

    public long createBooking(Booking b) throws Exception {
        String sql = """
                 INSERT INTO `booking`
                 (`customer_id`,
                 `car_id`,
                 `price`,
                 `start_date`,
                 `return_date`)
                 VALUES
                 (?,
                 ?,
                 ?,
                 ?,
                 ?);
                 """;
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setLong(1, b.getCustomerId());
            ps.setLong(2, b.getCarId());
            ps.setDouble(3, b.getPrice());
            ps.setDate(4, Date.valueOf(b.getStartDate()));
            ps.setDate(5, Date.valueOf(b.getReturnDate()));

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                throw new Exception("Creating booking failed, no rows affected.");
            }

            rs = ps.getGeneratedKeys();

            if (rs.next()) {
                return rs.getLong(1);
            } else {
                throw new Exception("Creating booking failed, no ID obtained.");
            }
        } catch (SQLException e) {
            throw new Exception("Something wrong during createBooking(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in createBooking(): " + e.getMessage());
            }
        }
    }

    public boolean updateBookingStatus(long id, String status) throws Exception {
        String sql = """
                     UPDATE `crs`.`booking`
                     SET
                     `booking_status` = ?,
                     `updated_at` = ?
                     WHERE `booking_id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setLong(3, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new Exception("Something wrong during updateBookingStatus(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in updateBookingStatus(): " + e.getMessage());
            }
        }
    }
}
