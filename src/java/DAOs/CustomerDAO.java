/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Entities.Booking;
import Entities.Customer;

/**
 *
 * @author tuanthanh
 */
public class CustomerDAO extends DAO {

    public static void main(String[] args) {
        CustomerDAO cDao = new CustomerDAO();
        try {
            System.out.println("");
        } catch (Exception e) {
            System.err.println("");
        }
    }

    public Customer getCustomerByUserId(long userId) throws Exception {
        Customer c = null;
        String sql = """
                     SELECT * FROM customer WHERE user_id = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setLong(1, userId);

            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Customer();
                c.setCustomerId(rs.getLong("customer_id"));
                c.setUserId(rs.getLong("user_id"));
                c.setName(rs.getString("name"));
                c.setPhone(rs.getString("phone"));
                c.setAddress(rs.getString("address"));
                c.setCccdId(rs.getString("ccc_d_id"));
                c.setEmail(rs.getString("email"));
                c.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                c.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
            } else {
                throw new Exception("customer not found");
            }

        } catch (Exception e) {
            throw new Exception("Something wrong during getCustomerByUserId(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in getCustomerByUserId(): " + e.getMessage());
            }
        }

        return c;
    }
    
    public Customer getCustomerByCustomerId(long customerId) throws Exception {
        Customer c = null;
        String sql = """
                     SELECT * FROM customer WHERE customer_id = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setLong(1, customerId);

            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Customer();
                c.setCustomerId(rs.getLong("customer_id"));
                c.setUserId(rs.getLong("user_id"));
                c.setName(rs.getString("name"));
                c.setPhone(rs.getString("phone"));
                c.setAddress(rs.getString("address"));
                c.setCccdId(rs.getString("ccc_d_id"));
                c.setEmail(rs.getString("email"));
                c.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                c.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
            } else {
                throw new Exception("customer not found");
            }

        } catch (Exception e) {
            throw new Exception("Something wrong during getCustomerByCustomerId(): " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                throw new Exception("Something wrong during closing resources in getCustomerByCustomerId(): " + e.getMessage());
            }
        }

        return c;
    }
}
