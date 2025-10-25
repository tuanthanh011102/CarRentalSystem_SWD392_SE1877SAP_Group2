/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Entities.Booking;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

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
            System.out.println(bDao.updateBookingStatus((long)4, "confirmed"));
        } catch (Exception e) {
            System.err.println(e);
        }
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

    public boolean createBooking(Booking b) throws Exception {
        String sql = """
                     INSERT INTO `crs`.`booking`
                     (`customer_id`,
                     `start_date`,
                     `return_date`)
                     VALUES
                     (?,
                     ?,
                     ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setLong(1, b.getCustomerId());
            ps.setDate(2, Date.valueOf(b.getStartDate()));
            ps.setDate(3, Date.valueOf(b.getReturnDate()));

            return ps.executeUpdate() > 0;

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
