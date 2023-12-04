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

@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("InputEmail");
            String password = request.getParameter("InputPassword");
            String returnAttribute = (String) request.getSession().getAttribute("return");
            try {
                UserDao udao = new UserDao(DbCon.getConnection());
                Users user = udao.userLogin(email, password);
                
                if (user != null) {
                    request.getSession().setAttribute("auth", user);
                    // Set userID in the session
                    request.getSession().setAttribute("userID", user.getId());
                    
                    
                 // Print to check if 'returnAttribute' is being correctly received
                    System.out.println("Return Attribute: " + returnAttribute);

                    if (returnAttribute != null && returnAttribute.equals("checkout")) {
                        response.sendRedirect("checkout.jsp");
                        System.out.println("Redirecting to checkout.jsp");
                    } else {
                        response.sendRedirect("my-account.jsp");
                        System.out.println("Redirecting to my-account.jsp");
                    }

                } else {
                    request.setAttribute("loginFailedMessage", "User login failed. Please check your credentials.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }

            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is already authenticated (logged in)
        if (request.getSession().getAttribute("auth") != null) {
            // If logged in, redirect to my-account.jsp or any other page
            response.sendRedirect("my-account.jsp");
        } else {
            // If not logged in, allow access to login.jsp
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
