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


@WebServlet("/ExcelDataUpload")
@MultipartConfig
public class ExcelDataUpload extends HttpServlet {
	
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
		
			 Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
	            InputStream fileContent = filePart.getInputStream();
	            System.out.println(fileContent);
			 PreparedStatement statement=connection.prepareStatement("insert into Users values(?,?,?,?,?)");
			 BufferedReader lineReader=new BufferedReader(new InputStreamReader(fileContent));

	            String lineText=null;
	            int count=0;
	            int batchSize=20;
	            lineReader.readLine();
	            while ((lineText=lineReader.readLine())!=null){
	                String[] data=lineText.split(",");

	                String voterID=data[0];
	                String dob=String.valueOf(data[1]);
	                String taluk=data[2];
	                int ward=Integer.parseInt(data[3]);
	              

	                statement.setString(1,voterID);
	                statement.setString(2,dob);
	                statement.setString(3,taluk);
	                statement.setInt(4,ward);
	                
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
	        	request.setAttribute("status3", "success");
	        	dispatcher.forward(request, response);

	}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			
		}
	}

}
