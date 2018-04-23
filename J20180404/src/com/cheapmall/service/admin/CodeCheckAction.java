package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.service.CommandProcess;

public class CodeCheckAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
		
		if(auth == null) {
			session.invalidate();
			return "Admin.jsp";
		}
		String code = request.getParameter("id");
		GoodsDao gd = GoodsDao.getInstance();
		int result = gd.checkCode(code);
		request.setAttribute("result", result);

		return "codeCheck.jsp";
	}

}