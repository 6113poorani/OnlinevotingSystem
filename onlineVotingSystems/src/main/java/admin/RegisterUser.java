package admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/RegisterUser")
public class RegisterUser extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String voterId=request.getParameter("voterId");
		String dob=request.getParameter("dob");
		String taluk=request.getParameter("taluk");
		String ward=request.getParameter("ward");
		
		
		
		
		RequestDispatcher dispatcher=null;
			Connection con=null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				 con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineVotingSystem?useSSL=false","root","PooraniV@21");
				 PreparedStatement pst=con.prepareStatement("insert into Users(voterId,dob,taluk,ward) values(?,?,?,?)");
				 pst.setString(1,voterId);
					pst.setString(2,dob);
					pst.setString(3,taluk);
					pst.setString(4,ward);
				int rowCount=pst.executeUpdate();
				dispatcher=request.getRequestDispatcher("adminIndex.jsp");
				if(rowCount>0) {
					request.setAttribute("status1", "success");
					
				}
				else {
					request.setAttribute("status1", "failed");
					
				}
				dispatcher.forward(request, response);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			finally {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
	}
}