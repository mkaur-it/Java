<%@page import="com.kidsEcommerceProject.connection.DbCon" %>
<%@page import="com.kidsEcommerceProject.DAO.ProductDao" %>
<%@page import="com.kidsEcommerceProject.model.*" %>
<%@page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%
	    ProductDao pd = new ProductDao(DbCon.getConnection());
	    
	    // Retrieve all products
	    List<Products> allProducts = pd.getAllProducts();
	    request.setAttribute("allProducts", allProducts);
	    
	    // Retrieve gift sets
	    List<Products> giftSets = pd.getGiftSetProducts();
	    request.setAttribute("giftSets", giftSets);
	    
	    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	    if (cart_list != null) {
	        request.setAttribute("cart_list", cart_list);
	    }
	%>

<!DOCTYPE html>
<html lang="en">
<!-- Basic -->

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Site Meta -->
    <title>KidsShop - ECommerce Store</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">
	<%@include file = "includes/header.jsp"%>
    

</head>

<body>
    <%@include file = "includes/navbar.jsp"%>
    <!-- Start Slider -->
    <div id="slides-shop" class="cover-slides">
        <ul class="slides-container">
            <li class="text-center">
                <img src="images/banner-01.jpg" alt="">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="m-b-20"><strong>Welcome To <br> KidsShop</strong></h1>
                            <p class="m-b-40">Discover Comfort and Magical Moments in Every Stitch</p><p><a class="btn hvr-hover" href="#">Shop New</a></p>
                        </div>
                    </div>
                </div>
            </li>
            <li class="text-center">
                <img src="images/banner-02.jpg" alt="">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="m-b-20"><strong>Welcome To <br> KidsShop</strong></h1>
                            <p class="m-b-40">Discover Style, Durability, Comfort, and Class for Your Growing Ones</p>
                            <p><a class="btn hvr-hover" href="#">Shop New</a></p>
                        </div>
                    </div>
                </div>
            </li>
            <li class="text-center">
                <img src="images/banner-03.jpg" alt="">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="m-b-20"><strong>Welcome To <br> KidsShop</strong></h1>
							<p class="m-b-40">Elevate Celebrations with Our Stunning Special Occasion Dresses & Delightful Gift Sets</p>
							<p><a class="btn hvr-hover" href="#">Explore Now</a></p>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
        <div class="slides-navigation">
            <a href="#" class="next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
            <a href="#" class="prev"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
        </div>
    </div>
    <!-- End Slider -->

    <!-- Start Categories  -->
    <div class="categories-shop">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <div class="shop-cat-box">
                    <img class="img-fluid" src="images/categories_img_01.jpg" alt="Stunning Special Occasion Wear" />
                    <a class="btn hvr-hover" href="#">Stunning Special Occasion Wear</a>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <div class="shop-cat-box">
                    <img class="img-fluid" src="images/categories_img_02.jpg" alt="Active Wear" />
                    <a class="btn hvr-hover" href="#">Explore Active Wear</a>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <div class="shop-cat-box">
                    <img class="img-fluid" src="images/categories_img_03.jpg" alt="Kids Posing" />
                    <a class="btn hvr-hover" href="#">Casual Charm for Kids</a>
                </div>
            </div>
        </div>
    </div>
</div>

    <!-- End Categories -->
	
	<div class="box-add-products">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-12">
					<div class="offer-box-products">
						<a href="gift-sets.jsp"><img class="img-fluid" src="images/add-img-01.jpg" alt="Gift Sets" /></a>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-12">
					<div class="offer-box-products">
						<img class="img-fluid" src="images/add-img-02.jpg" alt="Girls Dresses" />
					</div>
				</div>
			</div>
		</div>
	</div>

   <!-- Start Products -->
	<div class="products-box">
	    <div class="container">
	        <div class="row">
	            <div class="col-lg-12">
	                <div class="title-all text-center">
	                    <h1>Best Sellers</h1>
	                    <p>Welcome to KidsShop, your destination for trendy kids' clothing from top designer brands. Explore our latest collection offering comfort and style for your little ones. Discover a wide range of clothing designed to make your kids feel confident and fashionable.</p>
	                </div>
	            </div>
	        </div>
	        <div class="row special-list">
	            <%
	            if (!allProducts.isEmpty()) {
	                for (Products p : allProducts) {
	                    %>
	                    <div class="col-lg-3 col-md-6 special-grid best-seller">
	                        <div class="products-single fix">
	                            <div class="box-img-hover">
	                                <div class="type-lb">
	                                    <% 
	                                    Double salePrice = p.getSalePrice();
	                                    if (salePrice != null && salePrice != 0.0) { 
	                                        %>
	                                        <p class="sale">Sale</p>
	                                    <% } else { %>
	                                        <p class="new">New</p>
	                                    <% } %>
	                                </div>
	                                <img src="images/<%= p.getMainImage() %>" class="img-fluid" alt="<%= p.getProductName() %>">
	                                <div class="mask-icon">
	                                    <ul>
	                                        <li><a href="product-detail.jsp?id=<%= p.getProductID() %>" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
	                                        <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
	                                    </ul>
	                                    <a class="cart" href="add-to-cart?id=<%= p.getProductID() %>">Add to Cart</a>
	                                </div>
	                            </div>
	                            <div class="why-text">
	                                <h4><%= p.getProductName() %></h4>
	                                <%
	                                if (salePrice != null && salePrice != 0.0) { 
	                                    %>
	                                    <del>$ <%= p.getPrice() %></del>
	                                    <h5> <span class="sale">$ <%= p.getSalePrice() %></span></h5>
	                                <% } else { %>
	                                    <h5><span class="non-sale">$<%= p.getPrice() %></span></h5>
	                                <% } %>
	                            </div>
	                        </div>
	                    </div>
	                    <%
	                }
	            }
	            %>
	        </div>
	    </div>
	</div>
	<!-- End Products -->


	<!-- Start Best Products Feed -->
	<div class="bestproducts">
	    <div class="main-instagram owl-carousel owl-theme">
	    <%
			if(!giftSets.isEmpty()){
				for(Products p: giftSets){
					
			%>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="images/<%= p.getMainImage() %>" alt="<%= p.getProductName() %>" />
                    <div class="hov-in">
                       <a href="product-detail.jsp?id=<%= p.getProductID() %>"><i class="fas fa-eye"></i></a>
                    </div>
                </div>
            </div>
           <%
				}
			}
		%>
        </div>
    </div>
    <!-- End Best Products Feed -->
	
   
   <%@include file = "includes/footer.jsp"%>
</body>

</html>