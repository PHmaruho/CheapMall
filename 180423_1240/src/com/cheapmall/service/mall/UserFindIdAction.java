package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.service.CommandProcess;
import com.cheapmall.service.SendEmail;

public class UserFindIdAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("pageSet", "/mall/userFindId.jsp");
		return "/mall/cheapmall.jsp";
	}
}

