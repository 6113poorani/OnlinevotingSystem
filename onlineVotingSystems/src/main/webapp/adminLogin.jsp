<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link rel="stylesheet" type="text/css" href="styles/adminloginstyle.css">
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">

<div class="login-container">
    <h2>Admin Login</h2>
    <form name="adminLoginForm" action="AdminLogin" method="post" onsubmit="return validateForm()">
        <label for="userName">Username</label>
        <input type="text" id="userName" name="userName"><br>
        <span id="usernameError" class="error-message"></span><br>

        <label for="password">Password</label>
        <input type="password" id="password" name="password"><br>
        <span id="passwordError" class="error-message"></span><br>

        <input type="submit" value="Login">
    </form>
</div>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
    var status = document.getElementById("status").value;
    if (status === "failed") {
        swal("Sorry", "Wrong Username or Password", "error");
    }

    // Function to validate the form fields
    function validateForm() {
        var username = document.getElementById("userName").value.trim();
        var password = document.getElementById("password").value.trim();
        var isValid = true;

        // Reset previous error messages
        document.getElementById("usernameError").innerText = "";
        document.getElementById("passwordError").innerText = "";

        // Check if the username is empty
        if (username === "") {
            document.getElementById("usernameError").innerText = "Username should not be empty";
            isValid = false;
        }

        // Check if the password is empty
        if (password === "") {
            document.getElementById("passwordError").innerText = "Password should not be empty";
            isValid = false;
        }

        return isValid; // If isValid is true, the form will be submitted; otherwise, it won't
    }
</script>

</body>
</html>
