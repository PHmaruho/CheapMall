package com.cheapmall.service.admin;

import java.io.IOException;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserAdminDeleteAction implements CommandProcess{

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String check=request.getParameter("del");

		try {
			int result=0;
			MemberDao dao=MemberDao.getInstance();
			result= dao.deleteUser(check);
			
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/admin/userAdminDeletePro.jsp";
	
	}

}
