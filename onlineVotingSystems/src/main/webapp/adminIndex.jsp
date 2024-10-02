<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<link rel="stylesheet" href="styles/adminindexstyle.css">
</head>
<body>

<input type="hidden" id="status1" value="<%= request.getAttribute("status1") %>">
<input type="hidden" id="status2" value="<%= request.getAttribute("status2") %>">
<input type="hidden" id="status3" value="<%= request.getAttribute("status3") %>">
<input type="hidden" id="status4" value="<%= request.getAttribute("status4") %>">
<div class="container">
      
        <div class="sidebar">
            <img src="https://w7.pngwing.com/pngs/922/214/png-transparent-computer-icons-avatar-businessperson-interior-design-services-corporae-building-company-heroes-thumbnail.png" alt="Admin Profile" class="profile-img">
            <ul>
             <li><a href="#" id="viewDetailslink">View Details</a></li>
                <li><a href="#" id="addUserLink">Add User</a></li>
                <li><a href="#" id="addCandidateLink">Add Candidate</a></li>
                <li><a href="#" id="viewResultLink">View Result</a></li>
                  <li><a href="index.jsp" onclick="return confirmLogout()">Logout</a></li>
               
            </ul>
        </div>

        <!-- Main content area -->
        <div class="main-content" id="mainContent">
        <div id="govtHeading" class="govt-heading" style="display:none;">
        <div class="box">
        <h1>GOVERNMENT OF TAMILNADU</h1>
  
        
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
Connection connection = null;
PreparedStatement pst = null;
ResultSet rst = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineVotingSystem?useSSL=false&requireSSL=false", "root", "PooraniV@21");

    pst = connection.prepareStatement("SELECT COUNT(DISTINCT taluk) AS uniqueTaluks FROM candidate;");
    rst = pst.executeQuery();
    if(rst.next()){
    %>
    <h3>No.Of.Taluks : <%= rst.getString(1) %></h3>
    <% }
    pst = connection.prepareStatement("SELECT COUNT(DISTINCT partyName) AS totalParties FROM candidate;");
    rst = pst.executeQuery();
    if(rst.next()){
    %>
    <h3>No.Of.Parties : <%= rst.getString(1) %></h3>
    <% }
    pst = connection.prepareStatement("SELECT COUNT(*) AS totalCandidates FROM candidate;");
    rst = pst.executeQuery();
    if(rst.next()){
    %>
    <h3>No.Of.Candidates : <%= rst.getString(1) %></h3>
    <% }
    pst = connection.prepareStatement("SELECT COUNT(*) FROM Users;");
    rst = pst.executeQuery();
    if(rst.next()){
    %>
    <h3>No.Of.People : <%= rst.getString(1) %></h3>
    <% }
    
  

  
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (connection != null) {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
  </div>
</div>
       
            <!-- Add User Form -->
          
          <form id="addUserForm" style="display:none;" action="RegisterUser" method="post" onsubmit="return validateUserForm()">
    <h2>Register User</h2>
    Voter Id : <input type="text" name="voterId" id="voterId"><br>
    <span id="voterIdError" class="error-message"></span><br>
    DOB : <input type="date" name="dob" id="dob"><br>
    <span id="dobError" class="error-message"></span><br>
    Taluk Name : <input type="text" name="taluk" id="taluk"><br>
    <span id="talukError" class="error-message"></span><br>
    Ward Number: <input type="text" name="ward" id="ward"><br>
    <span id="wardError" class="error-message"></span><br>
    <input type="submit" value="Register">
</form>

         
	<form id="fileUploadForm" style="display:none;" action="ExcelDataUpload" method="POST" enctype="multipart/form-data" onsubmit="return validateUserFile()">
            <label for="file">Choose CSV File:</label>
            <input type="file" id="file" name="file" accept=".csv" >
            <br><br>
            <button type="submit">Upload</button>
        </form>


            <!-- Add Candidate Form -->
            <form id="addCandidateForm" style="display:none;" action="RegisterCandidate" method="post" onsubmit="return validateCandidateForm()">
    <h2>Register Candidate</h2>
    Candidate Name: <input type="text" name="candidateName" id="candidateName"><br>
    <span id="candidateNameError" class="error-message"></span><br>
    Party Name: <input type="text" name="party" id="party"><br>
    <span id="partyError" class="error-message"></span><br>
    Taluk: <input type="text" name="taluk" id="talukc"><br>
    <span id="talukcError" class="error-message"></span><br>
    <input type="submit" value="Register">
</form>

            
               <form id="fileCandidateUploadForm" style="display:none;" action="ExcelCandidateUpload" method="POST" enctype="multipart/form-data" onsubmit="return validateCandidateFile()">
            <label for="file">Choose CSV File:</label>
            <input type="file" id="file" name="file" accept=".csv" >
            <br><br>
            <button type="submit">Upload</button>
        </form>

            <!-- View Result Section -->
            <div id="viewResult" style="display:none;">
                <h2>View Results</h2>
                <%@ page import="java.sql.*"  %>
<%@ page import="admin.Excel"  %>
<%@ page import="java.util.*"  %>
<%
ResultSet rs=null;
Connection  con=null;
PreparedStatement ps=null;
String query="SELECT c.candidateName, c.partyName, u.taluk, u.ward, COUNT(*) AS totalVotes FROM Users u JOIN Candidate c ON u.voting = c.partyId AND u.taluk=c.taluk  WHERE u.voting IS NOT NULL   GROUP BY c.candidateName, c.partyName, u.taluk, u.ward ORDER BY u.taluk, u.ward";
ArrayList<Excel> voting=new ArrayList<Excel>();

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineVotingSystem?useSSL=false&requireSSL=false","root","PooraniV@21");
	 ps=con.prepareStatement(query);
	 
	 rs=ps.executeQuery();
	 int i=0;
	 while(rs.next()){
		
			
		 String candidate_Name=rs.getString(1);
		 String party_Name=rs.getString(2);
		 String taluk=rs.getString(3);
		 int ward=rs.getInt(4);
		 int total_votes=rs.getInt(5);
		 
		voting.add(new Excel(candidate_Name,party_Name, taluk,ward,total_votes));
		
		
		
	 }
	
}
catch(Exception e){
	out.print(e);
}
session.setAttribute("exl", voting);
%>
<a href="reports.jsp">Reports </a>
                
                
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
Connection conn = null;
PreparedStatement pss = null;
ResultSet rss = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineVotingSystem?useSSL=false&requireSSL=false", "root", "PooraniV@21");

    pss = conn.prepareStatement("SELECT  c.candidateName,  c.partyName,  u.taluk,  COUNT(u.voting) AS Votecount FROM  Users u JOIN  candidate c ON c.partyId = u.voting AND c.taluk=u.taluk	GROUP BY u.taluk, c.candidateName, c.partyName HAVING  COUNT(u.voting) = ( SELECT MAX(VoteCount) FROM (SELECT COUNT(voting) AS VoteCount FROM Users  WHERE taluk = u.taluk GROUP BY voting ) AS TalukVotes ) ORDER BY u.taluk;");
    rss = pss.executeQuery();
    %>
	<table >
	<tr><th>S.no</th><th>Candidate Name </th><th>Party Name </th><th>Taluk Name </th><th>Vote Count </th></tr>
	
	<% 
    int i = 1;
    while (rss.next()) {
        %>
        <tr>
         <td><%= i %></td>
            <td><%= rss.getString(1) %></td>
            <td><%= rss.getString(2) %></td>
            <td><%= rss.getString(3) %></td>
             <td><%= rss.getString(4) %></td>
             
        </tr>
        <%
        i++;
    }
    %>
     </table>
	
    <% 
	
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
                
               
            </div>
        </div>
    </div>

  <script>
    function hideGovtHeading() {
        document.getElementById("addUserForm").style.display = "none";
        document.getElementById("fileUploadForm").style.display = "none"; // Hide file upload form
        document.getElementById("fileCandidateUploadForm").style.display = "none"; 
        document.getElementById("addCandidateForm").style.display = "none";
        document.getElementById("viewResult").style.display = "none";
        document.getElementById("govtHeading").style.display = "none";
    }

    document.getElementById("addUserLink").addEventListener("click", function() {
        hideGovtHeading();
        document.getElementById("addUserForm").style.display = "block";
        document.getElementById("fileUploadForm").style.display = "block"; // Show file upload form when Add User is clicked
        document.getElementById("mainContent").style.backgroundImage = "url('https://st2.depositphotos.com/1071909/9791/i/450/depositphotos_97919904-stock-photo-data-management-and-document-management.jpg')";
        document.getElementById("mainContent").style.backgroundSize = "cover";
        document.getElementById("mainContent").style.backgroundPosition = "center";
    });

    document.getElementById("addCandidateLink").addEventListener("click", function() {
        hideGovtHeading();
        document.getElementById("addCandidateForm").style.display = "block";
        document.getElementById("fileCandidateUploadForm").style.display = "block"; 
        document.getElementById("mainContent").style.backgroundImage = "url('https://cdn.prod.website-files.com/63edbb9dbbc5991c8d328c5a/6655da754d300b3e5fa8d687_Candidate%20Screening%20via%20Social%20Media%20(1).jpeg')";
        document.getElementById("mainContent").style.backgroundSize = "cover";
        document.getElementById("mainContent").style.backgroundPosition = "center";
    });

    document.getElementById("viewResultLink").addEventListener("click", function() {
        hideGovtHeading();
        document.getElementById("viewResult").style.display = "block";
        document.getElementById("mainContent").style.backgroundImage = "url('https://png.pngtree.com/thumb_back/fh260/background/20220506/pngtree-job-candidate-won-and-stand-in-spotlight-with-cup-image_1289910.jpg')";
        document.getElementById("mainContent").style.backgroundSize = "cover";
        document.getElementById("mainContent").style.backgroundPosition = "center";
    });

    document.getElementById("viewDetailslink").addEventListener("click", function () {
        hideGovtHeading();
        document.getElementById("govtHeading").style.display = "block";
        document.getElementById("mainContent").style.backgroundImage = "url('https://st4.depositphotos.com/1144687/39499/i/450/depositphotos_394998310-stock-photo-social-network-theme-hologram-with.jpg')";
        document.getElementById("mainContent").style.backgroundSize = "cover";
        document.getElementById("mainContent").style.backgroundPosition = "center";
    });

    document.getElementById("mainContent").style.backgroundImage = "url('https://image.nakkheeran.in/cdn/farfuture/My1k-509zi4op9hBTnELncfbFTK4Wu7gT8KdcIf6vfU/1559727334/sites/default/files/2019-06-05/tnlogo.jpg')";
