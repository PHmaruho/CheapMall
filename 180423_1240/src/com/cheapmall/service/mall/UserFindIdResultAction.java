package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserFindIdResultAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			MemberDao memberDao = MemberDao.getInstance();
			String nm = request.getParameter("nm");
			String email = request.getParameter("email");
			String id = memberDao.selectId(nm, email);
			
			request.setAttribute("id", id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageSet", "/mall/userFindIdResult.jsp");
		return "/mall/cheapmall.jsp";
	}
}
