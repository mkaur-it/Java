<%@page import="com.kidsEcommerceProject.connection.DbCon" %>
<%@page import="com.kidsEcommerceProject.DAO.ProductDao" %>
<%@page import="com.kidsEcommerceProject.model.*" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%
	    ProductDao pd = new ProductDao(DbCon.getConnection());
	    
	    // Retrieve all products
	    List<Products> allProducts = pd.getGiftSetProducts();
	    request.setAttribute("allProducts", allProducts);
	    
	    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	    if (cart_list != null) {
	        request.setAttribute("cart_list", cart_list);
	    }
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Gift Sets - KidsShop ECommerce Store</title>
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
                        <li class="breadcrumb-item active">Gift Sets</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->
<!-- Start Products  -->
    <div class="products-box">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="title-all text-center">
                        <h1>Gift Sets</h1>
							<p>Find the perfect gift for newborns at KidsShop! Explore our delightful assortment of gift sets specially tailored for the little ones. Our collection includes charming clothing sets, cozy blankets, adorable accessories, and more, designed to welcome newborns in comfort and style. With our carefully curated selection, you can celebrate their arrival with joy and warmth.</p>
					</div>
                </div>
            </div>
            <div class="row special-list">
            <%
			if(!allProducts.isEmpty()){
				for(Products p: allProducts){
					
			%>
                <div class="col-lg-3 col-md-6 special-grid best-seller">
                    <div class="products-single fix">
                        <div class="box-img-hover">
                            <div class="type-lb">
                                <p class="sale">SALE</p>
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

							        <% Double sale = p.getSalePrice();
							        if (sale != null && sale != 0.0) { %>
							        	<del>$ <%= p.getPrice() %></del>
							            <h5><span class="sale">$ <%= p.getSalePrice() %></span></h5>
							        <% } else { %>
							            <h5><span class="non-sale">$ <%= p.getPrice() %></span></h5>
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
    <!-- End Products  -->
 <%@include file = "includes/footer.jsp"%>
</body>
</html>