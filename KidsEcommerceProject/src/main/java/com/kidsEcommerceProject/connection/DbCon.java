package com.kidsEcommerceProject.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbCon {
    private static Connection connection = null;

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        try {
            if (connection == null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/kids_ecommerce", "root", "Mand33p123!");
                System.out.println("Connected");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Print the stack trace to the console
            throw e; // Re-throwing the exception for the caller to handle
        }
        return connection;
    }
}
