<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

if(session.getAttribute("voterId").equals("null")){
	response.sendRedirect("userLogin.jsp");
}
String voterId=String.valueOf(session.getAttribute("voterId"));
String dob=String.valueOf(session.getAttribute("dob"));
String taluk=String.valueOf(session.getAttribute("taluk"));
String ward=String.valueOf(session.getAttribute("ward"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Voter Details</title>
    <!-- Link to External CSS -->
    <link rel="stylesheet" type="text/css" href="styles/userindexstyle.css">
</head>
<body>
<input type="hidden" id="status" value="<%= request.getAttribute("status1") %>">


<div class="voter-info">
    <div class="voter-left">
        <div>VOTER ID: <% out.print(voterId); %></div>
        <div>DOB: <% out.print(dob); %></div>
    </div>
    <div class="voter-right">
        <div>TALUK: <% out.print(taluk); %></div>
        <div>WARD: <% out.print(ward); %></div>
    </div>
</div>


<!-- SQL Query and Candidate Table -->
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
Connection con = null;
PreparedStatement ps = null;
PreparedStatement pst = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineVotingSystem?useSSL=false&requireSSL=false", "root", "PooraniV@21");

    ps = con.prepareStatement("select voting from Users where voterId=? and dob=?");
    ps.setString(1, voterId);
    ps.setString(2, dob);
    rs = ps.executeQuery();

    if (rs.next() && rs.getString("voting") == null) {
        pst = con.prepareStatement("select * from candidate where candidate.taluk=?");
        pst.setString(1, taluk);
        rs = pst.executeQuery();
%>
       <form action="Voting" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="dob"  value="<% out.print(dob); %>">
            <input type="hidden" name="voterId"  value="<% out.print(voterId); %>">
            
            <!-- Candidate Table Centered -->
            <div class="candidate-table">
            <table border="1">
            <tr>
            <th>S.no</th>
            <th>Candidate Name</th>
            <th>Party</th>
            <th>Select</th>
            </tr>
        <!-- Loop through candidates -->
            <% 
                    int i = 1;
                    while (rs.next()) {
                    %>
                    <tr>
                        <td><%= i %></td>
                        <td><%= rs.getString(2) %></td>
                        <td><%= rs.getString(3) %></td>
                        <td><input type="radio" name="party" value="<%= rs.getInt(1) %>"></td>
                    </tr>
                    <%
                        i++;
                    }
             %>
    </table>
</div>
            <input type="submit">
        </form>
<%
    } else {
    %>
  	<div style="color: black; background-color: rgba(255, 255, 255, 0.7); text-align: center; padding: 10px; margin: 140px auto 0 ; width: 30%; border-radius: 5px; font-size: 23px;">
        <p>You have already Voted!</p>
        </div>




    <% 
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
    var status = document.getElementById("status1").value;
   if(status === "success") {
        swal("Success", "Voted Successfully", "success");
    }
    if (status === "failed") {
        swal("Sorry", "Voted is not Submitted", "success");
    }
   
    function validateForm() {
        // Check if any radio button is selected
        var radios = document.getElementsByName("party");
        var isChecked = false;

        // Loop through the radio buttons to see if one is selected
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                isChecked = true;
                break;
            }
        }

        if (!isChecked) {
            alert("Please select a candidate before submitting your vote.");
            return false;  // Prevent form submission
        }

        return true;  // Allow form submission
    }

</script>

</body>
</html>

