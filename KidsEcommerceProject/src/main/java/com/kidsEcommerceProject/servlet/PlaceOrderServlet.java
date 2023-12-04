package com.kidsEcommerceProject.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kidsEcommerceProject.DAO.OrderDao;
import com.kidsEcommerceProject.connection.DbCon;
import com.kidsEcommerceProject.model.Orders;
import com.kidsEcommerceProject.model.Cart;
import com.kidsEcommerceProject.model.OrderDetail;
import com.kidsEcommerceProject.model.CartItemsList;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<OrderDetail> orderDetails = new ArrayList<>();
        OrderDao orderDao;

        try {
            orderDao = new OrderDao(DbCon.getConnection()); // Initialize your OrderDao (consider Dependency Injection)

            // Retrieve form parameters sent from the JSP
            String userIDStr = request.getParameter("userID");
            int userID = Integer.parseInt(userIDStr);
            String totalAmountStr = request.getParameter("totalAmount");
            double totalAmount = Double.parseDouble(totalAmountStr);
            String paymentMethod = request.getParameter("paymentMethod");

            // Assuming other required attributes are available or hardcoded for simplicity
            Orders newOrder = new Orders();
            long orderId = orderDao.generateUniqueOrderId();
            newOrder.setUserID(userID);
            newOrder.setTotalAmount(totalAmount);
            newOrder.setStatus("Received");
            newOrder.setPaymentMethod(paymentMethod);
            newOrder.setCancelFlag(0);

            // Get cart items list from the session attribute
            HttpSession session = request.getSession();
            ArrayList<Cart> cartItems = (ArrayList<Cart>) session.getAttribute("cart-list");

            // Instantiate CartItemsList
            CartItemsList cartItemsList = new CartItemsList();
            // Copy items from CartItemsList to OrderDetail
            orderDetails = cartItemsList.copyItemsToOrderDetail(orderId);

            // Clear itemsList after copying
            CartItemsList.clearItemsList();

            // Clear the cart items after the order is placed
            cartItems.clear();
            
            // Save the order using your OrderDao
            orderDao.placeOrder(newOrder, orderDetails);

            // Forward the request to the JSP page after setting the order object in the request attribute
            request.setAttribute("newOrder", newOrder);
            request.setAttribute("infoMessage", "Your order has been Received. Your Order Id is " + orderId);
            request.getRequestDispatcher("my-account.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions accordingly, for example, forwarding to an error page
            response.sendRedirect("error.jsp");
        }
    }
}

