package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.GoodsDao;
import com.cheapmall.service.CommandProcess;

public class CodeCheckAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("id");
		System.out.println("code : "+code);
		GoodsDao gd = GoodsDao.getInstance();
		int result = gd.checkCode(code);
		System.out.println("result : "+result);
		request.setAttribute("result", result);

		return "codeCheck.jsp";
	}

}