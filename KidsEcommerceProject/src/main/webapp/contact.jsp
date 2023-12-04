
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Contact - KidsShop ECommerce Store</title>
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
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active">Contact - KidsShop ECommerce Store</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->
		<!-- Start Contact Us -->
		<div class="contact-box-main">
		    <div class="container">
		        <div class="row">
		            <div class="col-lg-8 col-sm-12">
		            <!-- Display info message -->
					<% if (request.getAttribute("infoMessage") != null) { %>
					<div class="info-message center-text">
						<i class="fas fa-info-circle"><%= request.getAttribute("infoMessage") %></i>
					    
					</div>
					<% } %>
		                <div class="contact-form-right">
		                    <h2>GET IN TOUCH</h2>
		                    <!-- Form to submit contact details -->
		                    <form action="submit-contact" method="post">
		                        <div class="row">
		                            <!-- Input fields -->
		                            <div class="col-md-12">
		                                <div class="form-group">
		                                    <input type="text" class="form-control" id="name" name="name" placeholder="Your Name" required>
		                                </div>
		                            </div>
		                            <div class="col-md-12">
		                                <div class="form-group">
		                                    <input type="email" placeholder="Your Email" id="email" class="form-control" name="email" required>
		                                </div>
		                            </div>
		                            <div class="col-md-12">
		                                <div class="form-group">
		                                    <input type="text" class="form-control" id="subject" name="subject" placeholder="Subject" required>
		                                </div>
		                            </div>
		                            <div class="col-md-12">
		                                <div class="form-group">
		                                    <textarea class="form-control" id="message" name="message" placeholder="Your Message" rows="4" required></textarea>
		                                </div>
		                                <div class="submit-button text-center">
		                                    <button class="btn hvr-hover" type="submit">Send Message</button>
		                                </div>
		                            </div>
		                        </div>
		                    </form>
		                </div>
		            </div>
		            <div class="col-lg-4 col-sm-12">
				    <div class="contact-info-left">
				        <h2>CONTACT INFO</h2>
				        <p>We are here to assist you. Please feel free to reach out to us for any inquiries or assistance.</p>
				        <ul>
				            <li>
				                <p><i class="fas fa-map-marker-alt"></i>Address: 1234 Main Street,<br>City, ON AB01 0A9</p>
				            </li>
				            <li>
				                <p><i class="fas fa-phone-square"></i>Phone: <a href="tel:+1-1234567890">+1-123 456 7890</a></p>
				            </li>
				            <li>
				                <p><i class="fas fa-envelope"></i>Email: <a href="mailto:contactinfo@gmail.com">contactinfo@example.com</a></p>
				            </li>
				        </ul>
				        <p><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14463.397044610032!2d-79.38318417666296!3d43.65322552973623!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zNDPCsDEwJzE1LjIiTiA3M8KwMTgnMzcuMSJX!5e0!3m2!1sen!2sus!4v1561555858574!5m2!1sen!2sus" width="100%" height="150" frameborder="0" style="border:0" allowfullscreen></iframe>
				    </p>
				    </div>
				</div>
		    </div>
		</div>
		<!-- End Contact Us -->

 <%@include file = "includes/footer.jsp"%>
</body>
</html>