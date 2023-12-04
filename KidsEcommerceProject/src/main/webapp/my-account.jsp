<%@ page import="com.kidsEcommerceProject.connection.DbCon" %>
<%@ page import="com.kidsEcommerceProject.DAO.ProductDao" %>
<%@ page import="com.kidsEcommerceProject.DAO.AddressDao" %>
<%@ page import="com.kidsEcommerceProject.DAO.OrderDao" %>
<%@ page import="com.kidsEcommerceProject.model.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%
    ProductDao pd = new ProductDao(DbCon.getConnection());

    int userID = 0; // Initialize userID variable

    if (session != null && session.getAttribute("userID") != null) {
        userID = (int) session.getAttribute("userID");
        System.out.println("UserID: " + userID);
        // Further processing with userID
    } else {
        // if not logged in redircet to login page
    	response.sendRedirect("login.jsp");
    }

    // Retrieve the user's addresses
    AddressDao addressDAO = new AddressDao(DbCon.getConnection());
    List<Address> userAddresses = addressDAO.getAddressesByUserID(userID);

    request.setAttribute("userAddresses", userAddresses);
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <title>My Account - KidsShop ECommerce Store</title>
    <%@include file="includes/header.jsp" %>

</head>

<body>
    <%@include file="includes/navbar.jsp" %>
        <!-- Start All Title Box -->
        <div class="all-title-box">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                            <li class="breadcrumb-item active">My Account</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- End All Title Box -->
        <!-- Start My Account  -->
        <div class="my-account-box-main">
            <div class="container">
                <div class="my-account-page">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="account-box">
                                <div class="service-box">
                                    <!-- Your existing account box content -->
                                    <div class="service-icon">
                                        <a href="#"> <i class="fa fa-gift"></i></a>
                                    </div>
                                    <div class="service-desc">
								    <h4>Your Orders</h4>
								    <p>Track, return, or buy things again</p>
								    <!-- Orders Table -->
								    <div class="cart-box-main mt-1 pt-1">
								        <div class="container">
								            <div class="row">
								                <div class="col-lg-12">
								                    <div class="table-main table-responsive">
								                        <table class="table">
								                            <thead>
								                                <tr>
								                                    <th>Order ID</th>
								                                    <th>Date</th>
								                                    <th>Total Amount</th>
								                                    <th>Status</th>
								                                    <th>Cancel Order</th>
								                                    <!-- Add more columns as needed -->
								                                </tr>
								                            </thead>
								                            <tbody>
								                                <% 
								                                // Fetch order data and populate the table rows
								                                OrderDao ordersDAO = new OrderDao(DbCon.getConnection());
								                                List<Orders> userOrders = ordersDAO.getOrdersByUserID(userID); // Assuming you have a method to fetch orders by user ID
								
								                                if (userOrders != null && !userOrders.isEmpty()) {
								                                    for (Orders order : userOrders) {
								                                %>
								                                <!-- Existing table row -->
																<tr>
																    <td><a href="order-detail.jsp?orderID=<%= order.getOrderID() %>"><%= order.getOrderID() %></a></td>
																    <td style="font-weight: 600;"><%= order.getOrderDateFormatted() %></td>
																    <td style="font-weight: 600;">$ <%= order.getTotalAmount() %></td>
																    <td class="name-pr"><strong><%= order.getStatus() %></strong></td>
																    <!-- Add more columns with order details as needed -->
																    <td>
																   		 <% if (order.getStatus().equals("Cancellation Request Received")) { %>
																		    <a href="cancel-order?orderID=<%= order.getOrderID() %>">
																		        <i class="fas fa-times-circle"></i> Cancellation Under Process
																		    </a>
																		 <% } 
																		   else {%>
																    
																	        <a href="cancel-order?orderID=<%= order.getOrderID() %>">
																	            <i class="fas fa-times-circle"></i> Cancel Order
																	        </a>
																        <% } %>
																    </td>
																 </tr>
																
								                                <% 
								                                    }
								                                } else {
								                                %>
								                                <tr>
								                                    <td colspan="3">No orders found.</td>
								                                </tr>
								                                <% 
								                                }
								                                %>
								                                <!-- Display info message -->
																	<% if (request.getAttribute("infoMessage") != null) { %>
																	<div class="info-message">
																		<i class="fas fa-info-circle"><%= request.getAttribute("infoMessage") %></i>
																	    
																	</div>
																	<% } %>

								                            </tbody>
								                        </table>
								                    </div>
								                </div>
								            </div>
								        </div>
								    </div>
								</div>

                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="account-box">
                                <div class="service-box">
                                    <!-- Your existing account box content -->
                                    <div class="service-icon">
                                        <a href="#" onclick="toggleAddressForm()"> <i class="fa fa-location-arrow"></i></a>
                                    </div>
                                    <div class="service-desc">
                                        <h4>Your Addresses</h4>
                                        <p>Edit addresses for orders and gifts</p>
                                        <!-- Existing Addresses -->
						                    <div id="existingAddresses">
						                        <h2>Your Addresses</h2><br>
						                        <div class="row">
						                            <% if (userAddresses !=null && !userAddresses.isEmpty()) { %>
						                            <% for (Address address : userAddresses) { %>
						                            <div class="col-md-6">
						                                <div class="service-box">
						                                    <!-- Display existing address details here -->
						                                    <h4 ><%= address.getAddressType() %></h4>
						                                    <p style="font-weight: 600;"><%= address.getAddressLine1() %></p>
						                                    <p style="font-weight: 600;"><%= address.getAddressLine2() %></p>
						                                    <p style="font-weight: 600;"><%= address.getCity() %>, <%= address.getState() %></p>
						                                    <p style="font-weight: 600;"><%= address.getCountry() %>, <%= address.getZipCode() %></p>
						                                    <p style="font-weight: 600;">Phone: <%= address.getPhone() %></p>
						                                    <p>
															    <a href="edit-address.jsp?addressID=<%= address.getAddressID() %>">
															        <i class="fas fa-edit"></i> Edit
															    </a>
															    <a href="delete-address.jsp?addressID=<%= address.getAddressID() %>">
															        <i class="fas fa-trash-alt"></i> Delete
															    </a>
															</p>
						
						                                </div>
						                            </div>
						                            <% } %>
						                            <% } else { %>
						                            <div class="col-md-12">
						                                <p>No addresses found.</p>
						                            </div>
						                            <% } %>
						                        </div>
						                    </div>
						                    <!-- Add this block to display the addAddressSuccessMessage -->
						                    <% if (request.getAttribute("addAddressSuccessMessage") !=null) { %>
						                    <div class="success-message">
						                        <%= request.getAttribute("addAddressSuccessMessage") %>
						                    </div>
						                    <% } %>
						                    <!-- Add this block to display the addressExistsMessage -->
						                    <% if (request.getAttribute("addressExistsMessage") !=null) { %>
						                    <div class="error-message">
						                        <%= request.getAttribute("addressExistsMessage") %>
						                    </div>
						                    <% } %>
						                    <!-- Existing Address  -->
						                    <div class="row">
						                        <% if (userAddresses !=null && !userAddresses.isEmpty()) { %>
						                        <% for (Address address : userAddresses) { %>
						                        <div class="col-md-6">
						                            <div class="address-box">
						                                <!-- Address Details -->
						                            </div>
						                        </div>
						                        <% } %>
						                        <% } else { %>
						                        <div class="col-md-12">
						                            <p>No addresses found.</p>
						                        </div>
						                        <% } %>
						                    </div>
						                    <!-- Add Address Form -->
						                    <h2>Add New Address</h2>
						                    <form action="add-address" method="post">
									         <div class="form-group">
									            <label for="addressType">Address Type:</label>
									            <select id="addressType" name="addressType" class="form-control" required>
									                <option value="">Select Address Type</option>
									                <option value="Billing">Billing Address</option>
									                <option value="Shipping">Shipping Address</option>
									            </select>
									            <div class="help-block with-errors"></div>
									        </div>
									        <div class="form-group">
									            <label for="addressLine1">Address Line 1:</label>
									            <input type="text" id="addressLine1" name="addressLine1" class="form-control" required>
									            <div class="help-block with-errors"></div>
									        </div>
									        <div class="form-group">
									            <label for="addressLine2">Address Line 2:</label>
									            <input type="text" id="addressLine2" name="addressLine2" class="form-control">
									            <div class="help-block with-errors"></div>
									        </div>
									        <div class="form-group">
									            <label for="city">City:</label>
									            <input type="text" id="city" name="city" class="form-control" required>
									            <div class="help-block with-errors"></div>
									        </div>
									        <div class="form-group">
									            <label for="state">State:</label>
									            <input type="text" id="state" name="state" class="form-control" required>
									            <div class="help-block with-errors"></div>
									        </div>
									        <div class="form-group">
									            <label for="zipCode">Zip Code:</label>
									            <input type="text" id="zipCode" name="zipCode" class="form-control" required>
									            <div class="help-block with-errors"></div>
									        </div>
									        <div class="form-group">
									            <label for="country">Country:</label>
									            <input type="text" id="country" name="country" class="form-control" required>
									            <div class="help-block with-errors"></div>
									        </div>
									        <div class="form-group">
									            <label for="phone">Phone:</label>
									            <input type="text" id="phone" name="phone" class="form-control" required>
									            <div class="help-block with-errors"></div>
									        </div>
									        <div class="submit-button text-center">
									            <button class="btn hvr-hover" id="submit" type="submit">Add Address</button>
									            <div id="msgSubmit" class="h3 text-center hidden"></div>
									            <div class="clearfix"></div>
									        </div>
									    </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    <!-- End My Account -->

    <%@include file="includes/footer.jsp" %>
    <script>
        function toggleAddressForm() {
            // Your logic to toggle the address form visibility goes here
            // For instance, you can show/hide the form using JavaScript
            // Example:
            var addressForm = document.getElementById('addressForm'); // Replace 'addressForm' with the actual ID of your form
            if (addressForm.style.display === 'none') {
                addressForm.style.display = 'block';
            } else {
                addressForm.style.display = 'none';
            }
        }
    </script>
</body>

</html>
