<%@ page import="com.kidsEcommerceProject.connection.DbCon" %>
<%@ page import="com.kidsEcommerceProject.DAO.ProductDao" %>
<%@ page import="com.kidsEcommerceProject.DAO.OrderDao" %>
<%@ page import="com.kidsEcommerceProject.model.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%
    // Fetch orderID from the URL parameter
    long orderID = Long.parseLong(request.getParameter("orderID"));


    // Retrieve order details by order ID
    OrderDao orderDAO = new OrderDao(DbCon.getConnection());
    Orders order = orderDAO.getOrderById(orderID);
    List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderID);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Order Detail - KidsShop ECommerce Store</title>
    <%@include file="includes/header.jsp" %>
</head>
<body>
    <%@include file="includes/navbar.jsp" %>
	   <!-- Start All Title Box -->
		<div class="all-title-box">
		    <!-- Breadcrumb content -->
		    <div class="container">
		        <div class="row">
		            <div class="col-lg-12">
		                <!-- Adding a back link to My Account -->
		                <ul class="breadcrumb">
		                    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
		                    <li class="breadcrumb-item"><a href="my-account.jsp">My Account</a></li>
		                    <li class="breadcrumb-item">Order Details</li>
		                    <li class="breadcrumb-item active">
		                        <!-- Back arrow icon -->
		                        <a href="#" onclick="history.go(-1);return false;"><i class="fas fa-arrow-left"></i> Back</a>
		                    </li>
		                </ul>
		            </div>
		        </div>
		    </div>
		</div>
		<!-- End All Title Box -->

    <!-- Order details section -->
    <div class="container">
        <div class="row">
            <!-- Display order information -->
            <div class="col-lg-12">
                <h2>Order Details - Order ID: <%= order.getOrderID() %></h2>
                <!-- Display order-related information -->
                <p>Date: <%= order.getOrderDateFormatted() %></p>
                <p>Total Amount: $ <%= order.getTotalAmount() %></p>
                <p>Status: <%= order.getStatus() %></p>
                <!-- You can add more order information here -->
            </div>
        </div>
        <div class="row">
            <!-- Display order items -->
            <div class="col-lg-12">
                <h3>Ordered Products</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Loop through orderDetails to display individual product details -->
							<% for (OrderDetail detail : order.getOrderDetails()) { %>
							    <tr>
							        <td class="thumbnail-img">
									    <a href="product-detail.jsp?id=<%= detail.getProductID() %>">
									        <img class="img-fluid" src="images/<%= detail.getMainImage() %>" alt="" width="150" height="150" />
									    </a>
									</td>


							        <td class="name-pr">
							            <%= detail.getProductName() %>
							        </td>
							        <td class="price-pr">
							            <p>$ <%= detail.getUnitPrice() %></p>
							        </td>
							        <td class="quantity-box">
							            <p><%= detail.getQuantity() %></p>
							        </td>
							        <td class="total-pr">
							            <p>$ <%= detail.getUnitPrice() * detail.getQuantity() %></p>
							        </td>
							    </tr>
							<% } %>
								<tr ><td colspan="1"><a href="my-account.jsp"> <i class="fas fa-arrow-left"></i> Back to My Account</a></td></tr>
						 </tbody>
						 
                </table>
            </div>
        </div>
    </div>
    <!-- End Order details section -->
    <%@include file="includes/footer.jsp" %>
</body>
</html>
