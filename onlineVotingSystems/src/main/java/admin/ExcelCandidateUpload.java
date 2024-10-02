package admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


@WebServlet("/ExcelCandidateUpload")
@MultipartConfig
public class ExcelCandidateUpload extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection connection=null;
		RequestDispatcher dispatcher=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineVotingSystem?useSSL=false&requireSSL=false","root","PooraniV@21");
			
			 Part filePart = request.getPart("file"); 
	            InputStream fileContent = filePart.getInputStream();
	            System.out.println(fileContent);
			 PreparedStatement statement=connection.prepareStatement("insert into candidate values(?,?,?,?)");
			 BufferedReader lineReader=new BufferedReader(new InputStreamReader(fileContent));

	            String lineText=null;
	            int count=0;
	            int batchSize=20;
	            lineReader.readLine();
	            while ((lineText=lineReader.readLine())!=null){
	                String[] data=lineText.split(",");

	                int partyId=Integer.parseInt(data[0]);
	                String candidateName=String.valueOf(data[1]);
	                String partyName=data[2];
	                String taluk=data[3];
	                
	               

	                statement.setInt(1,partyId);
	                statement.setString(2,candidateName);
	                statement.setString(3,partyName);
	                statement.setString(4,taluk);
	                
	                statement.addBatch();
	                if(count%batchSize==0){
	                    statement.executeBatch();
	                }
	            }
	            lineReader.close();
	            statement.executeBatch();
	            connection.close();
	            System.out.println("Data has been inserted successfully.");
	        	dispatcher=request.getRequestDispatcher("adminIndex.jsp");
	        	request.setAttribute("status4", "success");
	        	dispatcher.forward(request, response);

	}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			
		}
	}

}
