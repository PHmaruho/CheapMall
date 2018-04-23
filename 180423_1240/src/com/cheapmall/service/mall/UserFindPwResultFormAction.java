package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserFindPwResultFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			
			request.setAttribute("id", id);
			request.setAttribute("email", email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageSet", "/mall/userFindPwResultForm.jsp");
		return "/mall/cheapmall.jsp";
	}
}
