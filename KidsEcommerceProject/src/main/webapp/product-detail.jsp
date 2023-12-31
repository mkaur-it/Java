<%@page import="com.kidsEcommerceProject.connection.DbCon" %>
<%@page import="com.kidsEcommerceProject.DAO.ProductDao" %>
<%@page import="com.kidsEcommerceProject.model.*" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% 
    int productId = -1; // Default value if ID is not found in the URL
    if (request.getParameter("id") != null) {
        productId = Integer.parseInt(request.getParameter("id"));
    }
    System.out.println(productId); // Check to verify if the ID is correctly fetched

    if (productId != -1) {
        
        ProductDao productDao = new ProductDao(DbCon.getConnection());
        Products product = productDao.getSingleProduct(productId); // Fetch single product

        if (product != null) {
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%= product.getProductName() %></title>
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
                        <li class="breadcrumb-item active">Shop Detail / <%= product.getProductName() %></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->

    <!-- Start Shop Detail  -->
    <div class="shop-detail-box-main">
        <div class="container">
            <div class="row">
                <div class="col-xl-5 col-lg-5 col-md-6">
                    <div id="carousel-example-1" class="single-product-slider carousel slide" data-ride="carousel">
				    <div class="carousel-inner" role="listbox">
				        <div class="carousel-item active">
				            <img class="d-block w-100" src="images/<%= product.getMainImage() %>" alt="First slide">
				        </div>
				        <% if (product.getImage2() != null) { %>
				            <div class="carousel-item">
				                <img class="d-block w-100" src="images/<%= product.getImage2() %>" alt="Second slide">
				            </div>
				        <% } %>
				        <% if (product.getImage3() != null) { %>
				            <div class="carousel-item">
				                <img class="d-block w-100" src="images/<%= product.getImage3() %>" alt="Third slide">
				            </div>
				        <% } %>
				    </div>
				    <a class="carousel-control-prev" href="#carousel-example-1" role="button" data-slide="prev"> 
				        <i class="fa fa-angle-left" aria-hidden="true"></i>
				        <span class="sr-only">Previous</span> 
				    </a>
				    <a class="carousel-control-next" href="#carousel-example-1" role="button" data-slide="next"> 
				        <i class="fa fa-angle-right" aria-hidden="true"></i> 
				        <span class="sr-only">Next</span> 
				    </a><br>
				    <ol class="carousel-indicators">
				        <li data-target="#carousel-example-1" data-slide-to="0" class="active">
				            <img class="d-block w-100 img-fluid" src="images/<%= product.getMainImage() %>" alt="">
				        </li>
				       <% if (product.getImage2() != null) { %>
					    <li data-target="#carousel-example-1" data-slide-to="1">
					        <img class="d-block w-100 img-fluid" src="images/<%= product.getImage2() %>" alt="">
					    </li>
					<% } else { %>
					    <li data-target="#carousel-example-1" data-slide-to="1">
					        <img class="d-block w-100 img-fluid" src="images/placeholder.jpg" alt="Placeholder Image">
					    </li>
					<% } %>
					<% if (product.getImage3() != null) { %>
					    <li data-target="#carousel-example-1" data-slide-to="2">
					        <img class="d-block w-100 img-fluid" src="images/<%= product.getImage3() %>" alt="">
					    </li>
					<% } else { %>
					    <li data-target="#carousel-example-1" data-slide-to="2">
					        <img class="d-block w-100 img-fluid" src="images/placeholder.jpg" alt="Placeholder Image">
					    </li>
					<% } %>

				    </ol>
				</div>

                </div>
                <div class="col-xl-7 col-lg-7 col-md-6">
                    <div class="single-product-details">
                        <h2><%= product.getProductName() %></h2>
                        <% if (product.getSalePrice() == 0) { %>
					        <!-- Display only regular price when sale price is 0 -->
					        <h5>$ <%= product.getPrice() %></h5>
					    <% } else { %>
					        <!-- Display regular and sale price when sale price is not 0 -->
					        <h5><del>$ <%= product.getPrice() %></del> $ <%= product.getSalePrice() %></h5>
					    <% } %>

                        <p class="available-stock"><span> More than <%= product.getStockQuantity() %> available / <a href="#">8 sold </a></span><p>
						<h4>Short Description:</h4>
						<p><%= product.getDescription() %><ul>
							<li>
								<div class="form-group quantity-box">
									<label class="control-label">Quantity</label>
									<input class="form-control" value="1" min="1" max="20" type="number">
								</div>
							</li>
						</ul>

						<div class="price-box-bar">
							<div class="cart-and-bay-btn">
								<a class="btn hvr-hover" data-fancybox-close="" href="add-to-cart?id=<%= product.getProductID() %>">Add to cart</a>
							</div>
						</div>

						<div class="add-to-btn">
							<div class="add-comp">
								<a class="btn hvr-hover" href="#"><i class="fas fa-heart"></i> Add to Wishlist</a>
								<a class="btn hvr-hover" href="#"><i class="fas fa-sync-alt"></i> Add to Compare</a>
							</div>
							<div class="share-bar">
								<a class="btn hvr-hover" href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a>
								<a class="btn hvr-hover" href="#"><i class="fab fa-google-plus" aria-hidden="true"></i></a>
								<a class="btn hvr-hover" href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a>
								<a class="btn hvr-hover" href="#"><i class="fab fa-pinterest-p" aria-hidden="true"></i></a>
								<a class="btn hvr-hover" href="#"><i class="fab fa-whatsapp" aria-hidden="true"></i></a>
							</div>
						</div>
                    </div>
                </div>
            </div>
			<% 
                            } else { // Product not found
                    %>
                                <h2>Product Not Found</h2>
                    <% 
                            }
                        } else { // Product ID not found in session
                    %>
                            <h2>No Product ID Found</h2>
                    <% } %>
			<div class="row my-5">
				<div class="card card-outline-secondary my-4">
					<div class="card-header">
						<h2>Product Reviews</h2>
					</div>
					<div class="card-body">
						<div class="media mb-3">
							<div class="mr-2"> 
								<img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
							</div>
							<div class="media-body">
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div>
						</div>
						<hr>
						<div class="media mb-3">
							<div class="mr-2"> 
								<img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
							</div>
							<div class="media-body">
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div>
						</div>
						<hr>
						<div class="media mb-3">
							<div class="mr-2"> 
								<img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
							</div>
							<div class="media-body">
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div>
						</div>
						<hr>
						<a href="#" class="btn hvr-hover">Leave a Review</a>
					</div>
				  </div>
			</div>

        </div>
    </div>
    <!-- End Cart -->
     <%@include file = "includes/footer.jsp"%>
</body>
</html>