<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <link rel="stylesheet" type="text/css" href="styles/userloginstyle.css">
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">

<div class="login-container">
    <h2>User Login</h2>
    <form name="userLoginForm" action="UserLogin" method="post" onsubmit="return validateForm()">
        <label for="VoterId">Voter ID</label>
        <input type="text" id="voterId" name="VoterId"><br>
        <span id="voterIdError" class="error-message"></span><br>

        <label for="DOB">DOB</label>
        <input type="date" id="dob" name="DOB"><br>
        <span id="dobError" class="error-message"></span><br>

        <input type="submit" value="Login">
    </form>
</div>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
    var status = document.getElementById("status").value;
    if (status === "failed") {
        swal("Sorry", "Wrong Voter ID or DOB", "error");
    }

    // Function to validate the form fields
    function validateForm() {
        var voterId = document.getElementById("voterId").value.trim();
        var dob = document.getElementById("dob").value.trim();
        var isValid = true;

        // Reset previous error messages
        document.getElementById("voterIdError").innerText = "";
        document.getElementById("dobError").innerText = "";

        // Check if the Voter ID is empty
        if (voterId === "") {
            document.getElementById("voterIdError").innerText = "Voter ID should not be empty";
            isValid = false;
        }

        // Check if the DOB is empty
        if (dob === "") {
            document.getElementById("dobError").innerText = "DOB should not be empty";
            isValid = false;
        }

        return isValid; // If isValid is true, the form will be submitted; otherwise, it won't
    }
</script>

</body>
</html>
