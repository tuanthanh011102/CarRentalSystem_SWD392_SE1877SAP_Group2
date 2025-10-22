/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Entities.Owner;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tuanthanh
 */
public class OwnerDAO extends DAO {

    public static void main(String[] args) {
        OwnerDAO oDao = new OwnerDAO();
        try {
            System.out.println(oDao.getAllOwner(1, 2, ""));
        } catch (Exception e) {
            System.err.println(e);
        }
    }

    public Owner getOwnerById(long ownerId) throws Exception {
        Owner o = new Owner();
        String sql = """
                     SELECT * FROM owner WHERE owner_id = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setLong(1, ownerId);

            rs = ps.executeQuery();

            if (rs.next()) {
                o.setOwnerId(rs.getLong("owner_id"));
                o.setUserId(rs.getLong("user_id"));
                o.setName(rs.getString("name"));
                o.setContact(rs.getString("contact"));
                o.setAddress(rs.getString("address"));
                o.setCccdId(rs.getString("ccc_d_id"));
                o.setCreatedAt(rs.getTimestamp("created_at"));
            } else {
                throw new SQLException("Owner is not exist");
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

        return o;
    }

    public List<Owner> getAllOwner(int page, int pageSize, String searchKey) throws SQLException, Exception {
        List<Owner> olist = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT *
        FROM owner
        WHERE 1=1
    """);

        // Optional search
        if (searchKey != null && !searchKey.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR contact LIKE ? OR address LIKE ?) ");
        }

        // Pagination
        sql.append(" ORDER BY created_at DESC LIMIT ? OFFSET ? ");

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

            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex++, (page - 1) * pageSize);

            rs = ps.executeQuery();

            while (rs.next()) {
                Owner o = new Owner();
                o.setOwnerId(rs.getLong("owner_id"));
                o.setUserId(rs.getLong("user_id"));
                o.setName(rs.getString("name"));
                o.setContact(rs.getString("contact"));
                o.setAddress(rs.getString("address"));
                o.setCccdId(rs.getString("ccc_d_id"));
                o.setCreatedAt(rs.getTimestamp("created_at"));
                olist.add(o);
            }

        } catch (SQLException e) {
            throw new SQLException("Something wrong with DAO while getAllOwner(), please check: " + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                throw new Exception("Something wrong with DAO while trying to close resource in getAllOwner(), please check: " + ex);
            }
        }

        return olist;
    }

}
