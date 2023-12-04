<%@page import="com.kidsEcommerceProject.connection.DbCon" %>
<%@ page import="com.kidsEcommerceProject.DAO.ProductDao" %>
<%@page import="com.kidsEcommerceProject.model.*" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
		    
<%-- Retrieve cart_list from session and set it in request --%>
<%		Double totalCartPrice = 0.0;
		HttpSession existingSession  = request.getSession(true); // This line creates or retrieves the session
		ArrayList<Cart> cart_list_session = (ArrayList<Cart>) existingSession.getAttribute("cart-list");
		    if (cart_list_session != null) {
		        request.setAttribute("cart_list", cart_list_session);
		    }
%>
		
<!-- Start Main Top -->
    <div class="main-top">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
					<div class="custom-select-box">
                        <select id="basic" class="selectpicker show-tick form-control" data-placeholder="$ USD">
							<option>$ CAD</option>
						</select>
                    </div>
                    <div class="right-phone-box">
                        <p><a class="fas fa-phone-alt" href="#"> +1 987 654 3210</a></p>
                    </div>
                    <div class="our-link">
                        <ul>
                            <li><a href="contact.jsp"><i class="fas fa-location-arrow"></i> Our location</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
				   <div class="login-box">
				    <% 
				        Object authObj = session.getAttribute("auth");
				        if(authObj != null) {
				            com.kidsEcommerceProject.model.Users user = (com.kidsEcommerceProject.model.Users) authObj;
				    %>
				            <div class="d-flex align-items-center">
				                <span class="mr-3"><i class="fas fa-user"></i> Welcome <%= user.getFirstName() %> <%= user.getLastName() %> </span>
				                <a href="log-out"><i class="fas fa-sign-out-alt"></i> Logout</a>
				            </div>
				    <%
				        } else {
				    %>
				            <a href="login.jsp"><i id="basic" class="fa fa-user"></i> Login/Register</a>
				    <%
				        }
				    %>
				  </div>




                    <div class="text-slid-box">
                        <div id="offer-box" class="carouselTicker">
						   <ul class="offer-box">
							    <li>
							        <i class="fas fa-truck"></i>Free Delivery on All Orders above $50
							    </li>
							    <li>
							        <i class="far fa-envelope"></i>Register for our Newsletter to receive the latest offers!
							    </li>
							    <li>
							        <i class="fas fa-tag"></i>End of the Season Sale now On !!!
							    </li>
						   </ul>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Main Top -->

    <!-- Start Main Top -->
    <header class="main-header">
        <!-- Start Navigation -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
            <div class="container">
                <!-- Start Header Navigation -->
                <div class="navbar-header">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fa fa-bars"></i>
                </button>
                    <a class="navbar-brand" href="index.jsp"><img src="images/logo.png" class="logo" alt=""></a>
                </div>
                <!-- End Header Navigation -->

                <!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="navbar-menu">
				    <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
				        <li class="nav-item active"><a class="nav-link" href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
				        <li class="nav-item"><a class="nav-link" href="new-in.jsp"><i class="fas fa-plus-circle"></i> New In</a></li>
				        <li class="dropdown">
				            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
				            <i class="fas fa-shopping-cart"></i> SHOP <i class="fas fa-angle-down"></i></a>
				            <ul class="dropdown-menu">
				                <li><a href="boys.jsp"><i class="fas fa-male"></i> Boys</a></li>
				                <li><a href="girls.jsp"><i class="fas fa-female"></i> Girls</a></li>
				                <li><a href="gift-sets.jsp"><i class="fas fa-gift"></i> Gift Sets</a></li>
				                <li><a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a></li>
				                <li><a href="checkout.jsp"><i class="fas fa-credit-card"></i> Checkout</a></li>
				                <li><a href="my-account.jsp"><i class="fas fa-user"></i> My Account</a></li>
				            </ul>
				        </li>
				        <li class="nav-item"><a class="nav-link" href="sale.jsp"><i class="fas fa-tags"></i> Sale</a></li>
				        <li class="nav-item"><a class="nav-link" href="about.jsp"><i class="fas fa-info-circle"></i> About</a></li>
				        <li class="nav-item"><a class="nav-link" href="contact.jsp"><i class="fas fa-envelope"></i> Contact</a></li>
				    </ul>
				</div>
				<!-- /.navbar-collapse -->

                <!-- Start Search and Cart Navigation -->
                <div class="attr-nav">
                    <ul>
                        <li class="search"><a href="#"><i class="fa fa-search"></i></a></li>
                        <li class="side-menu">
						    <a href="#">
						        <i class="fas fa-cart-plus">
						            <sup class="badge badge-success">${cart_list.size() }</sup>
						        </i>
						        CART
						    </a>
						</li>


                    </ul>
                </div>
                <!-- End Search and Cart Navigation -->
            </div>
            <!-- Start Side Menu -->
			<div class="side">
			    <!-- Display cart items and total -->
			    <li class="cart-box">
			        <ul class="cart-list">
			            <% 
			                if (cart_list_session != null && !cart_list_session.isEmpty()) {
			                    totalCartPrice = 0.0; // Initialize total price
			
			                    for (Cart cartItem : cart_list_session) {
			            %>
			                    <!-- Display individual cart items -->
			                    <li>
			                        <a href="#" class="photo"><img src="images/<%= cartItem.getMainImage() %>" class="cart-thumb" alt="" /></a>
			                        <h6><a href="#"><%= cartItem.getProductName() %></a></h6>
			                        <p><%= cartItem.getQuantity() %>x - <span class="price">$ <%= cartItem.getPrice() * cartItem.getQuantity() %></span></p>
			                    </li>
			                    <% 
			                        // Calculate and accumulate the total price for each item
			                        totalCartPrice += cartItem.getPrice();
			                    }
			                }
			            %>
			            <!-- Display total cart price -->
			            <li class="total">
			                <a href="cart.jsp" class="btn btn-default hvr-hover btn-cart">VIEW CART</a>
			                <span class="float-right"><strong>Sub Total</strong>: $<%= totalCartPrice %></span>
			            </li>
			        </ul>
			    </li>
			</div>
			<!-- End Side Menu -->


        </nav>
        <!-- End Navigation -->
    </header>
    <!-- End Main Top -->

    <!-- Start Top Search -->
    <div class="top-search">
        <div class="container">
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-search"></i></span>
                <input type="text" class="form-control" placeholder="Search">
                <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
            </div>
        </div>
    </div>
    <!-- End Top Search -->
