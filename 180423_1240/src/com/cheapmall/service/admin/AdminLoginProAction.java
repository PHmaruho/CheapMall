package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class AdminLoginProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		MemberDao md = MemberDao.getInstance();
		try {
			String id = request.getParameter("id");
			String pw= request.getParameter("pw");
	//		String auth = request.getParameter("auth");
			String result = md.check(id, pw);
			request.setAttribute("id", id);
			request.setAttribute("pw", pw);
			request.setAttribute("auth", result);
			
			request.setAttribute("result", result);
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "adminLoginPro.jsp";
		
				//"adminLoginPro.jsp";
		//AdminMenuList.admin
	}


}
