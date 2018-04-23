package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserFindPwResultProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			String pw = request.getParameter("pw1");
			
			MemberDao memberDao = MemberDao.getInstance();
			int result = memberDao.updatePw(id, email, pw);
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageSet", "/mall/userFindPwResultPro.jsp");
		return "/mall/cheapmall.jsp";
	}
}
