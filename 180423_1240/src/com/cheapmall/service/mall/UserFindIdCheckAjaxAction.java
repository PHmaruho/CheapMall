package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserFindIdCheckAjaxAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String nm = request.getParameter("nm");
			String email = request.getParameter("email");
			MemberDao memberDao = MemberDao.getInstance();
			
			int result = memberDao.checkIdToFind(nm, email);
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "userFindIdCheckAjax.jsp";
	}
}
