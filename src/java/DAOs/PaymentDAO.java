/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Entities.Booking;
import Entities.Payment;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author tuanthanh
 */
public class PaymentDAO extends DAO {

    public static void main(String[] args) {
        PaymentDAO pDao = new PaymentDAO();
        try {
            System.out.println("");
        } catch (Exception e) {
            System.err.println("");
        }
    }

    public Payment getPaymentByBookingId(long bookingId) throws Exception {
        Payment p = null;

        String sql = """
                     SELECT * FROM payment WHERE booking_id = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setLong(1, bookingId);

            rs = ps.executeQuery();

            if (rs.next()) {
                p = new Payment();
                p.setPaymentId(rs.getLong("payment_id"));
                p.setBookingId(bookingId);
                p.setAmount(rs.getBigDecimal("amount"));
                p.setPaymentMethod(rs.getString("payment_method"));
                p.setStatus(rs.getString("status"));
                p.setGatewayTxnId(rs.getString("gateway_txn_id"));
                p.setPaidAt(rs.getTimestamp("paid_at").toLocalDateTime());
                p.setRefundedAmount(rs.getBigDecimal("refunded_amount"));
                p.setRefundStatus(rs.getString("refund_status"));
                p.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                p.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
            } else {
                throw new Exception("Payment not found");
            }

        } catch (Exception e) {
            throw new Exception("Something wrong during getPaymentByBookingId(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in getPaymentByBookingId(): " + e.getMessage());
            }
        }

        return p;
    }

    public boolean createPayment(Payment p) throws Exception {
        String sql = """
                     INSERT INTO `crs`.`payment`
                     (`booking_id`,
                     `amount`,
                     `payment_method`,
                     `gateway_txn_id`,
                     `paid_at`)
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

            ps.setLong(1, p.getBookingId());
            ps.setBigDecimal(2, p.getAmount());
            ps.setString(3, p.getPaymentMethod());
            ps.setString(4, p.getGatewayTxnId());
            ps.setTimestamp(5, Timestamp.valueOf(p.getPaidAt()));

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new Exception("Something wrong during createPayment(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in createPayment(): " + e.getMessage());
            }
        }
    }

    public boolean updatePaymentStatusByBookingId(long bookingId, String status) throws Exception {
        String sql = """
                     UPDATE `crs`.`payment`
                     SET
                     `status` = ?,
                     `updated_at` = ?
                     WHERE `booking_id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setLong(3, bookingId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new Exception("Something wrong during updatePaymentStatusByBookingId(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in updatePaymentStatusByBookingId(): " + e.getMessage());
            }
        }
    }
}
