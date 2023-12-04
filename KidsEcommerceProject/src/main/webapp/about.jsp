
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>About KidsShop</title>
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
                        <li class="breadcrumb-item active">About KidsShop</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->
    <!-- Start About Page  -->
    <div class="about-box-main">
        <div class="container">
            <div class="row">
				<div class="col-lg-6">
                    <div class="banner-frame"> <img class="img-fluid" src="images/about-img.jpg" alt="" />
                    </div>
                </div>
                <div class="col-lg-6">
                    <h2 class="noo-sh-title-top">We are <span>KidsShop</span></h2>
						<p>At KidsShop, we're passionate about crafting an exceptional shopping experience for both kids and parents alike. Our aim is to infuse fun and style into children's wardrobes by offering a diverse range of trendy and comfortable clothing.</p>
						<p>From playful everyday wear to stylish ensembles, our collection caters to every occasion and preference. We prioritize quality, ensuring each piece is not just fashionable but also durable, making kids feel confident and parents feel assured.Embrace the joy of shopping at KidsShop, where discovering the perfect outfit for your little ones is a delightful journey. Explore our curated selection and witness the fusion of fashion, comfort, and affordability in every garment.</p>
						<p>Our commitment extends beyond clothing; we strive to inspire confidence and creativity in children. We believe that every outfit should reflect their unique personality, allowing them to express themselves effortlessly.</p>
						<a class="btn hvr-hover" href="#">Read More</a>
					</div>
            </div>
			<div class="row my-5">
		    <div class="col-sm-6 col-lg-4">
		        <div class="service-block-inner">
		            <h3><i class="fas fa-lock"></i> 100% Secure Shopping</h3>
		            <p>Shop with confidence! We prioritize the security of your transactions to ensure a safe shopping experience.</p>
		        </div>
		    </div>
		    <div class="col-sm-6 col-lg-4">
		        <div class="service-block-inner">
		            <h3><i class="fas fa-reply"></i> Easy Returns</h3>
		            <p>We value your satisfaction. Our hassle-free return policy ensures a smooth process for returns and exchanges.</p>
		        </div>
		    </div>
		    <div class="col-sm-6 col-lg-4">
		        <div class="service-block-inner">
		            <h3><i class="fas fa-truck"></i> Free Delivery</h3>
		            <p>Enjoy the convenience of free delivery on all orders, ensuring your purchases reach you without additional costs.</p>
		        </div>
		    </div>
		</div>
    
            </div>
        </div>
    <!-- End About Page -->
 <%@include file = "includes/footer.jsp"%>
</body>
</html>