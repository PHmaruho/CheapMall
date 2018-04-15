package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class UserLoginFormAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");
			if(id != null) {
				System.out.println(id);
			}
			
			String gender = request.getParameter("gender") == null ? "" : request.getParameter("gender");
			String top_category = request.getParameter("top_category") == null ? "" : request.getParameter("top_category");
			String middle_category = request.getParameter("middle_category") == null ? "" : request.getParameter("middle_category");
			
			request.setAttribute("gender", gender);
			request.setAttribute("top_category", top_category);
			request.setAttribute("middle_category", middle_category);
			//
			request.setAttribute("pageSet", "userLoginForm.jsp");
		} catch (Exception e) {
			// TODO: handle exception
		}
		//
		return "cheapmall.jsp";
	}
}
