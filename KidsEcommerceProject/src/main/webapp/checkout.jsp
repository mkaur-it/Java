<%@page import="com.kidsEcommerceProject.connection.DbCon" %>
<%@page import="com.kidsEcommerceProject.DAO.ProductDao" %>
<%@page import="com.kidsEcommerceProject.DAO.UserDao" %>
<%@page import="com.kidsEcommerceProject.model.*" %>
<%@page import="com.kidsEcommerceProject.model.Users"%>
<%@page import="com.kidsEcommerceProject.model.Address"%>
<%@page import="com.kidsEcommerceProject.model.CartItemsList"%>
<%@ page import="java.text.DecimalFormat" %>

<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%
    ProductDao pd = new ProductDao(DbCon.getConnection());
    UserDao userDao = new UserDao(DbCon.getConnection());
    int userID = 0; // Initialize userID variable
    Double finalCart = 0.0;
    DecimalFormat dcf = new DecimalFormat("#.##"); // Define DecimalFormat as needed

    // Check if the user is logged in
    if (session != null && session.getAttribute("userID") != null) {
        // User is logged in
        userID = (int) session.getAttribute("userID");
        // Further processing with userID to retrieve user details
        Users user = userDao.getUserDetailsByID(userID);
        if (user != null) {
            // Set the user object in the request attribute
            request.setAttribute("user", user);
        }
    } else {
        // User is not logged in, redirect to the login page with a return URL
        String returnURL = "checkout.jsp"; // URL of the current page
        response.sendRedirect("login.jsp?return=" + returnURL);
        return; // To prevent further execution of the page
    }


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout - KidsShop ECommerce Store</title>
<%@include file = "includes/header.jsp"%>
<script>
    function calculateShippingCost() {
    	console.log('Inside calculateShippingCost function');
        var shippingCost = 0.0; // Initialize shipping cost
        
        // Retrieve the selected shipping option
        var selectedShipping = document.querySelector('input[name="shipping-option"]:checked');
        
        // Calculate the shipping cost based on the selected option
        if (selectedShipping) {
            var shippingOption = selectedShipping.id;
            if (shippingOption === "shippingOption1") {
                shippingCost = 0.0; // Standard Delivery - Free
            } else if (shippingOption === "shippingOption2") {
                shippingCost = 10.00; // Express Delivery - $10.00
            } else if (shippingOption === "shippingOption3") {
                shippingCost = 20.00; // Next Business day - $20.00
            }
        }
        
     // Display the shipping cost in the HTML element with id "shipping-cost"
        document.getElementById("shipping-cost").innerText = "$ " + shippingCost.toFixed(2);

        // Retrieve the subtotal value from the HTML element
        var subTotalText = document.getElementById("subTotal").innerText.trim(); // Get the text content
        var subTotalValue = parseFloat(subTotalText.replace("$", "")); // Extract the numerical value
        
        // Check if the extracted subtotal value is a valid number
        if (!isNaN(subTotalValue)) {
            var taxRate = 0.13; // Tax rate

            // Calculate total including shipping cost and tax
            var grandTotal = (subTotalValue + shippingCost) * (1 + taxRate);

            // Display the grand total in the HTML element with id "grand-total"
            document.getElementById("grand-total").innerText = "$ " + grandTotal.toFixed(2);
        } else {
            console.error("Subtotal value is not a valid number:", subTotalText);
        }
    }
</script>  
  
</head>
<body>
 <%@include file = "includes/navbar.jsp"%>
