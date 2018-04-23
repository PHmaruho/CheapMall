package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.service.CommandProcess;

public class SearchManagerFormAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			// HttpSession session = request.getSession(); // 가져올것
			
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("SearchManagerFormAction Error");
			e.printStackTrace();
		}
		
		return "searchManagerForm.jsp";
	}
}
