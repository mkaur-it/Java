package com.kidsEcommerceProject.DAO;

import com.kidsEcommerceProject.connection.DbCon;
import com.kidsEcommerceProject.model.Address;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddressDao {

    private Connection connection;

    public AddressDao(Connection connection) {
        this.connection = connection;
    }

    // Method to add a new address
    public boolean addAddress(Address address) {
        boolean isSuccess = false;
        try {
            String query = "INSERT INTO address (userID, addressType, addressLine1, addressLine2, city, state, zipCode, country, phone) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, address.getUserID());
            ps.setString(2, address.getAddressType());
            ps.setString(3, address.getAddressLine1());
            ps.setString(4, address.getAddressLine2());
            ps.setString(5, address.getCity());
            ps.setString(6, address.getState());
            ps.setString(7, address.getZipCode());
            ps.setString(8, address.getCountry());
            ps.setString(9, address.getPhone());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // Method to retrieve address by userID
    public List<Address> getAddressesByUserID(int userID) {
        List<Address> addresses = new ArrayList<>();
        try {
            String query = "SELECT * FROM address WHERE userID = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            System.out.println("OK I am here before while");
            System.out.println("User Id here" + userID);
          
            while (rs.next()) {
            	System.out.println("\n in while");
                Address address = new Address();
                address.setAddressID(rs.getInt("addressID"));
                address.setUserID(rs.getInt("userID"));
                address.setAddressType(rs.getString("addressType"));
                address.setAddressLine1(rs.getString("addressLine1"));
                address.setAddressLine2(rs.getString("addressLine2"));
                address.setCity(rs.getString("city"));
                address.setState(rs.getString("state"));
                address.setZipCode(rs.getString("zipCode"));
                address.setCountry(rs.getString("country"));
                address.setPhone(rs.getString("phone"));
                addresses.add(address);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return addresses;
    }

    // Method to update an address
    public boolean updateAddress(Address address) {
        boolean isSuccess = false;
        try {
            String query = "UPDATE address SET addressType=?, addressLine1=?, addressLine2=?, city=?, state=?, zipCode=?, country=?, phone=? " +
                           "WHERE addressID=?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, address.getAddressType());
            ps.setString(2, address.getAddressLine1());
            ps.setString(3, address.getAddressLine2());
            ps.setString(4, address.getCity());
            ps.setString(5, address.getState());
            ps.setString(6, address.getZipCode());
            ps.setString(7, address.getCountry());
            ps.setString(8, address.getPhone());
            ps.setInt(9, address.getAddressID());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // Method to delete an address by addressID
    public boolean deleteAddress(int addressID) {
        boolean isSuccess = false;
        try {
            String query = "DELETE FROM address WHERE addressID=?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, addressID);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
    
    public int getNextUserID() {
        int nextUserID = 1; // Default value if no entry exists

        try {
            String query = "SELECT MAX(userID) AS maxUserID FROM address";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int maxUserID = rs.getInt("maxUserID");
                nextUserID = maxUserID + 1; // Increment to get the next userID
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return nextUserID;
    }
    public boolean checkAddressExists(Address address) {
        boolean addressExists = false;
        try {
            String query = "SELECT * FROM address WHERE " +
                           "userID = ? AND addressType = ? AND addressLine1 = ? AND addressLine2 = ? " +
                           "AND city = ? AND state = ? AND zipCode = ? AND country = ? AND phone = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, address.getUserID());
            ps.setString(2, address.getAddressType());
            ps.setString(3, address.getAddressLine1());
            ps.setString(4, address.getAddressLine2());
            ps.setString(5, address.getCity());
            ps.setString(6, address.getState());
            ps.setString(7, address.getZipCode());
            ps.setString(8, address.getCountry());
            ps.setString(9, address.getPhone());

            ResultSet rs = ps.executeQuery();
            addressExists = rs.next(); // If any result is returned, it means the address already exists
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return addressExists;
    }

}
