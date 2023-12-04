package com.kidsEcommerceProject.DAO;

import com.google.protobuf.Timestamp;
import com.kidsEcommerceProject.model.OrderDetail;
import com.kidsEcommerceProject.model.Orders;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class OrderDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet res;

    public OrderDao(Connection con) {
        this.con = con;
    }
    public OrderDao() {
        // Constructor logic, if needed
    }

    public boolean placeOrder(Orders newOrder, List<OrderDetail> orderDetails) {
        boolean success = false;
        PreparedStatement orderStatement = null;
        PreparedStatement orderDetailStatement = null;
        
        try {
            long orderId = generateUniqueOrderId();

            String insertOrderQuery = "INSERT INTO orders (orderID, userID, orderDate, totalAmount, status, paymentMethod) VALUES (?, ?, ?, ?, ?, ?)";
            orderStatement = this.con.prepareStatement(insertOrderQuery);
            orderStatement.setLong(1, orderId);
            orderStatement.setInt(2, newOrder.getUserID());
            orderStatement.setDate(3, new java.sql.Date(newOrder.getOrderDate().getTime()));
            orderStatement.setDouble(4, newOrder.getTotalAmount());
            orderStatement.setString(5, newOrder.getStatus());
            orderStatement.setString(6, newOrder.getPaymentMethod());

            System.out.println("Insert Order Query: " + orderStatement.toString());

            int rowsAffected = orderStatement.executeUpdate();

            if (rowsAffected > 0) {
                String insertOrderDetailQuery = "INSERT INTO orderdetail (orderID, productID, quantity, unitPrice,tax) VALUES (?,?, ?, ?, ?)";
                orderDetailStatement = this.con.prepareStatement(insertOrderDetailQuery);

                // Loop through each OrderDetail and add it to the batch
                for (OrderDetail orderDetail : orderDetails) {
                	
                    orderDetailStatement.setLong(1, orderId);            // Set orderID
                    orderDetailStatement.setInt(2, orderDetail.getProductID());    // Set productID
                    orderDetailStatement.setInt(3, orderDetail.getQuantity());     // Set quantity
                    orderDetailStatement.setDouble(4, orderDetail.getUnitPrice());  // Set unitPrice
                    orderDetailStatement.setDouble(5, 13.00);  // Set unitPrice

                    orderDetailStatement.addBatch(); // Add the current OrderDetail values to the batch
                }

                System.out.println("Insert Order Detail Query: " + orderDetailStatement.toString());

                int[] detailRows = orderDetailStatement.executeBatch();

                for (int row : detailRows) {
                    if (row <= 0) {
                        throw new SQLException("Failed to insert order details.");
                    }
                }

                success = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (orderStatement != null) {
                    orderStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            try {
                if (orderDetailStatement != null) {
                    orderDetailStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    public long generateUniqueOrderId() {
        // Get current timestamp in milliseconds
        long millis = System.currentTimeMillis();

        // Generate a random number between 100 and 999 for uniqueness
        int randomNum = new Random().nextInt(900) + 100;

        // Combine timestamp and random number to create a unique OrderID
        return Long.parseLong(String.valueOf(millis) + randomNum);
    }

    public List<OrderDetail> getOrderDetails(long id) {
        List<OrderDetail> list = new ArrayList<>();

        try {
            query = "SELECT * FROM OrderDetail WHERE OrderID = ?";
            pst = this.con.prepareStatement(query);
            pst.setLong(1, id);
            res = pst.executeQuery();

            while (res.next()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderDetailID(res.getInt("OrderDetailID"));
                orderDetail.setOrderID(res.getLong("OrderID"));
                orderDetail.setProductID(res.getInt("ProductID"));
                orderDetail.setQuantity(res.getInt("Quantity"));
                orderDetail.setUnitPrice(res.getDouble("UnitPrice"));
                orderDetail.setDiscount(res.getDouble("Discount"));
                orderDetail.setTax(res.getDouble("Tax"));
                list.add(orderDetail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void cancelOrder(long id, HttpServletRequest request, HttpServletResponse response) {
        try {
            String getStatusQuery = "SELECT status FROM Orders WHERE orderID = ?";
            pst = this.con.prepareStatement(getStatusQuery);
            pst.setLong(1, id);
            ResultSet resultSet = pst.executeQuery();

            if (resultSet.next()) {
                String currentStatus = resultSet.getString("status");

                if (!"Shipped".equals(currentStatus)) {
                    // If the current status is not 'Shipped', update the order status to 'Cancellation Request Received'
                    String updateQuery = "UPDATE Orders SET cancelFlag = true, status = 'Cancellation Request Received' WHERE orderID = ?";
                    pst = this.con.prepareStatement(updateQuery);
                    pst.setLong(1, id);
                    pst.executeUpdate();
                 // If the current status is 'Not Shipped or Processing', set a message attribute and redirect back to my-account.jsp
                 // Set an info message
                    request.setAttribute("infoMessage", "Your cancellation requested has been submitted for Cancellation. Please check email for confirmation.");
                    request.getRequestDispatcher("my-account.jsp").forward(request, response);
                 } else {
                    // If the current status is 'Shipped', set a message attribute and redirect back to my-account.jsp
                    request.setAttribute("infoMessage", "Your order has been shipped. Please return the unopened products upon delivery.");
                    request.getRequestDispatcher("my-account.jsp").forward(request, response);
                }
                if ("Cancellation Request Received".equals(currentStatus)) {
                    // If the current status is 'Cancellation Request Received', display an appropriate info message
                    request.setAttribute("infoMessage", "Your cancellation request has already been received. Plesae monitor your email for updates");
                    request.getRequestDispatcher("my-account.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    
    public List<Orders> getOrdersByUserID(int userID) {
        List<Orders> ordersList = new ArrayList<>();

        try {
        	String query = "SELECT * FROM Orders WHERE userID = ? ORDER BY orderDate DESC"; 
            pst = this.con.prepareStatement(query);
            pst.setInt(1, userID);
            res = pst.executeQuery();

            while (res.next()) {
                Orders order = new Orders();
                order.setOrderID(res.getLong("orderID"));
                order.setUserID(res.getInt("userID"));
                order.setOrderDate(res.getDate("orderDate"));
                order.setTotalAmount(res.getDouble("totalAmount"));
                order.setStatus(res.getString("status"));
                order.setCancelFlag(res.getInt("cancelFlag"));
                order.setPaymentMethod(res.getString("paymentMethod"));
                order.setDeliveryDate(res.getDate("deliveryDate"));
                order.setTrackingNumber(res.getString("trackingNumber"));
                
                // Add order to the list
                ordersList.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ordersList;
    }
    
    public Orders getOrderById(long id) {
        Orders order = null;

        try {
            // Fetch order details from Orders table
            query = "SELECT * FROM Orders WHERE orderID = ?";
            pst = this.con.prepareStatement(query);
            pst.setLong(1, id);
            res = pst.executeQuery();

            if (res.next()) {
                order = new Orders();
                order.setOrderID(res.getLong("orderID"));
                order.setUserID(res.getInt("userID"));
                order.setOrderDate(res.getDate("orderDate"));
                order.setTotalAmount(res.getDouble("totalAmount"));
                order.setStatus(res.getString("status"));
                order.setCancelFlag(res.getInt("cancelFlag"));
                order.setPaymentMethod(res.getString("paymentMethod"));
                order.setDeliveryDate(res.getDate("deliveryDate"));
                order.setTrackingNumber(res.getString("trackingNumber"));

                // Fetch order details from OrderDetail table
                List<OrderDetail> orderDetails = new ArrayList<>();
                query = "SELECT od.*, p.productName, p.mainImage " +
                        "FROM OrderDetail od " +
                        "INNER JOIN Products p ON od.productID = p.productID " +
                        "WHERE od.orderID = ?";
                pst = this.con.prepareStatement(query);
                pst.setLong(1, id);
                res = pst.executeQuery();

                while (res.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderDetailID(res.getInt("orderDetailID"));
                    detail.setOrderID(res.getLong("orderID"));
                    detail.setProductID(res.getInt("productID"));
                    detail.setQuantity(res.getInt("quantity"));
                    detail.setUnitPrice(res.getDouble("unitPrice"));
                    detail.setDiscount(res.getDouble("discount"));
                    detail.setProductName(res.getString("productName"));
                    detail.setMainImage(res.getString("mainImage"));
                    orderDetails.add(detail);
                }

                // Set order details in the order
                order.setOrderDetails(orderDetails);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }


}

