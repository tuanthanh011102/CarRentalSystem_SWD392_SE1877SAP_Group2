package DAOs;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author tuanthanh
 */
public class CRSDbContext {
    public Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/crs";
            String username = "root"; 
            String password = "221";
            Connection connection = DriverManager.getConnection(url, username, password);
            return connection;
        } catch (ClassNotFoundException e) {
            String msg = "ClassNotFoundException throw from method getConnection()";
        } catch (SQLException e) {
            String msg = "SQLException throw from method getConnection()";
        } catch (Exception e) {
            String msg = "Unexpected Exception throw from method getConnection()";
        }
        return null;
    }

    public static void main(String[] args) {
        CRSDbContext db = new CRSDbContext();
        if(db.getConnection() != null){
            System.out.println("Success");
        }
    }

}
