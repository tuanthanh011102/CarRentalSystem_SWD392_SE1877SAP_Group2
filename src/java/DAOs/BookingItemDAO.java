/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Entities.BookingItem;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tuanthanh
 */
public class BookingItemDAO extends DAO {

    public static void main(String[] args) {
        BookingItemDAO biDao = new BookingItemDAO();
        try {
            System.out.println(biDao.getBookingItemsByBookingId(1));
        } catch (Exception e) {
            System.err.println(e);
        }
    }

    public List<BookingItem> getBookingItemsByBookingId(long bookingId) throws Exception {
        List<BookingItem> bItems = new ArrayList<>();
        String sql = """
                     SELECT * FROM booking_item WHERE booking_id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setLong(1, bookingId);

            rs = ps.executeQuery();

            while (rs.next()) {
                BookingItem bi = new BookingItem();
                bi.setBookingItemId(rs.getLong("booking_item_id"));
                bi.setBookingId(rs.getLong("booking_id"));
                bi.setCarId(rs.getLong("car_id"));
                bi.setStartDate(rs.getDate("start_date").toLocalDate());
                bi.setEndDate(rs.getDate("end_date").toLocalDate());
                bi.setPrice(rs.getBigDecimal("price"));
                bi.setStatus(rs.getString("status"));
                bi.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                bi.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());

                bItems.add(bi);
            }

        } catch (SQLException e) {
            throw new Exception("Something wrong during getBookingItemsByBookingId(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in getBookingItemsByBookingId(): " + e.getMessage());
            }
        }

        return bItems;
    }

    public boolean createBookingItem(BookingItem bi) throws Exception {
        String sql = """
                     INSERT INTO `crs`.`booking_item`
                     (`booking_id`,
                     `car_id`,
                     `start_date`,
                     `end_date`,
                     `price`)
                     VALUES
                     (?,
                     ?,
                     ?,
                     ?,
                     ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setLong(1, bi.getBookingId());
            ps.setLong(1, bi.getCarId());
            ps.setDate(3, Date.valueOf(bi.getStartDate()));
            ps.setDate(4, Date.valueOf(bi.getEndDate()));
            ps.setBigDecimal(5, bi.getPrice());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new Exception("Something wrong during createBookingItem(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in createBookingItem(): " + e.getMessage());
            }
        }
    }

    public boolean updateBookingItemStatus(long bookingItemId, String status) throws Exception {
        String sql = """
                     UPDATE `crs`.`booking_item`
                     SET
                     `status` = ?,
                     `updated_at` = ?
                     WHERE `booking_item_id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setLong(3, bookingItemId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new Exception("Something wrong during updateBookingItemStatus(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in updateBookingItemStatus(): " + e.getMessage());
            }
        }
    }
}
