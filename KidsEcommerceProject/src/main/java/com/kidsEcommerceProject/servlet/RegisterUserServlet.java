package com.kidsEcommerceProject.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.kidsEcommerceProject.connection.DbCon;
import com.kidsEcommerceProject.DAO.UserDao;
import com.kidsEcommerceProject.model.Users;

@WebServlet("/register")
public class RegisterUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Your implementation for handling GET requests
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        System.out.println("I am invoked - Register Servlet");
        try (PrintWriter out = response.getWriter()) {
            String firstName = request.getParameter("InputName");
            String lastName = request.getParameter("InputLastname");
            String email = request.getParameter("InputEmail1");
            String phone = request.getParameter("InputPhone");
            String password = request.getParameter("InputPassword1");
            String confirmPassword = request.getParameter("InputPasswordConfirm");

            // Basic validation - check if passwords match
            if (!password.equals(confirmPassword)) {
                request.setAttribute("registrationFailedMessage", "Passwords do not match. Please re-enter.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Create a user object with the provided details
            Users newUser = new Users(firstName, lastName, email, phone, password);

            try {
                UserDao udao = new UserDao(DbCon.getConnection());
                boolean isUserRegistered = udao.registerUser(newUser);

                if (isUserRegistered) {
                    // Registration successful
                    request.setAttribute("registrationSuccessMessage", "Registration successful. Please sign in.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    // Registration failed
                    request.setAttribute("registrationFailedMessage", "Registration failed. Please try again.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }

            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                request.setAttribute("registrationFailedMessage", "An error occurred during registration.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }
}
