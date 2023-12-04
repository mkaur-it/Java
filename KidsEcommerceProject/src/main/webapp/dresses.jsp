<%@page import="com.kidsEcommerceProject.connection.DbCon" %>
<%@page import="com.kidsEcommerceProject.DAO.ProductDao" %>
<%@page import="com.kidsEcommerceProject.model.*" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%
	    ProductDao pd = new ProductDao(DbCon.getConnection());
	    
	    // Retrieve all products
	    List<Products> allProducts = pd.getAllSaleProducts();
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
<title>Sale - KidsShop ECommerce Store</title>
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
                        <li class="breadcrumb-item active">Dresses</li>
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
                        <h1>End of Season Sale</h1>
						<p>Discover incredible deals on trendy kids' clothing at KidsShop! Explore our specially curated collection of sale items from renowned designer brands. From stylish outfits to comfortable essentials, our sale range offers an extensive selection of clothing that combines fashion, comfort, and affordability. Elevate your kids' wardrobe with our discounted collection and let them embrace style with confidence!</p>
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