package com.kidsEcommerceProject.servlet;

import com.kidsEcommerceProject.DAO.AddressDao;
import com.kidsEcommerceProject.connection.DbCon;
import com.kidsEcommerceProject.model.Address;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/edit-address")
public class EditAddressServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        int addressID = Integer.parseInt(request.getParameter("addressID"));
        int userID = Integer.parseInt(request.getParameter("userID")); // Assuming userID is obtained from the session or elsewhere
        String addressType = request.getParameter("addressType");
        String addressLine1 = request.getParameter("addressLine1");
        String addressLine2 = request.getParameter("addressLine2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipCode");
        String country = request.getParameter("country");
        String phone = request.getParameter("phone");

        // Create Address object
        Address address = new Address();
        address.setAddressID(addressID);
        address.setUserID(userID);
        address.setAddressType(addressType);
        address.setAddressLine1(addressLine1);
        address.setAddressLine2(addressLine2);
        address.setCity(city);
        address.setState(state);
        address.setZipCode(zipCode);
        address.setCountry(country);
        address.setPhone(phone);

        try {
            AddressDao addressDAO = new AddressDao(DbCon.getConnection());
            boolean isSuccess = addressDAO.updateAddress(address);
            if (isSuccess) {
                // Address updated successfully
                // Redirect to a success page or display a success message
                response.sendRedirect("success.jsp");
            } else {
                // Address update failed
                // Redirect to an error page or display an error message
                response.sendRedirect("error.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }     
    }
}