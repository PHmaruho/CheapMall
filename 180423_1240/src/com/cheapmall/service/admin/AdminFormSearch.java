package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.service.CommandProcess;

public class AdminFormSearch implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		return "adminFormSearch.jsp";
	}

}