</script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
    var status1 = document.getElementById("status1").value;
    var status2 = document.getElementById("status2").value;
    var status3 = document.getElementById("status3").value;
    var status4 = document.getElementById("status4").value;
    if (status1 === "success") {
        swal("Success", "User Added Successfully", "success");
    }
    if (status1 === "failed") {
        swal("Sorry", "Something Wrong", "error");
    }
    if (status2 === "success") {
        swal("Success", "Candidate Added Successfully", "success");
    }
    if (status2 === "failed") {
        swal("Sorry", "Something Wrong", "error");
    }
    if (status3 === "success") {
        swal("Success", "User Added Successfully", "success");
    }
    if (status4 === "success") {
        swal("Success", "Candidate Added Successfully", "success");
    }
    
    function validateUserForm() {
        var voterId = document.getElementById("voterId").value.trim();
        var dob = document.getElementById("dob").value.trim();
        var taluk = document.getElementById("taluk").value.trim();
        var ward = document.getElementById("ward").value.trim();
        
        var isValid = true;

        // Reset previous error messages
        document.getElementById("voterIdError").innerText = "";
        document.getElementById("dobError").innerText = "";
        document.getElementById("talukError").innerText = "";
        document.getElementById("wardError").innerText = "";

        // Check if voterId is empty
        if (voterId === "") {
            document.getElementById("voterIdError").innerText = "Voter ID should not be empty";
            isValid = false;
        }

        // Check if dob is empty
        if (dob === "") {
            document.getElementById("dobError").innerText = "DOB should not be empty";
            isValid = false;
        }
        if (taluk === "") {
            document.getElementById("talukError").innerText = "Taluk should not be empty";
            isValid = false;
        }
        if (ward === "") {
            document.getElementById("wardError").innerText = "Ward should not be empty";
            isValid = false;
        }
			console.log(isValid);
        return isValid; // If isValid is true, the form will be submitted; otherwise, it won't
    }

    function validateCandidateForm() {
        var candidateName = document.getElementById("candidateName").value.trim();
        var party = document.getElementById("party").value.trim();
        var talukc = document.getElementById("talukc").value.trim();
        
        var isValid = true;

        // Reset previous error messages
        document.getElementById("candidateNameError").innerText = "";
        document.getElementById("partyError").innerText = "";
        document.getElementById("talukcError").innerText = "";

        // Check if candidateName is empty
        if (candidateName === "") {
            document.getElementById("candidateNameError").innerText = "Candidate Name should not be empty";
            isValid = false;
        }

        // Check if party is empty
        if (party === "") {
            document.getElementById("partyError").innerText = "Party should not be empty";
            isValid = false;
        }
        if (talukc === "") {
            document.getElementById("talukcError").innerText = "Taluk should not be empty";
            isValid = false;
        }

        return isValid; // If isValid is true, the form will be submitted; otherwise, it won't
    }

    
    function validateUserFile() {
        // Get file input element
        var fileInput = document.getElementById("file");
        var filePath = fileInput.value;

        // Check if any file is selected
        if (filePath === "") {
            alert("Please select a file to upload.");
            return false;
        }

        // Get the file extension
        var allowedExtensions = /(\.csv)$/i;
        if (!allowedExtensions.exec(filePath)) {
            alert("Please upload a valid CSV file.");
            fileInput.value = "";  // Clear the file input for another selection
            return false;
        }

        // If validation passes, allow form submission
        return true;
    }
    

    function validateCandidateFile() {
        // Get file input element
        var fileInput = document.getElementById("file");
        var filePath = fileInput.value;

        // Check if any file is selected
        if (filePath === "") {
            alert("Please select a file to upload.");
            return false;
        }

        // Get the file extension
        var allowedExtensions = /(\.csv)$/i;
        if (!allowedExtensions.exec(filePath)) {
            alert("Please upload a valid CSV file.");
            fileInput.value = "";  // Clear the file input for another selection
            return false;
        }

        // If validation passes, allow form submission
        return true;
    }
    
    function confirmLogout() {
        var confirmLogout = window.confirm("Are you sure you want to log out?");
        if (confirmLogout) {
            return true;
        } else {
           return false;
        }
    }

</script>


</body>
</html>

