package controller.api;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.fasterxml.jackson.databind.ObjectMapper;

import controller.Controller;
import dao.member.MemberDao;

public class ApiCheckIdController implements Controller{
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ObjectMapper objmapper = new ObjectMapper();
		MemberDao memberDao = MemberDao.getInstance();
		boolean result = memberDao.isExistId(request.getParameter("id"));
		
		Map<String,Boolean> data = new HashMap<>();
		data.put("isExist", result);
		String jsonData = objmapper.writeValueAsString(data);
		
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.print(jsonData);
		
	}

}
