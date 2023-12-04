<%@page import="com.kidsEcommerceProject.connection.DbCon" %>
<%@page import="com.kidsEcommerceProject.DAO.ProductDao" %>
<%@page import="com.kidsEcommerceProject.model.*" %>
<%@page import="java.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.kidsEcommerceProject.model.Cart" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

 <%-- Retrieve cart_list from session and set it in request --%>
<%
    // Retrieve cart list from the session and set it in request
    Double totalCart = 0.0;
    HttpSession cartSession = request.getSession(true);
    ArrayList<Cart> exist_cart_list_session = (ArrayList<Cart>) cartSession.getAttribute("cart-list");
    DecimalFormat dcf = new DecimalFormat("#.##"); // Define DecimalFormat as needed

    if (exist_cart_list_session != null) {
        request.setAttribute("cart_list", exist_cart_list_session);
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart - KidsShop ECommerce Store</title>
<%@include file = "includes/header.jsp"%>
</head>
<body>
<%@include file = "includes/navbar.jsp"%>
 <!-- Start All Title Box -->
    <div class="all-title-box">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">Cart</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->

    <!-- Start Cart  -->
    <div class="cart-box-main">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="table-main table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Images</th>
                                    <th>Product Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody>
							    <%
							        if (exist_cart_list_session != null && !exist_cart_list_session.isEmpty()) {
							            for (Cart cartItem : exist_cart_list_session) {
							                // Display cart item details
							        %>
          
							    <tr>
							        <td class="thumbnail-img">
							            <a href="#">
							                <img class="img-fluid" src="images/<%= cartItem.getMainImage() %>" alt="" />
							            </a>
							        </td>
							        <td class="name-pr">
							            <a href="#">
							                <%= cartItem.getProductName() %>
							            </a>
							        </td>
							        <td class="price-pr">
							            <p>$ <%= cartItem.getPrice() %></p>
							        </td>
							        <td class="quantity-box">
									    <div class="form-group d-flex align-items-center justify-content-between">
									        <a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=<%= cartItem.getProductId() %>">
									            <i class="fas fa-minus-square"></i>
									        </a>
									        <input type="text" name="quantity" class="form-control text-center" value="<%= cartItem.getQuantity() %>" readonly>
									        <a class="btn btn-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%= cartItem.getProductId() %>">
									            <i class="fas fa-plus-square"></i>
									        </a>
									    </div>
									</td>

							        <td class="total-pr">
							            <p>$ <%= cartItem.getPrice() * cartItem.getQuantity() %></p>
							        </td>
							        <td class="remove-pr">
							            <a href="remove-from-cart?id=<%= cartItem.getProductId() %>">
							                <i class="fas fa-times"></i>
							            </a>
							        </td>
							    </tr>
							    <% 
									 // Calculate total cart price
						                totalCart += cartItem.getPrice() * cartItem.getQuantity();
						            }
							    } else {
							    %>
							    <tr>
							        <td colspan="6">Cart is empty</td>
							    </tr>
							    <% 
							    }
							    %>
							</tbody>


                        </table>
                    </div>
                </div>
            </div>
            <div class="row my-5">
                <div class="col-lg-8 col-sm-12"></div>
                <div class="col-lg-4 col-sm-12">
                    <div class="order-box">
                        <h3>Order summary</h3>
                         <div class="d-flex">
					        <h4>Sub Total</h4>
					        <div class="ml-auto font-weight-bold">$ <%= (totalCart > 0) ? dcf.format(totalCart) : "0" %></div>
					    </div>
                       
                        <hr class="my-1">
                        
                        <div class="d-flex">
                            <h4>Tax</h4>
                            <div class="ml-auto font-weight-bold"> 13% </div>
                        </div>
                        <div class="d-flex">
                            <h4>Standard Shipping Cost</h4>
                            <div class="ml-auto font-weight-bold"> Free </div>
                        </div>
                        <hr>
                        <div class="d-flex gr-total">
					        <h5>Grand Total</h5>
					        <%  double grandTotal = totalCart * 1.13; // Adding 13% %>
					        <div class="ml-auto h5">$ <%= (grandTotal > 0) ? dcf.format(grandTotal) : "0" %></div>
   						</div>
					    <hr> </div>
                </div>
                <div class="col-12 d-flex shopping-box"><a href="cart-check-out" class="ml-auto btn hvr-hover">Checkout</a> </div>
            </div>

        </div>
    </div>
    <!-- End Cart -->

<%@include file ="includes/footer.jsp" %>
</body>
</html>