package Login;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String voterID = request.getParameter("VoterId");
	    String dob = request.getParameter("DOB");
	    RequestDispatcher dispatcher = null;

	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineVotingSystem?useSSL=false&requireSSL=false", "root", "PooraniV@21");
	             PreparedStatement pst = con.prepareStatement("select * from Users where voterId=? and dob=?")) {
	            
	            pst.setString(1, voterID);
	            pst.setString(2, dob);
	            
	            try (ResultSet rs = pst.executeQuery()) {
	                if (rs.next()) {
	                    HttpSession session = request.getSession();
	                    session.setAttribute("voterId", rs.getString("voterId"));
	                    session.setAttribute("dob", rs.getString("dob"));
	                    session.setAttribute("taluk", rs.getString("taluk"));
	                    session.setAttribute("ward", rs.getString("ward"));

	                    dispatcher = request.getRequestDispatcher("userIndex.jsp");
	                } else {
	                    request.setAttribute("status", "failed");
	                    dispatcher = request.getRequestDispatcher("userLogin.jsp");
	                }
	                dispatcher.forward(request, response);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	}


