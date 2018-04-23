package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class AdminMenuListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id").toString();
			String auth =session.getAttribute("auth").toString();
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("AdminMenuListAction Error");
			e.printStackTrace();
		}
		
		
		return "adminMenuList.jsp";
	}

}
