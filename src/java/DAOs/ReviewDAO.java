/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Entities.Review;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tuanthanh
 */
public class ReviewDAO extends DAO {

    CustomerDAO customerDao = new CustomerDAO();

    public static void main(String[] args) {
        ReviewDAO rDao = new ReviewDAO();
        try {
            System.out.println(rDao.getAllReviewByCarId(1));
        } catch (Exception e) {
            System.err.println(e);
        }
    }

    public float getRatingByCarId(long carId) throws SQLException, Exception {
        String sql = "SELECT AVG(rating) AS avg_rating FROM review WHERE car_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, carId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getFloat("avg_rating");
            }
            return 0f;

        } catch (SQLException e) {
            throw new SQLException("Error in getRatingByCarId(): " + e.getMessage(), e);
        } finally {
            this.closeResources();
        }
    }

    public int getTotalReviewCountByCarId(long carId) throws SQLException, Exception {
        String sql = "SELECT COUNT(*) AS total FROM review WHERE car_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, carId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total");
            } else {
                return 0;
            }

        } catch (SQLException e) {
            throw new SQLException("Error in getTotalReviewCountByCarId(): " + e.getMessage(), e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                throw new Exception("Error closing resources in getTotalReviewCountByCarId(): " + ex.getMessage(), ex);
            }
        }
    }

    public List<Review> getAllReviewByCarId(long carId) throws SQLException, Exception {
        List<Review> rList = new ArrayList<>();
        String sql = """
                     SELECT * FROM crs.review where car_id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, carId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Review r = new Review();
                r.setReviewId(rs.getLong("review_id"));
                r.setCustomerId(rs.getLong("customer_id"));
                r.setCarId(rs.getLong("car_id"));
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));
                r.setCreatedAt(rs.getTimestamp("created_at"));
                r.setUpdatedAt(rs.getTimestamp("updated_at"));
                r.setBookingId(rs.getLong("booking_id"));

                r.setCustomer(customerDao.getCustomerByCustomerId(rs.getLong("customer_id")));

                rList.add(r);
            }

        } catch (SQLException e) {
            throw new SQLException("Error in getAllReviewByCarId(): " + e.getMessage(), e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                throw new Exception("Error closing resources in getAllReviewByCarId(): " + ex.getMessage(), ex);
            }
        }

        return rList;
    }
}
