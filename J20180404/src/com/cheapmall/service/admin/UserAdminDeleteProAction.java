package com.cheapmall.service.admin;

import java.io.IOException;




import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserAdminDeleteProAction implements CommandProcess{

	
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession session=request.getSession();
		String id=session.getAttribute("id").toString();
		
		String check=request.getParameter("del");

		try {
			int result=0;
			MemberDao dao=MemberDao.getInstance();
			result= dao.deleteUser(check);
			
			
			request.setAttribute("result", result);
			request.setAttribute("pageSet", "/admin/userAdminDeletePro.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/mall/cheapmall.jsp";
	
	}

}
