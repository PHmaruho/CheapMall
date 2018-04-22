package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class StatisticsAdminDeatilAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String auth = session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
					
			if(auth == null) {
				return "adminLoginForm.jsp";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
