package user;

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


@WebServlet("/Voting")
public class Voting extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String voterId=request.getParameter("voterId");
		String dob=request.getParameter("dob");
		String voting=request.getParameter("party");
		RequestDispatcher dispatcher=null;
		Connection con=null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			 con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineVotingSystem?useSSL=false","root","PooraniV@21");
			 PreparedStatement pst=con.prepareStatement("update Users set voting=? where voterId=? and dob=?");
			 pst.setString(1,voting);
				pst.setString(2,voterId);
				pst.setString(3,dob);
			int rowCount=pst.executeUpdate();
			dispatcher=request.getRequestDispatcher("userIndex.jsp");
			if(rowCount>0) {
				request.setAttribute("status", "success");
				
			}
			else {
				request.setAttribute("status", "failed");
				
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