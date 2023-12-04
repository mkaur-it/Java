package com.kidsEcommerceProject.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cart-check-out")
public class CheckOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("userID") != null) {
            // User is logged in, proceed with checkout
            // ... Your existing checkout logic here ...

            // Forward to the checkout JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
            dispatcher.forward(request, response);
            System.out.println("on landing cart user is logged in ");
        } else {
            // User is not logged in, redirect to the login page
            String returnURL = "checkout"; // URL of the current page

            // Set the returnURL as a session attribute
            session.setAttribute("return", returnURL);

            // Redirect to the login page
            response.sendRedirect("login.jsp");
            System.out.println("on landing cart user is NOT logged in " +  session.getAttribute("return"));
        }
    }


}
