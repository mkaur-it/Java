package com.kidsEcommerceProject.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date; // Import java.util.Date instead of java.sql.Date

import com.kidsEcommerceProject.connection.DbCon;

@WebServlet("/submit-contact")
public class SubmitContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Retrieve form parameters from the request
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            // Get the current date and time using java.util.Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String inquiryDate = sdf.format(new Date()); // Using java.util.Date

            // Create a database connection
            connection = DbCon.getConnection();

            // SQL query to insert contact details into ContactUs table
            String insertQuery = "INSERT INTO ContactUs (InquiryDate, Subject, Message) VALUES (?, ?, ?)";

            // Prepare the statement
            preparedStatement = connection.prepareStatement(insertQuery);
           
            preparedStatement.setString(1, inquiryDate);
            preparedStatement.setString(2, subject);
            preparedStatement.setString(3, message);

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                // If insertion is successful, redirect to a success page or do further processing
            	 request.setAttribute("infoMessage", " Your query has been received. Thank you for contacting us.");
                 request.getRequestDispatcher("contact.jsp").forward(request, response);
            } else {
                // If insertion fails, redirect to an error page or handle the error accordingly
                response.sendRedirect("contactError.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions accordingly, for example, forwarding to an error page
            response.sendRedirect("error.jsp");
        } finally {
            // Close the resources in a finally block to ensure they're always closed
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