<!-- Start All Title Box -->
    <div class="all-title-box">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active">Checkout</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->
   <!-- Start Cart  -->
   <form action="place-order" class="needs-validation" novalidate method="post">
    <div class="cart-box-main">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-lg-6 mb-3">
                    <div class="checkout-address">
                        <div class="title-left">
                            <h3>Billing address</h3>
                        </div>
                         <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="firstName">First name *</label>
                                    <input type="hidden" name="userID" value="<%= ((Users)request.getAttribute("user")).getId() %>">
                                	
                                    <input type="text" class="form-control" id="firstName" placeholder="" value="<%= ((Users)request.getAttribute("user")).getFirstName() %>" required>
                                    <div class="invalid-feedback"> Valid first name is required. </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="lastName">Last name *</label>
                                    <input type="text" class="form-control" id="lastName" placeholder="" value="<%= ((Users)request.getAttribute("user")).getLastName() %>"required>
                                    <div class="invalid-feedback"> Valid last name is required. </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="email">Email Address *</label>
                                <input type="email" class="form-control" id="email" placeholder="" value="<%= ((Users)request.getAttribute("user")).getEmail() %>">
                                <div class="invalid-feedback"> Please enter a valid email address for shipping updates. </div>
                            </div>
                             <select class="form-control" id="address" required onchange="populateForm()">
							    <!-- Add options dynamically based on user's addresses -->
							    <!-- Options will trigger the populateForm function on change -->
							    <option value="">Select Address</option> <!-- Placeholder option -->
							    <% 
							        // Get the user object from request attribute
							        Users user = (Users) request.getAttribute("user");
							        List<Address> addresses = user.getAddresses(); // Get the list of addresses
							
							        // Iterate through the addresses to create options
							        for (Address address : addresses) { 
							    %>
							        <option value="<%= address.getAddressID() %>">
							            <%= address.getAddressLine1() %>, <%= address.getCity() %>, <%= address.getCountry() %>
							        </option>
							    <% 
							        } // Closing brace for the for loop
							    %>
							</select>

                            <hr class="mb-4">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="same-address">
                                <label class="custom-control-label" for="same-address">Shipping address is the same as my billing address</label>
                            </div>
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="save-info">
                                <label class="custom-control-label" for="save-info">Save this information for next time</label>
                            </div>
                            <hr class="mb-4">
                            <div class="title"> <span>Payment</span> </div>
                            <div class="d-block my-3">
                                <div class="custom-control custom-radio">
                                    <input id="credit" name="paymentMethod" value="credit" type="radio" class="custom-control-input" checked required>
                                    <label class="custom-control-label" for="credit">Credit card</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input id="debit" name="paymentMethod" value="dredit" type="radio" class="custom-control-input" required>
                                    <label class="custom-control-label" for="debit">Debit card</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input id="paypal" name="paymentMethod" value="Paypal" type="radio" class="custom-control-input" required>
                                    <label class="custom-control-label" for="paypal">Paypal</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="cc-name">Name on card</label>
                                    <input type="text" class="form-control" id="cc-name" placeholder="" required> <small class="text-muted">Full name as displayed on card</small>
                                    <div class="invalid-feedback"> Name on card is required </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="cc-number">Credit card number</label>
                                    <input type="text" class="form-control" id="cc-number" placeholder="" required>
                                    <div class="invalid-feedback"> Credit card number is required </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label for="cc-expiration">Expiration</label>
                                    <input type="text" class="form-control" id="cc-expiration" placeholder="" required>
                                    <div class="invalid-feedback"> Expiration date required </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label for="cc-expiration">CVV</label>
                                    <input type="text" class="form-control" id="cc-cvv" placeholder="" required>
                                    <div class="invalid-feedback"> Security code required </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="payment-icon">
                                        <ul>
                                            <li><img class="img-fluid" src="images/payment-icon/1.png" alt=""></li>
                                            <li><img class="img-fluid" src="images/payment-icon/2.png" alt=""></li>
                                            <li><img class="img-fluid" src="images/payment-icon/3.png" alt=""></li>
                                            <li><img class="img-fluid" src="images/payment-icon/5.png" alt=""></li>
                                            <li><img class="img-fluid" src="images/payment-icon/7.png" alt=""></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <hr class="mb-1">
                    </div>
                </div>
                <%-- JavaScript function to capture the selected shipping method and calculate shipping cost --%>
                <div class="col-sm-6 col-lg-6 mb-3">
                    <div class="row">
                        <div class="col-md-12 col-lg-12">
                            <div class="shipping-method-box">
                                <div class="title-left">
                                    <h3>Shipping Method</h3>
                                </div>
                                <div class="mb-4">
                                    <div class="custom-control custom-radio">
                                        <input id="shippingOption1" name="shipping-option" class="custom-control-input" checked="checked" type="radio" onchange="calculateShippingCost()">
                                        <label class="custom-control-label" for="shippingOption1">Standard Delivery</label> <span class="float-right font-weight-bold">FREE</span> </div>
                                    <div class="ml-4 mb-2 small">(3-7 business days)</div>
                                    <div class="custom-control custom-radio">
                                        <input id="shippingOption2" name="shipping-option" class="custom-control-input" type="radio" onchange="calculateShippingCost()">
                                        <label class="custom-control-label" for="shippingOption2">Express Delivery</label> <span class="float-right font-weight-bold">$10.00</span> </div>
                                    <div class="ml-4 mb-2 small">(2-4 business days)</div>
                                    <div class="custom-control custom-radio">
                                        <input id="shippingOption3" name="shipping-option" class="custom-control-input" type="radio" onchange="calculateShippingCost()">
                                        <label class="custom-control-label" for="shippingOption3">Next Business day</label> <span class="float-right font-weight-bold">$20.00</span> </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 col-lg-12">
					    <div class="odr-box">
					        <div class="title-left">
					            <h3>Shopping cart</h3>
					        </div>
					        <div class="rounded p-2 bg-light">
					            <% 
					                // Retrieve cart items from the request attribute
					                ArrayList<Cart> cartItems = (ArrayList<Cart>) request.getAttribute("cart_list");
                                    CartItemsList cartItemsList = new CartItemsList();
					
					                // Check if the cart is not empty and proceed to display cart items
					                if (cartItems != null && !cartItems.isEmpty()) {
					                    // Iterate through the cart items
					                    
					                    for (Cart cartItem : cartItems) { 
					                    	// Add items from cartItems to CartItemsList using static access
										    
										    CartItemsList.addItem(
										    		cartItem.getProductId(),
											        cartItem.getProductName(),
											        cartItem.getPrice(),
											        cartItem.getSalePrice(),
											        cartItem.getQuantity(),
											        cartItem.getMainImage()
											    );
								            %>
								                <div class="media mb-2 border-bottom">
								                    <div class="media-body">
								                        <a href="product-detail.jsp?id=<%= cartItem.getProductID() %>">
								                            <img src="images/<%= cartItem.getMainImage() %>" alt="" width="50" height="50" />
								                        </a>
								                        <a href="product-detail.jsp?id=<%= cartItem.getProductID() %>"> <%= cartItem.getProductName() %> </a>
								                        <div class="small text-muted">
								                            Price: $<%= cartItem.getPrice() %> 
								                            <span class="mx-2">|</span> 
								                            Qty: <%= cartItem.getQuantity() %> 
								                            <span class="mx-2">|</span> 
								                            Subtotal: $<%= cartItem.getQuantity() * cartItem.getPrice() %>
								                           <% finalCart  += cartItem.getPrice() * cartItem.getQuantity(); %>
								                        </div>
								                    </div>
								                </div>
												            <% 
												    
												        
												 // Print the details of the added item to the console (optional)
							                        System.out.println("Added item:");
							                        System.out.println("---------------------------------");
				 								}
					                    } // Closing brace for the for loop
					                     else {
					            %>
					                <div class="media mb-2 border-bottom">
					                    <div class="media-body">
					                        Your cart is empty.
					                    </div>
					                </div>
					            <% 
					                } // Closing brace for the if condition
					                
					            %>
					        </div>
					    </div>
					</div>


                        <div class="col-md-12 col-lg-12">
                            <div class="order-box">
                                <div class="title-left">
                                    <h3>Your order</h3>
                                </div>
                                <div class="d-flex">
                                    <div class="font-weight-bold">Product</div>
                                    <div class="ml-auto font-weight-bold">Total</div>
                                </div>
                                <hr class="my-1">
                                <div class="d-flex">
                                    <h4>Sub Total</h4>
                                    <div class="ml-auto font-weight-bold" id="subTotal"> $ <%= (finalCart > 0) ? dcf.format(finalCart) : "0" %> </div>
                                </div>
                               
                                <hr class="my-1">
                                
                                <div class="d-flex">
                                    <h4>Tax</h4>
                                    <div class="ml-auto font-weight-bold"> 13% </div>
                                </div>
                                <div class="d-flex">
                                    <h4>Shipping Cost</h4>
                                    <div class="ml-auto font-weight-bold" id="shipping-cost"> Free </div>
                                </div>
                                <hr>
                                <div class="d-flex gr-total">
                                    <h5>Grand Total</h5>
                                     <%  double allincTotal = finalCart * 1.13; // Adding 13% %>
                                    <div class="ml-auto h5" id="grand-total"> $ <%= (allincTotal > 0) ? dcf.format(allincTotal) : "0" %></div>
                                	<input type="hidden" name="totalAmount" value="<%= (allincTotal > 0) ? dcf.format(allincTotal) : "0" %>">
                                	
                                </div>
                                <hr> </div>
                                
                                <div class="col-12 d-flex shopping-box">				    
									<button type="submit" class="ml-auto btn hvr-hover">Place Order</button>
								</div>
                        </div>                       
                  </div>
             </div>
         </div>
     </div>
   </form> 
    <!-- End Cart -->
<%@include file="includes/footer.jsp" %> 
 
</body>
</html>