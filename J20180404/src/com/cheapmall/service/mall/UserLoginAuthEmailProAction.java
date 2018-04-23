package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserLoginAuthEmailProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
			
			MemberDao memberDao = MemberDao.getInstance();
			int result = memberDao.authGrade(id);
			
			request.setAttribute("pageSet", "/mall/userLoginPro.jsp");
			request.setAttribute("result", result);
			//request.setAttribute("pageSet", "/mall/userLoginAuthEmail.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mall/cheapmall.jsp";
	}
}
