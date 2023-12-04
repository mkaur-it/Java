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