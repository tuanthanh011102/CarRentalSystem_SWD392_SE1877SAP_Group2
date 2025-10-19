/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author tuanthanh
 */
public class DAO {
    CRSDbContext dbc = new CRSDbContext();
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    protected boolean closeResources() throws SQLException, Exception {
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (con != null) {
            con.close();
        }
        return true;
    }

}
