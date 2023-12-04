document.addEventListener('DOMContentLoaded', function() {
    var formRegister = document.getElementById('formRegister');
    var password = document.getElementById('InputPassword1');
    var confirmPassword = document.getElementById('InputPasswordConfirm');

    formRegister.addEventListener('submit', function(event) {
        if (password.value !== confirmPassword.value) {
            event.preventDefault(); // Prevent form submission
            alert('Passwords do not match. Please re-enter.'); // Show an alert or error message
            // Add red borders if passwords don't match
            password.style.border = '1px solid red';
            confirmPassword.style.border = '1px solid red';
        } else {
            // Remove red borders if passwords match
            password.style.border = 'none';
            confirmPassword.style.border = 'none';
        }
    });
});
