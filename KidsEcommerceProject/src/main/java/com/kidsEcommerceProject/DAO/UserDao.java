package com.kidsEcommerceProject.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kidsEcommerceProject.model.Users;
import com.kidsEcommerceProject.model.Address;

public class UserDao {
	
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet res;
	
	public UserDao(Connection con) {
		this.con = con;
	}
	
	public Users userLogin(String email, String password) {
		Users user = null;
		try {
			query = "select * from users where email=? and password=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2, password);
			res = pst.executeQuery();
			//System.out.print("Reached here credentials --> " + email + password + "\n");
			
			if(res.next()) {
				user = new Users();
				user.setId(res.getInt("userID"));
				user.setFirstName(res.getString("firstName"));
				user.setLastName(res.getString("lastName"));
				user.setEmail(res.getString("email"));
				user.setPhone(res.getString("phone"));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return user;
		
	}
	
	public boolean registerUser(Users user) {
        boolean isUserRegistered = false;
        
        try {
            query = "INSERT INTO users (firstName, lastName, email, phone, password) VALUES (?, ?, ?, ?, ?)";
            pst = this.con.prepareStatement(query);
            pst.setString(1, user.getFirstName());
            pst.setString(2, user.getLastName());
            pst.setString(3, user.getEmail());
            pst.setString(4, user.getPhone());
            pst.setString(5, user.getPassword());
            
            int rowsAffected = pst.executeUpdate();
            
            if (rowsAffected > 0) {
                isUserRegistered = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return isUserRegistered;
    }
	
	public Users getUserDetailsByID(int userID) {
	    Users user = null;
	    try {
	        query = "SELECT * FROM users WHERE userID=?";
	        pst = this.con.prepareStatement(query);
	        pst.setInt(1, userID);
	        res = pst.executeQuery();

	        if (res.next()) {
	            user = new Users();
	            user.setId(res.getInt("userID"));
	            user.setFirstName(res.getString("firstName"));
	            user.setLastName(res.getString("lastName"));
	            user.setEmail(res.getString("email"));
	            user.setPhone(res.getString("phone"));
	         // Get addresses and set them to the user object
	            List<Address> addresses = getAddressesByUserID(userID);
	            user.setAddresses(addresses); // Assuming there's a method to set addresses in Users class
	            // Add additional user details if required
	            getAddressesByUserID(res.getInt("userID"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return user;
	}
	// Method to get addresses by userID
    public List<Address> getAddressesByUserID(int userID) {
        List<Address> addresses = new ArrayList<>();
        try {
            String query = "SELECT * FROM address WHERE userID = ?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, userID);
            ResultSet res = pst.executeQuery();

            while (res.next()) {
                Address address = new Address();
                address.setAddressID(res.getInt("addressID"));
                address.setUserID(res.getInt("userID"));
                address.setAddressType(res.getString("addressType"));
                address.setAddressLine1(res.getString("addressLine1"));
                address.setAddressLine2(res.getString("addressLine2"));
                address.setCity(res.getString("city"));
                address.setState(res.getString("state"));
                address.setZipCode(res.getString("zipCode"));
                address.setCountry(res.getString("country"));
                address.setPhone(res.getString("phone"));

                addresses.add(address);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return addresses;
    }

}