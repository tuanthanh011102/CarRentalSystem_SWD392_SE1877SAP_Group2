/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Entities.User;
import java.sql.SQLException;

/**
 *
 * @author tuanthanh
 */
public class UserDAO extends DAO {

    public static void main(String[] args) {
        UserDAO udao = new UserDAO();
        try {
            System.out.println(udao.getUserByEmail("admin@carrental.com"));
        } catch (Exception e) {
        }
    }

    public User getUserByEmail(String email) throws SQLException, Exception {
        User u = new User();
        String sql = """
                     SELECT * FROM user WHERE email = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, email);

            rs = ps.executeQuery();

            if (rs.next()) {
                u.setUserId(rs.getLong("user_id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPasswordHash(rs.getString("password_hash"));
                u.setRole(rs.getString("role"));
                u.setCreatedAt(rs.getTimestamp("created_at"));
                u.setUpdatedAt(rs.getTimestamp("updated_at"));
            } else {
                return null;
            }

        } catch (SQLException e) {
            throw new SQLException("Something wrong with dao while getUserByEmail(), please check: " + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                throw new Exception("Something wrong with dao while trying to close resource in getUserByEmail(), please check: " + ex);
            }
        }

        return u;
    }
}
