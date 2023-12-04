package com.kidsEcommerceProject.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.kidsEcommerceProject.DAO.OrderDao;
import com.kidsEcommerceProject.connection.DbCon;
import com.kidsEcommerceProject.model.OrderDetail;
import com.kidsEcommerceProject.model.Orders;

@WebServlet("/order-details")
public class OrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderID"));

        OrderDao orderDao;
        try {
            orderDao = new OrderDao(DbCon.getConnection());
            Orders order = orderDao.getOrderById(orderId);
            List<OrderDetail> orderDetails = orderDao.getOrderDetails(orderId);

            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            request.getRequestDispatcher("order-details.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

}
