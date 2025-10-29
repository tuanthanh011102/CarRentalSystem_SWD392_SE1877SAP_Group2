/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.SQLException;

/**
 *
 * @author tuanthanh
 */
public class ReviewDAO extends DAO {

    public static void main(String[] args) {

    }

    public float getRatingByCarId(long carId) throws SQLException, Exception {
        String sql = """
                     SELECT * FROM reviews WHERE car_id = ?;
                     """;
        float ratingTotalPoint = 0;
        int totalReviews = 0;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setLong(1, carId);

            while (rs.next()) {
                totalReviews++;
                ratingTotalPoint += rs.getInt("rating");
            }

            return ratingTotalPoint / totalReviews;

        } catch (SQLException e) {
            throw new SQLException("Something wrong with dao while getRatingByCarId(), please check: " + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                throw new Exception("Something wrong with dao while trying to close resource in getRatingByCarId(), please check: " + ex);
            }
        }
    }

    public int getTotalReviewCountByCarId(long carId) {
        return 0;
    }
}
