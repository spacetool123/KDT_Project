package controller.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import controller.Controller;



// new RequestKeyValue("/auth/cert/sms", "GET") 
public class AuthCertSMSController implements Controller {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//View 
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("../sms.jsp");
		dispatcher.forward(request, response);

	}

}
