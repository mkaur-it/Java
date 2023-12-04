<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login/Register - KidsShop ECommerce Store</title>
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
                        <li class="breadcrumb-item active">User Login</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->
<div class="container">
    <div class="row new-account-login">
        <!-- User Login Form -->
        <div class="col-sm-6 col-lg-6 mb-3 mt-3">
            <div class="title-left">
                <h3>Account Login</h3>
            </div>
            <h5><a data-toggle="collapse" href="#formLogin" role="button" aria-expanded="true">Click here to Login</a></h5>
          <form action="user-login" method="post" class="mt-3 review-form-box" id="formLogin">
			    <div class="form-row">
					<div class="form-group col-md-6">
					    <label for="InputEmail" class="mb-0">Email Address</label>
					    <div class="input-group">
					        <div class="input-group-prepend">
					            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
					        </div>
					        <input type="email" class="form-control" id="InputEmail" name="InputEmail" placeholder="Enter Email">
					    </div>
					</div>
					<div class="form-group col-md-6">
					    <label for="InputPassword" class="mb-0">Password</label>
					    <div class="input-group">
					        <div class="input-group-prepend">
					            <span class="input-group-text"><i class="fas fa-lock"></i></span>
					        </div>
					        <input type="password" class="form-control" id="InputPassword" name="InputPassword" placeholder="Password">
					    </div>
					</div>
			    </div>
			    <button type="submit" class="btn hvr-hover"><i class="fas fa-sign-in-alt"></i> Login</button>
			</form>
			<%-- Display the error message if login fails --%>
		    <% String loginFailedMessage = (String) request.getAttribute("loginFailedMessage"); %>
		    <% if (loginFailedMessage != null && !loginFailedMessage.isEmpty()) { %>
		    <div class="alert alert-danger" role="alert">
		        <%= loginFailedMessage %>
		    </div>
		    <% } %>
						

        </div>
        <!-- User Registration Form -->
        <div class="col-sm-6 col-lg-6 mb-3 mt-3">
            <div class="title-left">
                <h3>Create New Account</h3>
            </div>
            <h5><a data-toggle="collapse" href="#formRegister" role="button" aria-expanded="false">Click here to Register</a></h5>
            <form action="register" method="post" class="mt-3 collapse show review-form-box" id="formRegister">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="InputName" class="mb-0">First Name</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="InputName" name="InputName" placeholder="First Name">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="InputLastname" class="mb-0">Last Name</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="InputLastname" name="InputLastname" placeholder="Last Name">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="InputEmail1" class="mb-0">Email Address</label>
                            <div class="input-group">
                                <input type="email" class="form-control" id="InputEmail1" name="InputEmail1" placeholder="Enter Email">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="InputPhone" class="mb-0">Phone Number</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="InputPhone" name="InputPhone" placeholder="Phone Number">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="InputPassword1" class="mb-0">Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="InputPassword1" name="InputPassword1" placeholder="Password">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="InputPasswordConfirm" class="mb-0">Retype Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="InputPasswordConfirm" name="InputPasswordConfirm" placeholder="Retype Password">
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn hvr-hover"><i class="fas fa-user-plus"></i> Register</button>
                </form>
                <%-- Display the error message if registration fails --%>
                <% String registrationFailedMessage = (String) request.getAttribute("registrationFailedMessage"); %>
                <% if (registrationFailedMessage != null && !registrationFailedMessage.isEmpty()) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= registrationFailedMessage %>
                    </div>
                <% } %>
                <%-- Display the success message if registration is successful --%>
				<% String registrationSuccessMessage = (String) request.getAttribute("registrationSuccessMessage"); %>
				<% if (registrationSuccessMessage != null && !registrationSuccessMessage.isEmpty()) { %>
                    <div class="alert alert-success" role="alert">
                        <%= registrationSuccessMessage %>
                    </div>
                <% } %>
        </div>
    </div>
</div>
 <%@include file = "includes/footer.jsp"%>
 <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Retrieve the loginFailedMessage from the server-side
        var loginFailedMessage = '<%= loginFailedMessage %>';

        if (loginFailedMessage != null && loginFailedMessage.trim() !== '') {
            // There is a login failure message from the server-side
            // Display the error message
            var errorDiv = document.createElement('div');
            errorDiv.className = 'alert alert-danger';
            errorDiv.setAttribute('role', 'alert');
            errorDiv.textContent = loginFailedMessage;

            var formLogin = document.getElementById('formLogin');
            formLogin.parentNode.insertBefore(errorDiv, formLogin.nextSibling);

            // Add red border to email and password inputs
            document.getElementById('InputEmail').style.border = '1px solid red';
            document.getElementById('InputPassword').style.border = '1px solid red';

            // Set focus on the email input
            document.getElementById('InputEmail').focus();
            console.log("Login failed message is not null or empty.");
        } else {
            // Login failed message is null, empty, or whitespace
            // Remove any error message displayed previously
            var errorAlert = document.querySelector('.alert.alert-danger');
            if (errorAlert) {
                errorAlert.remove();
            }

            // Remove red border from email and password inputs
            document.getElementById('InputEmail').style.border = 'none';
            document.getElementById('InputPassword').style.border = 'none';
            console.log("This none section got executed.");
        }
    });
<script src="js/loginValidation.js"></script>
<script>document.addEventListener('DOMContentLoaded', function() {
    // Retrieve the registrationSuccessMessage from the server-side
    var registrationSuccessMessage = '<%= registrationSuccessMessage %>';

    if (registrationSuccessMessage != null && registrationSuccessMessage.trim() !== '' registrationSuccessMessage != '<%= registrationSuccessMessage %>') {
        // There is a registration success message from the server-side
        // Display the success message
        var successDiv = document.createElement('div');
        successDiv.className = 'alert alert-success';
        successDiv.setAttribute('role', 'alert');
        successDiv.textContent = registrationSuccessMessage;

        var formRegister = document.getElementById('formRegister');
        formRegister.parentNode.insertBefore(successDiv, formRegister.nextSibling);

        // Clear registration form fields on successful registration
        formRegister.reset();

        // Set focus on the login email input
        document.getElementById('InputEmail').focus();
        console.log("Registration success message is not null or empty.");
    } 
});
</script>
<script src="js/matchPassword.js"></script>


 
</body>
</html>