package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class UserRemoveFormAction implements CommandProcess {

	
	
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null : session.getAttribute("id").toString();
			
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			
			request.setAttribute(id, "id");
			request.setAttribute("pageSet", "userRemoveForm.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/mall/cheapmall.jsp";
		
	}

}
