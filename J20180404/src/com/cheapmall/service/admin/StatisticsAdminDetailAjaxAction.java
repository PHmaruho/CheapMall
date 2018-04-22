package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class StatisticsAdminDeatilAjaxAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String auth = session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
					
			if(auth == null) {
				return "adminLoginForm.jsp";
			}
			
			String type = request.getParameter("type");
			if (type.equals("op1")) {
				
			} else if (type.equals("op2")) {
				
			} else if (type.equals("op3")) {
				
			} else if (type.equals("op4")) {
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "statisticsAdminDeatilAjax.jsp";
	}
}
