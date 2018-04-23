package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.service.CommandProcess;

public class AdminLoginFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	/*	String id = request.getAttribute("id").toString();
		String pw = request.getAttribute("pw").toString();
		request.setAttribute("id", id);
		request.setAttribute("pw", pw);*/
		
		return "adminLoginForm.jsp";	
		
	}

}
