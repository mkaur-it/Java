package com.kidsEcommerceProject.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import com.kidsEcommerceProject.DAO.OrderDao;
import com.kidsEcommerceProject.connection.DbCon;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long orderId = Long.parseLong(request.getParameter("orderID"));

        OrderDao orderDao;
        try {
            orderDao = new OrderDao(DbCon.getConnection());
            orderDao.cancelOrder(orderId, request, response);

            // Set success message
            request.setAttribute("cancelSuccessMessage", "Requested has been submitted for Cancellation");
            // Redirect to my-account.jsp
            response.sendRedirect("my-account.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}