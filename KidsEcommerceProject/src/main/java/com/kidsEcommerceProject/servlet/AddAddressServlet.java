package com.kidsEcommerceProject.servlet;

import com.kidsEcommerceProject.DAO.AddressDao;
import com.kidsEcommerceProject.connection.DbCon;
import com.kidsEcommerceProject.model.Address;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/add-address")
public class AddAddressServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer sessionUserID = (Integer) session.getAttribute("userID");

	    // Check if the session attribute "userID" exists and is not null
	    int userID = (sessionUserID != null) ? sessionUserID : -1;
	    if (userID != -1) {
	    	String addressType = request.getParameter("addressType");
	        String addressLine1 = request.getParameter("addressLine1");
	        String addressLine2 = request.getParameter("addressLine2");
	        String city = request.getParameter("city");
	        String state = request.getParameter("state");
	        String zipCode = request.getParameter("zipCode");
	        String country = request.getParameter("country");
	        String phone = request.getParameter("phone");

	        Address address = new Address();
	        address.setUserID(userID);
	        address.setAddressType(addressType);
	        address.setAddressLine1(addressLine1);
	        address.setAddressLine2(addressLine2);
	        address.setCity(city);
	        address.setState(state);
	        address.setZipCode(zipCode);
	        address.setCountry(country);
	        address.setPhone(phone);

	        boolean addressExists = false;
	        try {
	            AddressDao addressDAO = new AddressDao(DbCon.getConnection());
	            addressExists = addressDAO.checkAddressExists(address);
	        } catch (ClassNotFoundException | SQLException e) {
	            e.printStackTrace();
	        }

	        if (addressExists) {
	            request.setAttribute("addressExistsMessage", "Address already exists");
	            request.getRequestDispatcher("my-account.jsp").forward(request, response);
	        } else {
	            boolean isSuccess = false;
	            try {
	                AddressDao addressDAO = new AddressDao(DbCon.getConnection());
	                isSuccess = addressDAO.addAddress(address);
	            } catch (ClassNotFoundException | SQLException e) {
	                e.printStackTrace();
	            }

	            if (isSuccess) {
	                request.setAttribute("addAddressSuccessMessage", "Address has been added successfully");
	                request.getRequestDispatcher("my-account.jsp").forward(request, response);
	            } else {
	                response.sendRedirect("error.jsp");
	            }
	        }
	    }
	    else {
	    	response.sendRedirect("login.jsp");
	    }
        
    }
}
