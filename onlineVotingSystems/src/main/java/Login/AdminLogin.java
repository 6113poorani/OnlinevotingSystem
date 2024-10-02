package Login;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher=null;
		String userName=request.getParameter("userName");
		String password=request.getParameter("password");
		if(userName.equals("Government")&&password.equals("Voting@TN21")) {
			System.out.println("sucess");
			 dispatcher=request.getRequestDispatcher("adminIndex.jsp");
		}
		else {
			System.out.println("fail");
			request.setAttribute("status", "failed");
			 dispatcher=request.getRequestDispatcher("adminLogin.jsp");
		}
		dispatcher.forward(request, response);
	}

}
