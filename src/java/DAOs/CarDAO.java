/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Entities.Car;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tuanthanh
 */
public class CarDAO extends DAO {

    public static void main(String[] args) {
        CarDAO cDAO = new CarDAO();
        try {
            System.out.println(cDAO.getAllCar(1, 5, "", "", "").size());
        } catch (Exception ex) {
            System.err.println(ex);
        }
    }

    public List<Car> getAllCar(int page, int pageSize, String searchKey, String color, String priceOrder) throws SQLException, Exception {
        List<Car> carList = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
            SELECT *
            FROM car
            WHERE status = 'available'
        """);

        if (searchKey != null && !searchKey.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR model LIKE ? OR location LIKE ?) ");
        }

        if (color != null && !color.trim().isEmpty()) {
            sql.append(" AND color = ? ");
        }

        if (priceOrder != null && (priceOrder.equalsIgnoreCase("ASC") || priceOrder.equalsIgnoreCase("DESC"))) {
            sql.append(" ORDER BY price_per ").append(priceOrder);
        } else {
            sql.append(" ORDER BY created_at DESC "); // default
        }

        sql.append(" LIMIT ? OFFSET ? ");

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int paramIndex = 1;

            if (searchKey != null && !searchKey.trim().isEmpty()) {
                String key = "%" + searchKey.trim() + "%";
                ps.setString(paramIndex++, key);
                ps.setString(paramIndex++, key);
                ps.setString(paramIndex++, key);
            }

            if (color != null && !color.trim().isEmpty()) {
                ps.setString(paramIndex++, color);
            }

            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex++, (page - 1) * pageSize);

            rs = ps.executeQuery();

            while (rs.next()) {
                Car c = new Car();
                c.setCarId(rs.getLong("car_id"));
                c.setOwnerId(rs.getLong("owner_id"));
                c.setName(rs.getString("name"));
                c.setModel(rs.getString("model"));
                c.setColor(rs.getString("color"));
                c.setRegistrationNo(rs.getString("registration_no"));
                c.setPricePer(rs.getBigDecimal("price_per"));
                c.setStatus(rs.getString("status"));
                c.setLocation(rs.getString("location"));
                c.setThumbnail(rs.getString("thumbnail"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setUpdatedAt(rs.getTimestamp("updated_at"));
                carList.add(c);
            }

        } catch (SQLException e) {
            throw new SQLException("Something wrong with DAO while getAllCar(), please check: " + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                throw new Exception("Something wrong while closing resources in getAllCar(): " + ex);
            }
        }

        return carList;
    }

    public Car getCarById(long carId) throws Exception {
        Car c = new Car();
        String sql = """
                     SELECT * FROM car WHERE car_id = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, carId);

            rs = ps.executeQuery();

            if (rs.next()) {
                c.setCarId(rs.getLong("car_id"));
                c.setOwnerId(rs.getLong("owner_id"));
                c.setName(rs.getString("name"));
                c.setModel(rs.getString("model"));
                c.setColor(rs.getString("color"));
                c.setRegistrationNo(rs.getString("registration_no"));
                c.setPricePer(rs.getBigDecimal("price_per"));
                c.setStatus(rs.getString("status"));
                c.setLocation(rs.getString("location"));
                c.setThumbnail(rs.getString("thumbnail"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setUpdatedAt(rs.getTimestamp("updated_at"));
            } else {
                throw new Exception("Car not exist!");
            }

        } catch (SQLException e) {
            throw new SQLException("Something wrong with dao while getCarById(), please check: " + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                throw new Exception("Something wrong with dao while trying to close resource in getCarById(), please check: " + ex);
            }
        }

        return c;
    }
}
